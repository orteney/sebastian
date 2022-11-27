import 'dart:io';

import 'package:http/http.dart';
import 'package:flutter/foundation.dart' show kDebugMode;

extension HttpLogger on HttpClientRequest {
  void log(HttpClientResponse response, String responseBody) {
    if (kDebugMode) {
      print('$method $uri: ${response.statusCode}');
      print(responseBody);
    }
  }
}

extension HttpLogger2 on Response {
  void log(String responseBody) {
    if (kDebugMode) {
      print('${request?.method} ${request?.url}: $statusCode');
      print(responseBody);
    }
  }
}
