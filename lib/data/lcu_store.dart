import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

const _spLockfilePathKey = 'lockfilePath';

class LcuStore {
  final SharedPreferences _sharedPreferences;

  LcuStore(this._sharedPreferences);

  File? getLcuLockfile() {
    final path = _sharedPreferences.getString(_spLockfilePathKey);

    if (path == null) {
      return null;
    }

    return File(path);
  }

  Future<void> putLcuLockfilePath(String lockfilePath) async {
    await _sharedPreferences.setString(_spLockfilePathKey, lockfilePath);
  }
}
