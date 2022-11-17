import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:sebastian/data/lcu/lcu_service.dart';
import 'package:flutter/foundation.dart' show kDebugMode;

import 'package:path/path.dart' as path;

import 'package:sebastian/data/lcu/models/item_build.dart';
import 'package:sebastian/data/lcu/lcu_path_storage.dart';
import 'package:sebastian/data/utils/proccess.dart';

class NoLockFilePathException implements Exception {}

class LockFileNotFoundException implements Exception {}

class LCU {
  final LcuPathStorage _lcuStore;

  LCU(this._lcuStore);

  LcuService? _service;

  late int _port;
  late HttpClient _restClient;
  late WebSocket _websocket;
  late Stream<dynamic> _broadcastWebsocket;

  late String _authHeader;
  late Directory _lolDirectory;

  LcuService get service => _service != null ? _service! : throw Exception('Lcu unitialized');

  Future<void> init() async {
    var savedLockfile = _lcuStore.getLcuLockfile();

    if (savedLockfile == null) {
      if (await _tryFindRunningLolDirectory()) {
        savedLockfile = _lcuStore.getLcuLockfile();
      } else {
        throw NoLockFilePathException();
      }
    }

    if (!savedLockfile!.existsSync()) {
      throw LockFileNotFoundException();
    }

    _lolDirectory = savedLockfile.parent;

    String content = savedLockfile.readAsStringSync();
    List<String> args = content.split(':');
    final authKey = args[3];
    _port = int.parse(args[2]);

    if (authKey == '' || _port == -1) {
      throw 'Чота не удалось прочитать';
    }

    if (kDebugMode) {
      print('lockfile = auth:$authKey port:$_port');
    }

    _restClient = HttpClient();
    _authHeader = 'Basic ${utf8.fuse(base64).encode('riot:$authKey')}';

    _websocket = await WebSocket.connect(
      'wss://127.0.0.1:$_port',
      headers: {'Authorization': _authHeader},
      customClient: _restClient,
    );

    _broadcastWebsocket = _websocket.asBroadcastStream();

    _service = LcuService(_restClient, '127.0.0.1:$_port', _authHeader);
  }

  Future<bool> _tryFindRunningLolDirectory() async {
    if (Platform.isWindows) {
      final lolExeFile = await findExePathByProcessName('LeagueClientUx.exe');
      if (lolExeFile == null) return false;

      final lockfile = await getLockfileFromLolDirectory(lolExeFile.parent);
      if (lockfile != null) {
        await _lcuStore.putLcuLockfilePath(lockfile.path);
        return true;
      }
    } else if (Platform.isMacOS) {
      final defaultLolDirectory = Directory('/Applications/League of Legends.app/Contents/LoL');

      if (!defaultLolDirectory.existsSync()) return false;

      final lockfile = File(path.join(defaultLolDirectory.path, 'lockfile'));
      await _lcuStore.putLcuLockfilePath(lockfile.path);
      return true;
    }

    return false;
  }

  Future<File?> getLockfileFromLolDirectory(Directory directory) async {
    bool foundLolClients = false;
    File? lockfileFile;

    await for (final FileSystemEntity f in directory.list()) {
      if (f is File) {
        switch (path.basename(f.path)) {
          case 'lockfile':
            lockfileFile = f;
            break;
          case 'LeagueClient.exe':
          case 'LeagueClientUx.exe':
            foundLolClients = true;
            break;
        }
      }
    }

    if (lockfileFile == null) {
      if (!foundLolClients) {
        return null;
      }

      // LeagueClient offline so there is no Lockfile right now but directory is valid
      lockfileFile = File(path.join(directory.path, 'lockfile'));
    }

    return lockfileFile;
  }

  Future<void> saveBuildFile(ItemBuild build) async {
    final buildsFilePath = path.join(_lolDirectory.path, 'Config', 'Global', 'Recommended', '#sebastian_build.json');
    final buildsFile = File(buildsFilePath);
    if (!await buildsFile.exists()) {
      await buildsFile.create(recursive: true);
    }

    await buildsFile.writeAsString(json.encode(build.toJson()));
  }

  Stream<dynamic> subscribeToChampSelectEvent() {
    const eventName = 'OnJsonApiEvent_lol-champ-select_v1_session';
    _websocket.add('[5, "$eventName"]');
    return _websocketEvent(eventName);
  }

  Stream<dynamic> subscribeToEndOfGameEvent() {
    const eventName = 'OnJsonApiEvent_lol-gameflow_v1_gameflow-phase';
    _websocket.add('[5, "$eventName"]');
    return _websocketEvent(eventName);
  }

  Stream<dynamic> _websocketEvent(String eventName) {
    return _broadcastWebsocket
        .map((event) {
          if (event.isEmpty) return null;

          if (kDebugMode) {
            print("LCUEvent: $event");
          }

          final jsonEvent = json.decode(event);

          if (jsonEvent is! List) return null;

          return jsonEvent;
        })
        .where((event) => event?.elementAt(1) == eventName)
        .map((event) => event?.elementAt(2));
  }

  void close() {
    _websocket.close();
    _restClient.close();
  }
}
