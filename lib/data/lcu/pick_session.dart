// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart' show listEquals;
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pick_session.g.dart';

@JsonSerializable(createToJson: false)
class PickSession {
  final List<BenchChampion> benchChampions;
  final List<TeamPick> myTeam;
  final bool isCustomGame;
  final bool benchEnabled;

  PickSession({
    required this.benchChampions,
    required this.myTeam,
    required this.isCustomGame,
    required this.benchEnabled,
  });

  PickSession copyWith({
    List<BenchChampion>? benchChampions,
    List<TeamPick>? myTeam,
    bool? isCustomGame,
    bool? benchEnabled,
  }) {
    return PickSession(
      benchChampions: benchChampions ?? this.benchChampions,
      myTeam: myTeam ?? this.myTeam,
      isCustomGame: isCustomGame ?? this.isCustomGame,
      benchEnabled: benchEnabled ?? this.benchEnabled,
    );
  }

  @override
  String toString() {
    return 'PickSession(benchChampions: $benchChampions, myTeam: $myTeam, isCustomGame: $isCustomGame, benchEnabled: $benchEnabled)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PickSession &&
        listEquals(other.benchChampions, benchChampions) &&
        listEquals(other.myTeam, myTeam) &&
        other.isCustomGame == isCustomGame &&
        other.benchEnabled == benchEnabled;
  }

  @override
  int get hashCode {
    return benchChampions.hashCode ^ myTeam.hashCode ^ isCustomGame.hashCode ^ benchEnabled.hashCode;
  }

  factory PickSession.fromJson(Map<String, dynamic> json) => _$PickSessionFromJson(json);
}

@JsonSerializable(createToJson: false)
class BenchChampion {
  final int championId;

  BenchChampion({
    required this.championId,
  });

  @override
  bool operator ==(covariant BenchChampion other) {
    if (identical(this, other)) return true;

    return other.championId == championId;
  }

  @override
  int get hashCode => championId.hashCode;

  factory BenchChampion.fromJson(Map<String, dynamic> json) => _$BenchChampionFromJson(json);
}

///Example
///{
///     "assignedPosition": "bottom",
///     "cellId": 5,
///     "championId": 202,
///     "championPickIntent": 0,
///     "entitledFeatureType": "NONE",
///     "nameVisibilityType": "VISIBLE",
///     "puuid": "706b2484-6d02-5de3-906a-073f0b98fc2a",
///     "selectedSkinId": 202000,
///     "spell1Id": 4,
///     "spell2Id": 3,
///     "summonerId": 2649717133772256,
///     "team": 2,
///     "wardSkinId": -1
///   }
@JsonSerializable(createToJson: false)
class TeamPick {
  final int summonerId;
  final int championId;
  final String? assignedPosition;

  const TeamPick({
    required this.summonerId,
    required this.championId,
    this.assignedPosition,
  });

  TeamPick copyWith({
    int? summonerId,
    int? championId,
    String? assignedPosition,
  }) {
    return TeamPick(
      summonerId: summonerId ?? this.summonerId,
      championId: championId ?? this.championId,
      assignedPosition: assignedPosition ?? this.assignedPosition,
    );
  }

  @override
  String toString() =>
      'TeamPick(summonerId: $summonerId, championId: $championId, assignedPosition: $assignedPosition)';

  @override
  bool operator ==(covariant TeamPick other) {
    if (identical(this, other)) return true;

    return other.summonerId == summonerId &&
        other.championId == championId &&
        other.assignedPosition == assignedPosition;
  }

  @override
  int get hashCode => summonerId.hashCode ^ championId.hashCode ^ assignedPosition.hashCode;

  factory TeamPick.fromJson(Map<String, dynamic> json) => _$TeamPickFromJson(json);
}
