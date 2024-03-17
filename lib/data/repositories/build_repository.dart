import 'package:sebastian/data/blitz/blitz_build_mapper.dart';
import 'package:sebastian/data/blitz/blitz_data_source.dart';
import 'package:sebastian/data/blitz/models/request_variables.dart';
import 'package:sebastian/domain/builds/build_info.dart';
import 'package:sebastian/domain/core/role.dart';

class BuildRepository {
  final BlitzDataSource _blitzDataSource;
  final BlitzBuildMapper _blitzBuildMapper;

  BuildRepository(
    this._blitzDataSource,
    this._blitzBuildMapper,
  );

  Future<Builds> getBuilds(int championId, {Role? role}) async {
    final builds = <BuildInfo>[];

    BlitzRole? blitzRole = role != null ? BlitzRole.fromRole(role) : null;
    blitzRole ??= await _blitzDataSource.getPrimaryRole(championId);

    final blitzBuilds = await _blitzDataSource.getBuilds(
      BuildRequestVariables(
        championId: championId.toString(),
        queue: BlitzQueue.rankedSolo5X5,
        role: blitzRole,
      ),
    );

    builds.addAll(blitzBuilds.map<BuildInfo>(_blitzBuildMapper.call));

    return Builds(
      role: role ?? blitzRole.role,
      builds: builds,
    );
  }

  Future<Builds> getAramBuilds(int championId) async {
    final builds = <BuildInfo>[];

    final blitzBuilds = await _blitzDataSource.getBuilds(
      BuildRequestVariables(
        championId: championId.toString(),
        queue: BlitzQueue.howlingAbyssAram,
      ),
    );
    builds.addAll(blitzBuilds.map<BuildInfo>(_blitzBuildMapper.call));

    return Builds(
      builds: builds,
    );
  }
}
