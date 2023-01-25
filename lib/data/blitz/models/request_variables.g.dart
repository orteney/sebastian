// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_variables.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$BuildRequestVariablesToJson(
    BuildRequestVariables instance) {
  final val = <String, dynamic>{
    'queue': _$BlitzQueueEnumMap[instance.queue]!,
    'region': instance.region,
    'tier': instance.tier,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('role', _$BlitzRoleEnumMap[instance.role]);
  val['championId'] = instance.championId;
  writeNotNull('opponentChampionId', instance.opponentChampionId);
  return val;
}

const _$BlitzQueueEnumMap = {
  BlitzQueue.clashSr: 'CLASH_SR',
  BlitzQueue.howlingAbyssAram: 'HOWLING_ABYSS_ARAM',
  BlitzQueue.howlingAbyssPoroKing: 'HOWLING_ABYSS_PORO_KING',
  BlitzQueue.rankedFlexSr: 'RANKED_FLEX_SR',
  BlitzQueue.rankedSolo5X5: 'RANKED_SOLO_5X5',
  BlitzQueue.summonersRiftArurf: 'SUMMONERS_RIFT_ARURF',
  BlitzQueue.summonersRiftBlindPick: 'SUMMONERS_RIFT_BLIND_PICK',
  BlitzQueue.summonersRiftDraftPick: 'SUMMONERS_RIFT_DRAFT_PICK',
  BlitzQueue.summonersRiftUrf: 'SUMMONERS_RIFT_URF',
};

const _$BlitzRoleEnumMap = {
  BlitzRole.adc: 'ADC',
  BlitzRole.jungle: 'JUNGLE',
  BlitzRole.mid: 'MID',
  BlitzRole.support: 'SUPPORT',
  BlitzRole.top: 'TOP',
};

Map<String, dynamic> _$AllChampionsStatsRequestVariablesToJson(
        AllChampionsStatsRequestVariables instance) =>
    <String, dynamic>{
      'queue': _$BlitzQueueEnumMap[instance.queue]!,
    };
