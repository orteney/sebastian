// ignore_for_file: avoid_print

import 'package:sebastian/data/blitz/blitz_build_mapper.dart';
import 'package:sebastian/data/blitz/blitz_data_source.dart';
import 'package:sebastian/data/repositories/build_repository.dart';
import 'package:sebastian/domain/core/role.dart';

Future<void> main(List<String> arguments) async {
  final repository = BuildRepository(
    BlitzDataSource(logEnabled: true),
    BlitzBuildMapper(),
  );

  try {
    final builds = await repository.getBuilds(
      1,
      role: Role.mid,
    );

    for (var build in builds.builds) {
      print(build);
    }
  } catch (e) {
    print(e);
  }
}
