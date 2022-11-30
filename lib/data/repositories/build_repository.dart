import 'package:sebastian/data/blitz/blitz_build_mapper.dart';
import 'package:sebastian/data/blitz/blitz_data_source.dart';
import 'package:sebastian/data/blitz/models/request_variables.dart';
import 'package:sebastian/domain/builds/build_info.dart';

class BuildRepository {
  final BlitzDataSource _blitzDataSource;
  final BlitzBuildMapper _blitzBuildMapper;

  BuildRepository(
    this._blitzDataSource,
    this._blitzBuildMapper,
  );

  Future<Builds> getBuilds(int championId, {Role? role}) async {
    final builds = <BuildInfo>[];

    BlitzRole? blitzRole = _blitzRoleMap[role];
    blitzRole ??= await _blitzDataSource.getPrimaryRole(championId);

    final blitzBuilds = await _blitzDataSource.getBuilds(
      RequestVariables(
        queue: Queue.rankedSolo5X5,
        role: blitzRole,
        championId: championId,
      ),
    );

    builds.addAll(blitzBuilds.data.championBuildStats.builds.map<BuildInfo>(_blitzBuildMapper));

    return Builds(
      role: role ?? _blitzRoleMap.entries.firstWhere((element) => element.value == blitzRole).key,
      builds: builds,
    );
  }

  static const _blitzRoleMap = {
    Role.top: BlitzRole.top,
    Role.jungle: BlitzRole.jungle,
    Role.mid: BlitzRole.mid,
    Role.adc: BlitzRole.adc,
    Role.support: BlitzRole.support,
  };

  Future<Builds> getAramBuilds(int championId) async {
    final builds = <BuildInfo>[];

    final blitzBuilds = await _blitzDataSource.getAramBuilds(
      RequestVariables(
        queue: Queue.howlingAbyssAram,
        championId: championId,
      ),
    );
    builds.addAll(blitzBuilds.data.championBuildStats.builds.map<BuildInfo>(_blitzBuildMapper));

    return Builds(
      builds: builds,
    );
  }
}
