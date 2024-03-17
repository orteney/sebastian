// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_variables.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$BuildRequestVariablesToJson(
    BuildRequestVariables instance) {
  final val = <String, dynamic>{
    'championId': instance.championId,
    'queue': _$BlitzQueueEnumMap[instance.queue]!,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('role', blitzRoleToJson(instance.role));
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

Map<String, dynamic> _$AllChampionsStatsRequestVariablesToJson(
        AllChampionsStatsRequestVariables instance) =>
    <String, dynamic>{
      'queue': _$BlitzQueueEnumMap[instance.queue]!,
    };
