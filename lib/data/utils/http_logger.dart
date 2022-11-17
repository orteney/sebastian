import 'dart:io';

import 'package:flutter/foundation.dart';

extension HttpLogger on HttpClientRequest {
  void log(HttpClientResponse response, String responseBody) {
    if (kDebugMode) {
      print('$method $uri: ${response.statusCode}');
      print(responseBody);
    }
  }
}
