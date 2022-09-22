// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

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

  factory PickSession.fromMap(Map<String, dynamic> map) {
    return PickSession(
      benchChampions: List<BenchChampion>.from(
        (map['benchChampions'] as List).map<BenchChampion>(
          (x) => BenchChampion.fromMap(x as Map<String, dynamic>),
        ),
      ),
      myTeam: List<TeamPick>.from(
        (map['myTeam'] as List).map<TeamPick>(
          (x) => TeamPick.fromMap(x as Map<String, dynamic>),
        ),
      ),
      isCustomGame: map['isCustomGame'] as bool,
      benchEnabled: map['benchEnabled'] as bool,
    );
  }

  factory PickSession.fromJson(String source) => PickSession.fromMap(json.decode(source) as Map<String, dynamic>);

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
}

class BenchChampion {
  final int championId;

  BenchChampion({
    required this.championId,
  });

  factory BenchChampion.fromMap(Map<String, dynamic> map) {
    return BenchChampion(
      championId: map['championId'] as int,
    );
  }

  factory BenchChampion.fromJson(String source) => BenchChampion.fromMap(json.decode(source) as Map<String, dynamic>);
}

class TeamPick {
  final int summonerId;
  final int championId;

  TeamPick({
    required this.summonerId,
    required this.championId,
  });

  TeamPick copyWith({
    int? summonerId,
    int? championId,
  }) {
    return TeamPick(
      summonerId: summonerId ?? this.summonerId,
      championId: championId ?? this.championId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'summonerId': summonerId,
      'championId': championId,
    };
  }

  factory TeamPick.fromMap(Map<String, dynamic> map) {
    return TeamPick(
      summonerId: map['summonerId']?.toInt() ?? 0,
      championId: map['championId']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory TeamPick.fromJson(String source) => TeamPick.fromMap(json.decode(source));

  @override
  String toString() => 'TeamPick(summonerId: $summonerId, championId: $championId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TeamPick && other.summonerId == summonerId && other.championId == championId;
  }

  @override
  int get hashCode => summonerId.hashCode ^ championId.hashCode;
}
