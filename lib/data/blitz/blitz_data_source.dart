import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:sebastian/data/blitz/models/all_champions_stats.dart';
import 'package:sebastian/data/blitz/models/blitz_primary_role_response.dart';
import 'package:sebastian/data/blitz/models/blitz_builds_response.dart';
import 'package:sebastian/data/blitz/models/request_variables.dart';
import 'package:sebastian/data/utils/http_logger.dart';

class BlitzDataSource {
  final bool logEnabled;

  BlitzDataSource({this.logEnabled = false});

  Future<List<BlitzBuild>> getBuilds(BuildRequestVariables variables) async {
    const query = r'''
query ChampionBuildsTagged($championId:String! $queue:String! $role:String){
  executeDatabricksQuery(game:LEAGUE queryName:"prod_champion_builds_tags" params:[
      {name:"individual_position",value:$role}
      {name:"queue_id",value:$queue}
      {name:"champion_id",value:$championId}
    ]
  )
  {metadata{byteSize lastModified parameters}payload}
}''';

    final responseJson = await _requestDataLake({
      'query': query,
      'variables': json.encode(variables.toJson()),
    });

    return BlitzBuildResponse.fromJson(responseJson).builds;
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

    if (logEnabled) {
      response.log(responseBody);
    }

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(responseBody);
    }

    final jsonDecoded = json.decode(responseBody);

    if (jsonDecoded['errors'] != null) {
      throw Exception(jsonDecoded['errors']);
    }

    return jsonDecoded;
  }

  Future<dynamic> _requestDataLake(Map<String, dynamic>? queryParameters) async {
    final response = await http.get(Uri.https('datalake-server.iesdev.com', 'graphql', queryParameters));

    final responseBody = response.body;

    if (logEnabled) {
      response.log(responseBody);
    }

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
