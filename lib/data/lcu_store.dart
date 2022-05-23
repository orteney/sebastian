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

  /// Checks that [directoryPath] contains lockfile or LeagueClient executables and then saves path to persistent storage
  Future<void> putLcuLockfilePath(String directoryPath) async {
    final lolPath = Directory(directoryPath);

    bool foundLolClients = false;
    File? lockfilePath;

    await for (final FileSystemEntity f in lolPath.list()) {
      if (f is File) {
        switch (path.basename(f.path)) {
          case 'lockfile':
            lockfilePath = f;
            break;
          case 'LeagueClient.exe':
          case 'LeagueClientUx.exe':
            foundLolClients = true;
            break;
        }
      }
    }

    if (lockfilePath == null) {
      if (!foundLolClients) {
        throw Exception();
      }

      lockfilePath = File(path.join(directoryPath, 'lockfile'));
    }

    _sharedPreferences.setString(_spLockfilePathKey, lockfilePath.path);
  }
}
