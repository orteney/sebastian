import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:path/path.dart' as path;
import 'package:rxdart/rxdart.dart';

import 'package:sebastian/data/lcu/lcu_errors.dart';
import 'package:sebastian/data/lcu/lcu_path_storage.dart';
import 'package:sebastian/data/lcu/lcu_service.dart';
import 'package:sebastian/data/lcu/models/item_build.dart';
import 'package:sebastian/data/utils/proccess.dart';

export 'lcu_errors.dart';

const _pickSessionEvent = 'OnJsonApiEvent_lol-champ-select_v1_session';
const _gameFlowStateEvent = 'OnJsonApiEvent_lol-gameflow_v1_gameflow-phase';
const _matchmakingEvent = 'OnJsonApiEvent_lol-matchmaking_v1_ready-check';

class LCU {
  static const macosFileExtension = 'app';

  final LcuPathStorage _lcuStore;

  LCU(this._lcuStore);

  LcuService? _service;

  late int _port;
  late HttpClient _restClient;
  late WebSocket _websocket;
  late StreamSubscription _webSocketSubscripion;

  late String _authHeader;
  late Directory _lolDirectory;

  final Subject<List<dynamic>> _websocketEventSubject = PublishSubject();

  LcuService get service => _service != null ? _service! : throw Exception('Lcu unitialized');

  Future<void> init({void Function()? onDisconect}) async {
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

    if (content.isEmpty) {
      _lcuStore.clear();
    }

    List<String> args = content.split(':');
    final authKey = args[3];
    _port = int.tryParse(args[2]) ?? -1;

    if (authKey == '' || _port == -1) {
      throw UnknownLockfileFormatException();
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

    _webSocketSubscripion = _websocket.listen(
      _onWebsocketData,
      onDone: onDisconect,
    );

    _service = LcuService(_restClient, '127.0.0.1:$_port', _authHeader);
  }

  Future<bool> _tryFindRunningLolDirectory() async {
    if (Platform.isWindows) {
      final lolExeFile = await findExePathByProcessName('LeagueClientUx.exe');
      if (lolExeFile == null) return false;

      final lockfile = await _getLockfileFromLolDirectory(lolExeFile.parent);
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

  void _onWebsocketData(dynamic data) {
    if (data.isEmpty) return;

    if (kDebugMode) {
      print("LCUEvent: $data");
    }

    final jsonEvent = json.decode(data);

    if (jsonEvent is! List) return;

    _websocketEventSubject.add(jsonEvent);
  }

  Future<bool> saveLockfileDirectory(Directory directory) async {
    File? lockfile;
    if (Platform.isMacOS) {
      lockfile = await _getLockfileFromMacosLolDirectory(directory);
    } else {
      lockfile = await _getLockfileFromLolDirectory(directory);
    }

    if (lockfile == null) {
      return false;
    }

    await _lcuStore.putLcuLockfilePath(lockfile.path);
    return true;
  }

  Future<File?> _getLockfileFromMacosLolDirectory(Directory directory) async {
    File? lockfileFile;
    try {
      final contentFolder = await directory.list().firstWhere((item) => item.path.endsWith('Contents'));
      final lolFolder = await (contentFolder as Directory).list().firstWhere((item) => item.path.endsWith('LoL'));

      // is a valid directory if LoL folder exists
      lockfileFile = File(path.join(directory.path, 'lockfile'));

      await for (final FileSystemEntity f in (lolFolder as Directory).list()) {
        if (f is File && path.basename(f.path) == 'lockfile') {
          lockfileFile = f;
        }
      }
    } catch (_) {}

    return lockfileFile;
  }

  Future<File?> _getLockfileFromLolDirectory(Directory directory) async {
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

  Stream<dynamic> subscribeToChampSelectEvent() => _subscribeToWebsocketEvent(_pickSessionEvent);
  Stream<dynamic> subscribeToEndOfGameEvent() => _subscribeToWebsocketEvent(_gameFlowStateEvent);
  Stream<dynamic> subscribeToReadyCheckEvent() => _subscribeToWebsocketEvent(_matchmakingEvent);

  Stream<dynamic> _subscribeToWebsocketEvent(String eventName) {
    _websocket.add('[5, "$eventName"]');
    return _websocketEventSubject.where((event) => eventName == event.elementAt(1)).map((event) => event.elementAt(2));
  }

  void close() {
    _webSocketSubscripion.cancel();
    _websocket.close();
    _restClient.close();
  }
}
