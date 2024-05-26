import 'package:flutter/foundation.dart';

import 'package:json_annotation/json_annotation.dart';

part 'champion_mastery.g.dart';

@JsonSerializable(createToJson: false)
class ChampionsMasteryResponse {
  final List<ChampionMastery> championMasteries;
  final MasteryChampionSet championSet;

  ChampionsMasteryResponse(
    this.championMasteries,
    this.championSet,
  );

  factory ChampionsMasteryResponse.fromJson(Map<String, dynamic> json) => _$ChampionsMasteryResponseFromJson(json);
}

///{
///    "champions": [
///        64,
///        145,
///        81,
///        67,
///        39,
///        120,
///        234,
///        202,
///        77,
///        141
///    ],
///    "completed": false,
///    "totalMilestone": 0
///}
@JsonSerializable(createToJson: false)
class MasteryChampionSet {
  final List<int> champions;
  final bool completed;
  final int totalMilestone;

  MasteryChampionSet(
    this.champions,
    this.completed,
    this.totalMilestone,
  );

  factory MasteryChampionSet.fromJson(Map<String, dynamic> json) => _$MasteryChampionSetFromJson(json);
}

/// {
///     "championId": 67,
///     "championLevel": 15,
///     "championPoints": 180026,
///     "championPointsSinceLastLevel": 49426,
///     "championPointsUntilNextLevel": -38426,
///     "championSeasonMilestone": 0,
///     "chestGranted": false,
///     "highestGrade": "S",
///     "lastPlayTime": 1716485491000,
///     "markRequiredForNextLevel": 2,
///     "milestoneGrades": [
///         "S"
///     ],
///     "nextSeasonMilestone": {
///         "bonus": false,
///         "requireGradeCounts": {
///             "B-": 1,
///             "C-": 4
///         },
///         "rewardConfig": {
///             "maximumReward": 7,
///             "rewardValue": "5f4333db-e90d-4705-903b-08dbf5e61006"
///         },
///         "rewardMarks": 1
///     },
///     "puuid": "e6920a01-f307-50c4-8672-524dc530c047",
///     "tokensEarned": 0
/// }
@JsonSerializable(createToJson: false)
class ChampionMastery {
  final int championId;
  final int championLevel;
  final int championPoints;
  final int championPointsUntilNextLevel;
  final int championSeasonMilestone;
  final int markRequiredForNextLevel;
  final int tokensEarned;
  final List<String> milestoneGrades;
  final MasteryMilestone nextSeasonMilestone;

  ChampionMastery({
    required this.championId,
    required this.championLevel,
    required this.championPoints,
    required this.championPointsUntilNextLevel,
    required this.championSeasonMilestone,
    required this.markRequiredForNextLevel,
    required this.tokensEarned,
    required this.milestoneGrades,
    required this.nextSeasonMilestone,
  });

  factory ChampionMastery.empty(int championId) => ChampionMastery(
        championId: championId,
        championLevel: 0,
        championPoints: 0,
        championPointsUntilNextLevel: 0,
        championSeasonMilestone: 0,
        markRequiredForNextLevel: 0,
        tokensEarned: 0,
        milestoneGrades: const [],
        nextSeasonMilestone: MasteryMilestone(false, const {}),
      );

  ChampionMastery copyWith({
    int? championId,
    int? championLevel,
    int? championPoints,
    int? championPointsUntilNextLevel,
    int? championSeasonMilestone,
    int? markRequiredForNextLevel,
    int? tokensEarned,
    List<String>? milestoneGrades,
    MasteryMilestone? nextSeasonMilestone,
  }) {
    return ChampionMastery(
      championId: championId ?? this.championId,
      championLevel: championLevel ?? this.championLevel,
      championPoints: championPoints ?? this.championPoints,
      championPointsUntilNextLevel: championPointsUntilNextLevel ?? this.championPointsUntilNextLevel,
      championSeasonMilestone: championSeasonMilestone ?? this.championSeasonMilestone,
      markRequiredForNextLevel: markRequiredForNextLevel ?? this.markRequiredForNextLevel,
      tokensEarned: tokensEarned ?? this.tokensEarned,
      milestoneGrades: milestoneGrades ?? this.milestoneGrades,
      nextSeasonMilestone: nextSeasonMilestone ?? this.nextSeasonMilestone,
    );
  }

  @override
  String toString() {
    return 'ChampionMastery(championId: $championId, championLevel: $championLevel, championPoints: $championPoints, championPointsUntilNextLevel: $championPointsUntilNextLevel, championSeasonMilestone: $championSeasonMilestone, markRequiredForNextLevel: $markRequiredForNextLevel, tokensEarned: $tokensEarned, milestoneGrades: $milestoneGrades, nextSeasonMilestone: $nextSeasonMilestone)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChampionMastery &&
        other.championId == championId &&
        other.championLevel == championLevel &&
        other.championPoints == championPoints &&
        other.championPointsUntilNextLevel == championPointsUntilNextLevel &&
        other.championSeasonMilestone == championSeasonMilestone &&
        other.markRequiredForNextLevel == markRequiredForNextLevel &&
        other.tokensEarned == tokensEarned &&
        listEquals(other.milestoneGrades, milestoneGrades) &&
        other.nextSeasonMilestone == nextSeasonMilestone;
  }

  @override
  int get hashCode {
    return championId.hashCode ^
        championLevel.hashCode ^
        championPoints.hashCode ^
        championPointsUntilNextLevel.hashCode ^
        championSeasonMilestone.hashCode ^
        markRequiredForNextLevel.hashCode ^
        tokensEarned.hashCode ^
        milestoneGrades.hashCode ^
        nextSeasonMilestone.hashCode;
  }

  factory ChampionMastery.fromJson(Map<String, dynamic> json) => _$ChampionMasteryFromJson(json);
}

///{
///    "bonus": false,
///    "requireGradeCounts": {
///        "B-": 1,
///        "C-": 4
///    },
///    "rewardConfig": {
///        "maximumReward": 7,
///        "rewardValue": "5f4333db-e90d-4705-903b-08dbf5e61006"
///    },
///    "rewardMarks": 1
///}

@JsonSerializable(createToJson: false)
class MasteryMilestone {
  final bool bonus;
  final Map<String, int> requireGradeCounts;

  MasteryMilestone(
    this.bonus,
    this.requireGradeCounts,
  );

  factory MasteryMilestone.fromJson(Map<String, dynamic> json) => _$MasteryMilestoneFromJson(json);
}
