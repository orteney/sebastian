import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

const _spLockfilePathKey = 'lockfilePath';

class LcuStore {
  final SharedPreferences _sharedPreferences;

  LcuStore._(this._sharedPreferences);

  static Future<LcuStore> create() async {
    final preferences = await SharedPreferences.getInstance();
    return LcuStore._(preferences);
  }

  File? getLcuLockfile() {
    final path = _sharedPreferences.getString(_spLockfilePathKey);

    if (path == null) {
      return null;
    }

    return File(path);
  }

  void putLcuLockfilePath(File file) {
    _sharedPreferences.setString(_spLockfilePathKey, file.path);
  }
}
