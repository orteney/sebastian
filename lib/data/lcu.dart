import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:champmastery/data/lcu_store.dart';
import 'package:champmastery/data/models/champion_mastery.dart';
import 'package:champmastery/data/models/chest_eligibility.dart';
import 'package:champmastery/data/models/summoner.dart';

class NoLockFilePathException implements Exception {}

class LockFileNotFoundException implements Exception {}

class LCU {
  final String _authKey;
  final int _port;
  final HttpClient _restClient;
  final WebSocket _websocket;

  LCU._(this._authKey, this._port, this._restClient, this._websocket);

  static Future<LCU> create(LcuStore store, {int retries = 5, int retryAfter = 5}) async {
    String authKey = '';
    int port = -1;

    final lockfile = store.getLcuLockfile();

    if (lockfile == null) {
      throw NoLockFilePathException();
    }

    if (!lockfile.existsSync()) {
      throw LockFileNotFoundException();
    }

    String content = lockfile.readAsStringSync();
    List<String> args = content.split(':');
    authKey = args[3];
    port = int.parse(args[2]);

    if (authKey == '' || port == -1) {
      throw 'Чота не удалось прочитать';
    }

    print('lockfile = auth:$authKey port:$port');

    final httpClient = HttpClient();
    httpClient.badCertificateCallback = (cert, host, port) => true;

    final webSocket = await WebSocket.connect(
      'wss://127.0.0.1:$port',
      headers: {'Authorization': 'Basic ${utf8.fuse(base64).encode('riot:$authKey')}'},
      customClient: httpClient,
    );

    final lcu = LCU._(authKey, port, httpClient, webSocket);

    return lcu;
  }

  Stream<dynamic> subscribeToChampSelectEvent() {
    const eventName = 'OnJsonApiEvent_lol-champ-select_v1_session';
    _websocket.add('[5, "$eventName"]');
    return _websocketEvent(eventName);
  }

  Stream<void> subscribeToEndOfGameEvent() {
    const eventName = 'OnJsonApiEvent_lol-end-of-game_v1_champion-mastery-updates';
    _websocket.add('[5, "$eventName"]');
    return _websocketEvent(eventName);
  }

  Stream<dynamic> _websocketEvent(String eventName) {
    return _websocket
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

    if (response is List<dynamic>) {
      return response.map((e) => ChampionMastery.fromMap(e)).toList();
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
