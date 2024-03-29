import 'package:sebastian/domain/core/role.dart';

class Builds {
  final Role? role;
  final List<BuildInfo> builds;

  Builds({
    this.role,
    required this.builds,
  });
}

class BuildInfo {
  final int keystoneId;
  final double winRate;
  final int numMatches;
  final ItemBuild itemBuild;
  final List<int> summonerSpells;
  final Runes runes;
  final List<int>? skillOrder;
  final List<int>? skillPath;

  BuildInfo({
    required this.keystoneId,
    required this.winRate,
    required this.numMatches,
    required this.itemBuild,
    required this.summonerSpells,
    required this.runes,
    required this.skillOrder,
    required this.skillPath,
  });
}

class ItemBuild {
  final List<int> startBuild;
  final List<int> coreBuild;
  final List<int> finalBuild;
  final List<int> situationalItems;

  ItemBuild({
    required this.startBuild,
    required this.coreBuild,
    required this.finalBuild,
    required this.situationalItems,
  });
}

class Runes {
  final int primaryPath;
  final int subPath;
  final List<int> primary;
  final List<int> sub;
  final List<int> stat;

  Runes({
    required this.primaryPath,
    required this.subPath,
    required this.primary,
    required this.sub,
    required this.stat,
  });
}
