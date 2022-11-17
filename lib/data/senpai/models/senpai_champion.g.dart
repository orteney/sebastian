// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'senpai_champion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SenpaiChampion _$SenpaiChampionFromJson(Map<String, dynamic> json) =>
    SenpaiChampion(
      filters: (json['filters'] as List<dynamic>)
          .map((e) => Filter.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Filter _$FilterFromJson(Map<String, dynamic> json) => Filter(
      roleId: json['roleId'] as int,
      winRate: (json['winRate'] as num).toDouble(),
      pickRate: (json['pickRate'] as num).toDouble(),
      banRate: (json['banRate'] as num).toDouble(),
      keystones: (json['keystones'] as List<dynamic>)
          .map((e) => Keystone.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Keystone _$KeystoneFromJson(Map<String, dynamic> json) => Keystone(
      id: json['id'] as int,
      winRate: (json['winRate'] as num).toDouble(),
      numMatches: json['numMatches'] as int,
    );
