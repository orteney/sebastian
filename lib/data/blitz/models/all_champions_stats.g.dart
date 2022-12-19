// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_champions_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChampionsStatsResponse _$ChampionsStatsResponseFromJson(
        Map<String, dynamic> json) =>
    ChampionsStatsResponse(
      ChampionsStatsData.fromJson(json['data'] as Map<String, dynamic>),
    );

ChampionsStatsData _$ChampionsStatsDataFromJson(Map<String, dynamic> json) =>
    ChampionsStatsData(
      (json['allChampionStats'] as List<dynamic>)
          .map((e) => ChampionStats.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

ChampionStats _$ChampionStatsFromJson(Map<String, dynamic> json) =>
    ChampionStats(
      json['championId'] as int,
      json['games'] as int,
      json['wins'] as int,
      $enumDecodeNullable(_$BlitzRoleEnumMap, json['role']),
      json['tierListTier'] == null
          ? null
          : TierListTier.fromJson(json['tierListTier'] as Map<String, dynamic>),
      (json['banRate'] as num?)?.toDouble(),
      (json['pickRate'] as num).toDouble(),
    );

const _$BlitzRoleEnumMap = {
  BlitzRole.adc: 'ADC',
  BlitzRole.jungle: 'JUNGLE',
  BlitzRole.mid: 'MID',
  BlitzRole.support: 'SUPPORT',
  BlitzRole.top: 'TOP',
};

TierListTier _$TierListTierFromJson(Map<String, dynamic> json) => TierListTier(
      json['tierRank'] as int,
      json['previousTierRank'] as int,
    );
