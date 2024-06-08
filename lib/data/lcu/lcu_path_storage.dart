import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

const _spLockfilePathKey = 'lockfilePath';

class LcuPathStorage {
  final SharedPreferences _sharedPreferences;

  LcuPathStorage(this._sharedPreferences);

  File? getLcuLockfile() {
    final path = _sharedPreferences.getString(_spLockfilePathKey);

    if (path == null) {
      return null;
    }

    return File(path);
  }

  void clear() {
    _sharedPreferences.remove(_spLockfilePathKey);
  }

  Future<void> putLcuLockfilePath(String lockfilePath) async {
    await _sharedPreferences.setString(_spLockfilePathKey, lockfilePath);
  }
}
