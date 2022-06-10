import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:champmastery/data/models/lcu_image.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;

import 'package:champmastery/data/lcu_store.dart';
import 'package:champmastery/data/models/champion_mastery.dart';
import 'package:champmastery/data/models/champion_stat_stones.dart';
import 'package:champmastery/data/models/chest_eligibility.dart';
import 'package:champmastery/data/models/loot.dart';
import 'package:champmastery/data/models/summoner.dart';
import 'package:champmastery/data/utils/proccess.dart';

class NoLockFilePathException implements Exception {}

class LockFileNotFoundException implements Exception {}

class LCU {
  final LcuStore _lcuStore;

  LCU(this._lcuStore);

  late int _port;
  late HttpClient _restClient;
  late WebSocket _websocket;
  late Stream<dynamic> _broadcastWebsocket;

  late String _authHeader;

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

  Future<List<Loot>> getPlayerLoot() async {
    final response = await _request('GET', '/lol-loot/v1/player-loot');

    if (response is List) {
      return response.map((e) => Loot.fromMap(e)).toList();
    } else {
      return [];
    }
  }

  Future<void> disenchantChampion(String lootId, int count) async {
    return _request(
      'POST',
      '/lol-loot/v1/recipes/CHAMPION_RENTAL_disenchant/craft?repeat=$count',
      body: [lootId],
    );
  }

  Future<dynamic> _request(
    String method,
    String endpoint, {
    dynamic body,
  }) async {
    HttpClientRequest req = await _restClient.openUrl(method, Uri.parse('https://127.0.0.1:$_port$endpoint'));

    req.headers.set(HttpHeaders.acceptHeader, 'application/json');
    req.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
    req.headers.set(HttpHeaders.authorizationHeader, _authHeader);

    if (body != null) req.add(json.fuse(utf8).encode(body));

    final response = await req.close();
    final responseBody = await response.transform(utf8.decoder).join();

    _logRequest(req, response, responseBody);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Lcu error (code: ${response.statusCode}): $responseBody');
    }

    return json.decode(responseBody.isEmpty ? '{}' : responseBody);
  }

  void _logRequest(HttpClientRequest request, HttpClientResponse response, String responseBody) {
    if (kDebugMode) {
      print('${request.method} ${request.uri}: ${response.statusCode}');
      print(responseBody);
    }
  }

  LcuImage getLcuImage(String path) {
    return LcuImage(
      url: 'https://127.0.0.1:$_port$path',
      headers: {'Authorization': _authHeader},
    );
  }

  void close() {
    _websocket.close();
    _restClient.close();
  }
}
