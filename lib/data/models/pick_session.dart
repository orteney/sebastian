import 'dart:convert';

import 'package:flutter/foundation.dart';

class PickSession {
  final List<int> benchChampionIds;
  final List<TeamPick> myTeam;
  final bool isCustomGame;
  final bool benchEnabled;

  PickSession({
    required this.benchChampionIds,
    required this.myTeam,
    required this.isCustomGame,
    required this.benchEnabled,
  });

  PickSession copyWith({
    List<int>? benchChampionIds,
    List<TeamPick>? myTeam,
    bool? isCustomGame,
    bool? benchEnabled,
  }) {
    return PickSession(
      benchChampionIds: benchChampionIds ?? this.benchChampionIds,
      myTeam: myTeam ?? this.myTeam,
      isCustomGame: isCustomGame ?? this.isCustomGame,
      benchEnabled: benchEnabled ?? this.benchEnabled,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'benchChampionIds': benchChampionIds,
      'myTeam': myTeam.map((x) => x.toMap()).toList(),
      'isCustomGame': isCustomGame,
      'benchEnabled': benchEnabled,
    };
  }

  factory PickSession.fromMap(Map<String, dynamic> map) {
    return PickSession(
      benchChampionIds: List<int>.from(map['benchChampionIds']),
      myTeam: List<TeamPick>.from(map['myTeam']?.map((x) => TeamPick.fromMap(x))),
      isCustomGame: map['isCustomGame'] ?? false,
      benchEnabled: map['benchEnabled'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory PickSession.fromJson(String source) =>
      PickSession.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PickSession(benchChampionIds: $benchChampionIds, myTeam: $myTeam, isCustomGame: $isCustomGame, benchEnabled: $benchEnabled)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PickSession &&
      listEquals(other.benchChampionIds, benchChampionIds) &&
      listEquals(other.myTeam, myTeam) &&
      other.isCustomGame == isCustomGame &&
      other.benchEnabled == benchEnabled;
  }

  @override
  int get hashCode {
    return benchChampionIds.hashCode ^
      myTeam.hashCode ^
      isCustomGame.hashCode ^
      benchEnabled.hashCode;
  }
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

  factory TeamPick.fromJson(String source) =>
      TeamPick.fromMap(json.decode(source));

  @override
  String toString() =>
      'TeamPick(summonerId: $summonerId, championId: $championId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TeamPick &&
        other.summonerId == summonerId &&
        other.championId == championId;
  }

  @override
  int get hashCode => summonerId.hashCode ^ championId.hashCode;
}
