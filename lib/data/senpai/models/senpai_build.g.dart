// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'senpai_build.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SenpaiBuild _$SenpaiBuildFromJson(Map<String, dynamic> json) => SenpaiBuild(
      numMatches:
          SenpaiBuildInfo.fromJson(json['numMatches'] as Map<String, dynamic>),
      winRate: json['winRate'] == null
          ? null
          : SenpaiBuildInfo.fromJson(json['winRate'] as Map<String, dynamic>),
    );

SenpaiBuildInfo _$SenpaiBuildInfoFromJson(Map<String, dynamic> json) =>
    SenpaiBuildInfo(
      championId: json['championId'] as int,
      roleId: json['roleId'] as int?,
      keystoneId: json['keystoneId'] as int,
      queueId: json['queueId'] as int?,
      version: json['version'] as int,
      platformId: json['platformId'] as String,
      winRate: (json['winRate'] as num).toDouble(),
      numMatches: json['numMatches'] as int,
      build: SenpaiItemBuild.fromJson(json['build'] as Map<String, dynamic>),
    );

SenpaiItemBuild _$SenpaiItemBuildFromJson(Map<String, dynamic> json) =>
    SenpaiItemBuild(
      startBuild:
          (json['startBuild'] as List<dynamic>).map((e) => e as int).toList(),
      coreBuild:
          (json['coreBuild'] as List<dynamic>).map((e) => e as int).toList(),
      finalBuild:
          (json['finalBuild'] as List<dynamic>).map((e) => e as int).toList(),
      buildPath: (json['buildPath'] as List<dynamic>)
          .map((e) => (e as List<dynamic>).map((e) => e as int).toList())
          .toList(),
      spells: (json['spells'] as List<dynamic>).map((e) => e as int).toList(),
      runes: Runes.fromJson(json['runes'] as Map<String, dynamic>),
      skillOrder:
          (json['skillOrder'] as List<dynamic>).map((e) => e as int).toList(),
      skillPath:
          (json['skillPath'] as List<dynamic>).map((e) => e as int).toList(),
      situationalItems: (json['situationalItems'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
    );

Runes _$RunesFromJson(Map<String, dynamic> json) => Runes(
      primaryPath: json['primaryPath'] as int,
      subPath: json['subPath'] as int,
      tree: Tree.fromJson(json['tree'] as Map<String, dynamic>),
    );

Tree _$TreeFromJson(Map<String, dynamic> json) => Tree(
      primary: (json['primary'] as List<dynamic>).map((e) => e as int).toList(),
      sub: (json['sub'] as List<dynamic>).map((e) => e as int).toList(),
      stat: (json['stat'] as List<dynamic>).map((e) => e as int).toList(),
    );
