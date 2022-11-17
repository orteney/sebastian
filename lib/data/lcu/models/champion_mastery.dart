import 'package:json_annotation/json_annotation.dart';

part 'champion_mastery.g.dart';

@JsonSerializable(createToJson: false)
class ChampionMastery {
  final int championId;
  final int championLevel;
  final int championPoints;
  final int championPointsUntilNextLevel;
  final bool chestGranted;
  final int tokensEarned;

  ChampionMastery({
    required this.championId,
    required this.championLevel,
    required this.championPoints,
    required this.championPointsUntilNextLevel,
    required this.chestGranted,
    required this.tokensEarned,
  });

  factory ChampionMastery.empty(int championId) => ChampionMastery(
        championId: championId,
        championLevel: 0,
        championPoints: 0,
        championPointsUntilNextLevel: 0,
        chestGranted: false,
        tokensEarned: 0,
      );

  ChampionMastery copyWith({
    int? championId,
    int? championLevel,
    int? championPoints,
    int? championPointsUntilNextLevel,
    bool? chestGranted,
    int? tokensEarned,
  }) {
    return ChampionMastery(
      championId: championId ?? this.championId,
      championLevel: championLevel ?? this.championLevel,
      championPoints: championPoints ?? this.championPoints,
      championPointsUntilNextLevel: championPointsUntilNextLevel ?? this.championPointsUntilNextLevel,
      chestGranted: chestGranted ?? this.chestGranted,
      tokensEarned: tokensEarned ?? this.tokensEarned,
    );
  }

  @override
  String toString() {
    return 'ChampionMastery(championId: $championId, championLevel: $championLevel, championPoints: $championPoints, championPointsUntilNextLevel: $championPointsUntilNextLevel, chestGranted: $chestGranted, tokensEarned: $tokensEarned)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChampionMastery &&
        other.championId == championId &&
        other.championLevel == championLevel &&
        other.championPoints == championPoints &&
        other.championPointsUntilNextLevel == championPointsUntilNextLevel &&
        other.chestGranted == chestGranted &&
        other.tokensEarned == tokensEarned;
  }

  @override
  int get hashCode {
    return championId.hashCode ^
        championLevel.hashCode ^
        championPoints.hashCode ^
        championPointsUntilNextLevel.hashCode ^
        chestGranted.hashCode ^
        tokensEarned.hashCode;
  }

  factory ChampionMastery.fromJson(Map<String, dynamic> json) => _$ChampionMasteryFromJson(json);
}
