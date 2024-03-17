// ignore_for_file: avoid_print

import 'dart:io';

import 'package:http/http.dart';

extension HttpLogger on HttpClientRequest {
  void log(HttpClientResponse response, String responseBody) {
    print('$method $uri: ${response.statusCode}');
    print(responseBody);
  }
}

extension HttpLogger2 on Response {
  void log(String responseBody) {
    print('${request?.method} ${request?.url}: $statusCode');
    print(responseBody);
  }
}
