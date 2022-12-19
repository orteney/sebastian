import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:sebastian/data/blitz/models/all_champions_stats.dart';
import 'package:sebastian/data/blitz/models/blitz_builds_response.dart';
import 'package:sebastian/data/blitz/models/blitz_primary_role_response.dart';
import 'package:sebastian/data/blitz/models/request_variables.dart';
import 'package:sebastian/data/utils/http_logger.dart';

class BlitzDataSource {
  BlitzDataSource();

  Future<List<BlitzBuild>> getBuilds(BuildRequestVariables variables) async {
    const query = r'''
query ChampionBuilds($championId:Int! $queue:Queue! $role:Role! $key:ChampionBuildKey $opponentChampionId:Int){
  championBuildStats(championId:$championId queue:$queue role:$role key:$key opponentChampionId:$opponentChampionId){
    championId
    opponentChampionId
    queue
    role
    builds{
      wins
      games
      mythicId
      mythicAverageIndex
      primaryRune
      startingItems{games wins startingItemIds}
      coreItems{games wins itemIds}
      completedItems{games index averageIndex itemId wins}
      situationalItems{games wins itemId averageIndex}
      runes{games index runeId wins treeId}
      skillOrders{games wins skillOrder}
      summonerSpells{games wins summonerSpellIds}
    }
  }
}''';

    final responseJson = await _request({
      'query': query,
      'variables': json.encode(variables.toJson()),
    });

    return BlitzBuildResponse.fromJson(responseJson).data.championBuildStats.builds;
  }

  Future<List<BlitzBuild>> getAramBuilds(BuildRequestVariables variables) async {
    const query = r'''
query ChampionBuilds($championId:Int! $queue:Queue! $key:ChampionBuildKey $opponentChampionId:Int){
  championBuildStats(championId:$championId queue:$queue key:$key opponentChampionId:$opponentChampionId){
    championId
    opponentChampionId
    queue
    role
    builds{
      wins
      games
      mythicId
      mythicAverageIndex
      primaryRune
      startingItems{games wins startingItemIds}
      coreItems{games wins itemIds}
      completedItems{games index averageIndex itemId wins}
      situationalItems{games wins itemId averageIndex}
      runes{games index runeId wins treeId}
      skillOrders{games wins skillOrder}
      summonerSpells{games wins summonerSpellIds}
    }
  }
}''';

    final responseJson = await _request({
      'query': query,
      'variables': json.encode(variables.toJson()),
    });

    return BlitzBuildResponse.fromJson(responseJson).data.championBuildStats.builds;
  }

  Future<BlitzRole> getPrimaryRole(int championId) async {
    const query = r'query ChampionPrimaryRole($championId:ID){primaryRole(championId:$championId)}';
    final responseJson = await _request({
      'query': query,
      'variables': '{"championId":$championId}',
    });
    return BlitzPrimaryRoleResponse.fromJson(responseJson).data.primaryRole;
  }

  Future<List<ChampionStats>> getAllChampionsStats(AllChampionsStatsRequestVariables variables) async {
    const query = r'''
query AllChampionsStats($queue:Queue){
  allChampionStats(tier:PLATINUM_PLUS mostPopular:true region:WORLD queue:$queue){
    role
    banRate
    pickRate
    championId
    wins
    games
    tierListTier{tierRank previousTierRank status}
  }
}''';

    final responseJson = await _request({
      'query': query,
      'variables': json.encode(variables.toJson()),
    });

    return ChampionsStatsResponse.fromJson(responseJson).data.allChampionStats;
  }

  Future<dynamic> _request(Map<String, dynamic>? queryParameters) async {
    final response = await http.get(Uri.https('league-champion-aggregate.iesdev.com', 'graphql', queryParameters));

    final responseBody = response.body;

    response.log(responseBody);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(responseBody);
    }

    final jsonDecoded = json.decode(responseBody);

    if (jsonDecoded['errors'] != null) {
      throw Exception(jsonDecoded['errors']);
    }

    return jsonDecoded;
  }
}
