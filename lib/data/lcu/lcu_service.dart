import 'dart:convert';
import 'dart:io';

import 'package:sebastian/data/lcu/models/item.dart';
import 'package:sebastian/data/lcu/models/perk.dart';
import 'package:sebastian/data/lcu/models/summoner_dto.dart';
import 'package:sebastian/data/lcu/models/summoner_spell.dart';
import 'package:flutter/foundation.dart' show compute;

import 'package:sebastian/data/lcu/models/champion_dto.dart';
import 'package:sebastian/data/lcu/models/lcu_error.dart';
import 'package:sebastian/data/lcu/models/rune_page.dart';
import 'package:sebastian/data/lcu/models/champion_mastery.dart';
import 'package:sebastian/data/lcu/models/champion_stat_stones.dart';
import 'package:sebastian/data/lcu/models/chest_eligibility.dart';
import 'package:sebastian/data/models/lcu_image.dart';
import 'package:sebastian/data/lcu/models/loot.dart';
import 'package:sebastian/data/utils/http_logger.dart';

class LcuService {
  final HttpClient _restClient;
  final String _address;
  final String _authHeader;

  LcuService(
    this._restClient,
    this._address,
    this._authHeader,
  );

  Future<SummonerDto> getCurrentSummoner() async {
    final response = await _request('GET', '/lol-summoner/v1/current-summoner');
    return SummonerDto.fromJson(response);
  }

  Future<ChestEligibility> getChestEligibility() async {
    final response = await _request('GET', '/lol-collections/v1/inventories/chest-eligibility');
    return ChestEligibility.fromJson(response);
  }

  Future<List<ChampionDto>> getChampionsSummary() async {
    final response = await _request('GET', '/lol-game-data/assets/v1/champion-summary.json');
    return response is List ? response.map((e) => ChampionDto.fromJson(e)).toList() : [];
  }

  Future<List<Perk>> getPerks() async {
    final response = await _request('GET', '/lol-game-data/assets/v1/perks.json');
    return response is List ? response.map((e) => Perk.fromJson(e)).toList() : [];
  }

  Future<List<Item>> getItems() async {
    final response = await _request('GET', '/lol-game-data/assets/v1/items.json');
    return response is List ? response.map((e) => Item.fromJson(e)).toList() : [];
  }

  Future<List<SummonerSpell>> getSummonerSpells() async {
    final response = await _request('GET', '/lol-game-data/assets/v1/summoner-spells.json');
    return response is List ? response.map((e) => SummonerSpell.fromJson(e)).toList() : [];
  }

  Future<List<ChampionMastery>> getChampionMasteryList(int summonerId) async {
    final response = await _request('GET', '/lol-collections/v1/inventories/$summonerId/champion-mastery');

    if (response is List) {
      return response.map((e) => ChampionMastery.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<List<ChampionStatStones>> getChampionStatStones() async {
    final response = await _request('GET', '/lol-statstones/v2/player-summary-self');

    if (response is List) {
      return response.map((e) => ChampionStatStones.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<List<Loot>> getPlayerLoot() async {
    final response = await _request('GET', '/lol-loot/v1/player-loot');

    if (response is List) {
      return response.map((e) => Loot.fromJson(e)).toList();
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

  Future<void> postRunePage(RunePage page) {
    return _request('POST', '/lol-perks/v1/pages', body: page.toJson());
  }

  Future<void> deleteCurrentPage() async {
    final currentPage = await _request('GET', '/lol-perks/v1/currentpage');
    return _request('DELETE', '/lol-perks/v1/pages/${currentPage['id']}');
  }

  Future<dynamic> _request(
    String method,
    String endpoint, {
    dynamic body,
  }) async {
    final HttpClientRequest req = await _restClient.openUrl(
      method,
      Uri.https(_address, endpoint),
    );

    req.headers.set(HttpHeaders.acceptHeader, 'application/json');
    req.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
    req.headers.set(HttpHeaders.authorizationHeader, _authHeader);

    if (body != null) req.add(json.fuse(utf8).encode(body));

    final response = await req.close();
    final responseBody = await response.transform(utf8.decoder).join();

    req.log(response, responseBody);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      dynamic lcuError;

      try {
        lcuError = LcuError.fromJson(json.decode(responseBody));
      } catch (e) {
        lcuError = Exception('Unknown LCU error (code: ${response.statusCode}): $responseBody');
      }

      throw lcuError;
    }

    if (responseBody.isEmpty) {
      return const <String, dynamic>{};
    }

    return compute(json.decode, responseBody);
  }

  LcuImage getLcuImage(String path) {
    return LcuImage(
      url: Uri.https(_address, path).toString(),
      headers: {HttpHeaders.authorizationHeader: _authHeader},
    );
  }
}
