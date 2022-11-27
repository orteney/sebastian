import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:sebastian/data/senpai/models/senpai_build.dart';
import 'package:sebastian/data/utils/http_logger.dart';

class SenpaiDataSource {
  SenpaiDataSource();

  Future<List<SenpaiBuildInfo>> fetchAramBuild(int championId) async {
    final responseJson = await _request("api/v1/lol/champions/$championId/build/", {'queue_id': '450'});
    final builds = SenpaiBuild.fromJson(responseJson);
    return [builds.numMatches, if (builds.winRate != null) builds.winRate!];
  }

  Future<List<SenpaiBuildInfo>> fetchRoleBuild(int championId, {int? roleId}) async {
    final queryParams = roleId != null ? {'role_id': roleId.toString()} : null;
    final responseJson = await _request("api/v1/lol/champions/$championId/build/", queryParams);
    final builds = SenpaiBuild.fromJson(responseJson);
    return [builds.numMatches, if (builds.winRate != null) builds.winRate!];
  }

  Future<dynamic> _request(String path, [Map<String, dynamic>? queryParameters]) async {
    final response = await http.get(
      Uri.https('api.senpai.gg', path, queryParameters),
      headers: const {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    final responseBody = response.body;

    response.log(responseBody);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(responseBody);
    }

    return json.decode(responseBody);
  }
}
