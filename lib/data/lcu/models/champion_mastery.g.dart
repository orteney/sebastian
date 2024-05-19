// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'champion_mastery.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChampionMastery _$ChampionMasteryFromJson(Map<String, dynamic> json) =>
    ChampionMastery(
      championId: (json['championId'] as num).toInt(),
      championLevel: (json['championLevel'] as num).toInt(),
      championPoints: (json['championPoints'] as num).toInt(),
      championPointsUntilNextLevel:
          (json['championPointsUntilNextLevel'] as num).toInt(),
      chestGranted: json['chestGranted'] as bool,
      tokensEarned: (json['tokensEarned'] as num).toInt(),
    );
