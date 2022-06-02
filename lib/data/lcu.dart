import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:path/path.dart' as path;

import 'package:champmastery/data/lcu_store.dart';
import 'package:champmastery/data/models/champion_mastery.dart';
import 'package:champmastery/data/models/champion_stat_stones.dart';
import 'package:champmastery/data/models/chest_eligibility.dart';
import 'package:champmastery/data/models/summoner.dart';
import 'package:champmastery/data/utils/proccess.dart';

class NoLockFilePathException implements Exception {}

class LockFileNotFoundException implements Exception {}

class LCU {
  final LcuStore _lcuStore;

  LCU(this._lcuStore);

  late String _authKey;
  late int _port;
  late HttpClient _restClient;
  late WebSocket _websocket;
  late Stream<dynamic> _broadcastWebsocket;

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

    String content = savedLockfile.readAsStringSync();
    List<String> args = content.split(':');
    _authKey = args[3];
    _port = int.parse(args[2]);

    if (_authKey == '' || _port == -1) {
      throw 'Чота не удалось прочитать';
    }

    if (kDebugMode) {
      print('lockfile = auth:$_authKey port:$_port');
    }

    _restClient = HttpClient();
    _restClient.badCertificateCallback = (cert, host, port) => true;

    _websocket = await WebSocket.connect(
      'wss://127.0.0.1:$_port',
      headers: {'Authorization': 'Basic ${utf8.fuse(base64).encode('riot:$_authKey')}'},
      customClient: _restClient,
    );

    _broadcastWebsocket = _websocket.asBroadcastStream();
  }

  Future<bool> _tryFindRunningLolDirectory() async {
    if (!Platform.isWindows) return false;

    final lolExeFile = await findExePathByProcessName('LeagueClientUx.exe');

    if (lolExeFile == null) return false;

    final lolDirectory = lolExeFile.parent;

    final lockfile = await getLockfileFromLolDirectory(lolDirectory);

    if (lockfile != null) {
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

  Stream<dynamic> subscribeToChampSelectEvent() {
    const eventName = 'OnJsonApiEvent_lol-champ-select_v1_session';
    _websocket.add('[5, "$eventName"]');
    return _websocketEvent(eventName);
  }

  Stream<dynamic> subscribeToEndOfGameEvent() {
    const eventName = 'OnJsonApiEvent_lol-end-of-game_v1_champion-mastery-updates';
    _websocket.add('[5, "$eventName"]');
    return _websocketEvent(eventName);
  }

  Stream<dynamic> _websocketEvent(String eventName) {
    return _broadcastWebsocket
        .map((event) {
          if (event.isEmpty) return null;
          final jsonEvent = json.decode(event);

          if (jsonEvent is! List) return null;

          return jsonEvent;
        })
        .where((event) => event?.elementAt(1) == eventName)
        .map((event) => event?.elementAt(2));
  }

  Future<Summoner> getCurrentSummoner() async {
    final response = await _request('GET', '/lol-summoner/v1/current-summoner');
    return Summoner.fromMap(response);
  }

  Future<ChestEligibility> getChestEligibility() async {
    final response = await _request('GET', '/lol-collections/v1/inventories/chest-eligibility');
    return ChestEligibility.fromMap(response);
  }

  Future<List<ChampionMastery>> getChampionMasteryList(int summonerId) async {
    final response = await _request(
      'GET',
      '/lol-collections/v1/inventories/$summonerId/champion-mastery',
    );

    if (response is List) {
      return response.map((e) => ChampionMastery.fromMap(e)).toList();
    } else {
      return [];
    }
  }

  Future<List<ChampionStatStones>> getChampionStatStones() async {
    final response = await _request('GET', '/lol-statstones/v2/player-summary-self');

    if (response is List) {
      return response.map((e) => ChampionStatStones.fromMap(e)).toList();
    } else {
      return [];
    }
  }

  Future<dynamic> _request(
    String method,
    String endpoint, {
    Map<String, dynamic>? body,
  }) async {
    HttpClientRequest req = await _restClient.openUrl(method, Uri.parse('https://127.0.0.1:$_port$endpoint'));

    req.headers.set(HttpHeaders.acceptHeader, 'application/json');
    req.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
    req.headers.set(HttpHeaders.authorizationHeader, 'Basic ${utf8.fuse(base64).encode('riot:$_authKey')}');

    if (body != null) req.add(json.fuse(utf8).encode(body));

    HttpClientResponse resp = await req.close();

    return resp.transform(utf8.decoder).join().then((String data) => json.decode(data.isEmpty ? '{}' : data));
  }

  void close() {
    _websocket.close();
    _restClient.close();
  }
}
