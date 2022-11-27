import 'package:json_annotation/json_annotation.dart';

part 'senpai_build.g.dart';

@JsonSerializable(createToJson: false)
class SenpaiBuild {
  final SenpaiBuildInfo numMatches;
  final SenpaiBuildInfo? winRate;

  SenpaiBuild({
    required this.numMatches,
    this.winRate,
  });

  factory SenpaiBuild.fromJson(Map<String, dynamic> json) => _$SenpaiBuildFromJson(json);
}

@JsonSerializable(createToJson: false)
class SenpaiBuildInfo {
  final int championId;
  final int? roleId;
  final int keystoneId;
  final int? queueId;
  final int version;
  final String platformId;
  final double winRate;
  final int numMatches;
  final SenpaiItemBuild build;

  SenpaiBuildInfo({
    required this.championId,
    this.roleId,
    required this.keystoneId,
    this.queueId,
    required this.version,
    required this.platformId,
    required this.winRate,
    required this.numMatches,
    required this.build,
  });

  factory SenpaiBuildInfo.fromJson(Map<String, dynamic> json) => _$SenpaiBuildInfoFromJson(json);
}

@JsonSerializable(createToJson: false)
class SenpaiItemBuild {
  final List<int> startBuild;
  final List<int> coreBuild;
  final List<int> finalBuild;
  final List<List<int>> buildPath;
  final List<int> spells;
  final SenpaiRunes runes;
  final List<int> skillOrder;
  final List<int> skillPath;
  final List<int> situationalItems;

  SenpaiItemBuild({
    required this.startBuild,
    required this.coreBuild,
    required this.finalBuild,
    required this.buildPath,
    required this.spells,
    required this.runes,
    required this.skillOrder,
    required this.skillPath,
    required this.situationalItems,
  });

  factory SenpaiItemBuild.fromJson(Map<String, dynamic> json) => _$SenpaiItemBuildFromJson(json);
}

@JsonSerializable(createToJson: false)
class SenpaiRunes {
  final int primaryPath;
  final int subPath;
  final SenpaiRunesTree tree;

  SenpaiRunes({
    required this.primaryPath,
    required this.subPath,
    required this.tree,
  });

  factory SenpaiRunes.fromJson(Map<String, dynamic> json) => _$SenpaiRunesFromJson(json);
}

@JsonSerializable(createToJson: false)
class SenpaiRunesTree {
  final List<int> primary;
  final List<int> sub;
  final List<int> stat;

  SenpaiRunesTree({
    required this.primary,
    required this.sub,
    required this.stat,
  });

  factory SenpaiRunesTree.fromJson(Map<String, dynamic> json) => _$SenpaiRunesTreeFromJson(json);
}
