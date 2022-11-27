import 'package:sebastian/data/senpai/models/senpai_build.dart';
import 'package:sebastian/data/senpai/senpai_build_mapper.dart';
import 'package:sebastian/data/senpai/senpai_data_source.dart';
import 'package:sebastian/domain/builds/build_info.dart';

class BuildRepository {
  final SenpaiDataSource _senpaiDataSource;
  final SenpaiBuildMapper _senpaiBuildMapper;

  BuildRepository(
    this._senpaiDataSource,
    this._senpaiBuildMapper,
  );

  Future<List<BuildInfo>> getBuilds(int championId, {int? roleId}) async {
    final builds = <BuildInfo>[];

    List<SenpaiBuildInfo> senpaiBuilds;

    try {
      senpaiBuilds = await _senpaiDataSource.fetchRoleBuild(championId, roleId: roleId);
    } catch (e) {
      if (roleId != null) {
        // No available build for pair champion - role, request without specified role
        senpaiBuilds = await _senpaiDataSource.fetchRoleBuild(championId);
      } else {
        // Senpai or network error
        senpaiBuilds = [];
      }
    }

    builds.addAll(senpaiBuilds.map<BuildInfo>(_senpaiBuildMapper));
    return builds;
  }

  Future<List<BuildInfo>> getAramBuilds(int championId) async {
    final builds = <BuildInfo>[];

    final senpaiBuilds = await _senpaiDataSource.fetchAramBuild(championId);
    builds.addAll(senpaiBuilds.map<BuildInfo>(_senpaiBuildMapper));
    return builds;
  }
}
