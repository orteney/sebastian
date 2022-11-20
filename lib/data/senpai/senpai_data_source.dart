import 'dart:convert';
import 'dart:io';

import 'package:sebastian/data/senpai/models/senpai_build.dart';
import 'package:sebastian/data/utils/http_logger.dart';

class SenpaiDataSource {
  final HttpClient _httpClient;

  SenpaiDataSource() : _httpClient = HttpClient();

  Future<SenpaiBuild> fetchAramBuild(int championId) async {
    final responseJson = await _request("api/v1/lol/champions/$championId/build/", {'queue_id': '450'});
    return SenpaiBuild.fromJson(responseJson);
  }

  Future<SenpaiBuild> fetchRoleBuild(int championId, {int? roleId}) async {
    final queryParams = roleId != null ? {'role_id': roleId.toString()} : null;
    final responseJson = await _request("api/v1/lol/champions/$championId/build/", queryParams);
    return SenpaiBuild.fromJson(responseJson);
  }

  Future<dynamic> _request(String path, [Map<String, dynamic>? queryParameters]) async {
    final request = await _httpClient.openUrl(
      'GET',
      Uri.https('api.senpai.gg', path, queryParameters),
    );

    request.headers
      ..set(HttpHeaders.acceptHeader, 'application/json')
      ..set(HttpHeaders.contentTypeHeader, 'application/json');

    final response = await request.close();
    final responseBody = await response.transform(utf8.decoder).join();

    request.log(response, responseBody);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(responseBody);
    }

    return json.decode(responseBody);
  }
}
