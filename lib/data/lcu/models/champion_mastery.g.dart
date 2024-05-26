// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'champion_mastery.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChampionsMasteryResponse _$ChampionsMasteryResponseFromJson(
        Map<String, dynamic> json) =>
    ChampionsMasteryResponse(
      (json['championMasteries'] as List<dynamic>)
          .map((e) => ChampionMastery.fromJson(e as Map<String, dynamic>))
          .toList(),
      MasteryChampionSet.fromJson(json['championSet'] as Map<String, dynamic>),
    );

MasteryChampionSet _$MasteryChampionSetFromJson(Map<String, dynamic> json) =>
    MasteryChampionSet(
      (json['champions'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      json['completed'] as bool,
      (json['totalMilestone'] as num).toInt(),
    );

ChampionMastery _$ChampionMasteryFromJson(Map<String, dynamic> json) =>
    ChampionMastery(
      championId: (json['championId'] as num).toInt(),
      championLevel: (json['championLevel'] as num).toInt(),
      championPoints: (json['championPoints'] as num).toInt(),
      championPointsUntilNextLevel:
          (json['championPointsUntilNextLevel'] as num).toInt(),
      championSeasonMilestone: (json['championSeasonMilestone'] as num).toInt(),
      markRequiredForNextLevel:
          (json['markRequiredForNextLevel'] as num).toInt(),
      tokensEarned: (json['tokensEarned'] as num).toInt(),
      milestoneGrades: (json['milestoneGrades'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      nextSeasonMilestone: MasteryMilestone.fromJson(
          json['nextSeasonMilestone'] as Map<String, dynamic>),
    );

MasteryMilestone _$MasteryMilestoneFromJson(Map<String, dynamic> json) =>
    MasteryMilestone(
      json['bonus'] as bool,
      Map<String, int>.from(json['requireGradeCounts'] as Map),
    );
