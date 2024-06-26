// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Challenge _$ChallengeFromJson(Map<String, dynamic> json) => Challenge(
      (json['id'] as num).toInt(),
      json['name'] as String,
      json['description'] as String,
      json['isCapstone'] as bool,
      (json['availableIds'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      (json['completedIds'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      (json['percentile'] as num).toDouble(),
      (json['position'] as num).toInt(),
      (json['pointsAwarded'] as num).toInt(),
      $enumDecode(_$ChallengeLevelEnumMap, json['currentLevel']),
      (json['currentValue'] as num).toDouble(),
      (json['currentThreshold'] as num).toDouble(),
      (json['nextThreshold'] as num).toDouble(),
      json['nextLevel'] as String,
      (json['gameModes'] as List<dynamic>)
          .map((e) => $enumDecode(_$ChallengeGameModeEnumMap, e,
              unknownValue: ChallengeGameMode.unknown))
          .toList(),
    );

const _$ChallengeLevelEnumMap = {
  ChallengeLevel.none: 'NONE',
  ChallengeLevel.iron: 'IRON',
  ChallengeLevel.bronze: 'BRONZE',
  ChallengeLevel.silver: 'SILVER',
  ChallengeLevel.gold: 'GOLD',
  ChallengeLevel.platinum: 'PLATINUM',
  ChallengeLevel.diamond: 'DIAMOND',
  ChallengeLevel.master: 'MASTER',
  ChallengeLevel.grandmaster: 'GRANDMASTER',
  ChallengeLevel.challenger: 'CHALLENGER',
};

const _$ChallengeGameModeEnumMap = {
  ChallengeGameMode.classic: 'CLASSIC',
  ChallengeGameMode.aram: 'ARAM',
  ChallengeGameMode.arena: 'CHERRY',
  ChallengeGameMode.unknown: 'UNKNOWN',
};
