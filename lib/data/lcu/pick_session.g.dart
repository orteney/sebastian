// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pick_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PickSession _$PickSessionFromJson(Map<String, dynamic> json) => PickSession(
      benchChampions: (json['benchChampions'] as List<dynamic>)
          .map((e) => BenchChampion.fromJson(e as Map<String, dynamic>))
          .toList(),
      myTeam: (json['myTeam'] as List<dynamic>)
          .map((e) => TeamPick.fromJson(e as Map<String, dynamic>))
          .toList(),
      isCustomGame: json['isCustomGame'] as bool,
      benchEnabled: json['benchEnabled'] as bool,
    );

BenchChampion _$BenchChampionFromJson(Map<String, dynamic> json) =>
    BenchChampion(
      championId: (json['championId'] as num).toInt(),
    );

TeamPick _$TeamPickFromJson(Map<String, dynamic> json) => TeamPick(
      summonerId: (json['summonerId'] as num).toInt(),
      championId: (json['championId'] as num).toInt(),
      selectedSkinId: (json['selectedSkinId'] as num).toInt(),
      championPickIntent: (json['championPickIntent'] as num?)?.toInt(),
      assignedPosition: $enumDecodeNullable(
          _$PickPositionEnumMap, json['assignedPosition'],
          unknownValue: PickPosition.unknown),
    );

const _$PickPositionEnumMap = {
  PickPosition.top: 'top',
  PickPosition.jungle: 'jungle',
  PickPosition.middle: 'middle',
  PickPosition.bottom: 'bottom',
  PickPosition.support: 'utility',
  PickPosition.unknown: 'unknown',
};
