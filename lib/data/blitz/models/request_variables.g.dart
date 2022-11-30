// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_variables.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$RequestVariablesToJson(RequestVariables instance) {
  final val = <String, dynamic>{
    'queue': _$QueueEnumMap[instance.queue]!,
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

const _$QueueEnumMap = {
  Queue.clashSr: 'CLASH_SR',
  Queue.howlingAbyssAram: 'HOWLING_ABYSS_ARAM',
  Queue.howlingAbyssPoroKing: 'HOWLING_ABYSS_PORO_KING',
  Queue.rankedFlexSr: 'RANKED_FLEX_SR',
  Queue.rankedSolo5X5: 'RANKED_SOLO_5X5',
  Queue.summonersRiftArurf: 'SUMMONERS_RIFT_ARURF',
  Queue.summonersRiftBlindPick: 'SUMMONERS_RIFT_BLIND_PICK',
  Queue.summonersRiftDraftPick: 'SUMMONERS_RIFT_DRAFT_PICK',
  Queue.summonersRiftUrf: 'SUMMONERS_RIFT_URF',
};

const _$BlitzRoleEnumMap = {
  BlitzRole.adc: 'ADC',
  BlitzRole.jungle: 'JUNGLE',
  BlitzRole.mid: 'MID',
  BlitzRole.support: 'SUPPORT',
  BlitzRole.top: 'TOP',
};
