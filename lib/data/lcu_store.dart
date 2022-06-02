import 'dart:io';

import 'package:path/path.dart' as path;
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

  Future<void> putLcuLockfilePath(String directoryPath) async {
    final lockfilePath = File(path.join(directoryPath, 'lockfile'));
    await _sharedPreferences.setString(_spLockfilePathKey, lockfilePath.path);
  }
}
