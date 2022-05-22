import 'dart:convert';

import 'package:flutter/foundation.dart';

class PickSession {
  final List<int> benchChampionIds;
  final List<TeamMate> myTeam;

  PickSession({
    required this.benchChampionIds,
    required this.myTeam,
  });

  PickSession copyWith({
    List<int>? benchChampionIds,
    List<TeamMate>? myTeam,
  }) {
    return PickSession(
      benchChampionIds: benchChampionIds ?? this.benchChampionIds,
      myTeam: myTeam ?? this.myTeam,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'benchChampionIds': benchChampionIds,
      'myTeam': myTeam.map((x) => x.toMap()).toList(),
    };
  }

  factory PickSession.fromMap(Map<String, dynamic> map) {
    return PickSession(
      benchChampionIds: List<int>.from(map['benchChampionIds']),
      myTeam:
          List<TeamMate>.from(map['myTeam']?.map((x) => TeamMate.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory PickSession.fromJson(String source) =>
      PickSession.fromMap(json.decode(source));

  @override
  String toString() =>
      'PickSession(benchChampionIds: $benchChampionIds, myTeam: $myTeam)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PickSession &&
        listEquals(other.benchChampionIds, benchChampionIds) &&
        listEquals(other.myTeam, myTeam);
  }

  @override
  int get hashCode => benchChampionIds.hashCode ^ myTeam.hashCode;
}

class TeamMate {
  final int summonerId;
  final int championId;

  TeamMate({
    required this.summonerId,
    required this.championId,
  });

  TeamMate copyWith({
    int? summonerId,
    int? championId,
  }) {
    return TeamMate(
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

  factory TeamMate.fromMap(Map<String, dynamic> map) {
    return TeamMate(
      summonerId: map['summonerId']?.toInt() ?? 0,
      championId: map['championId']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory TeamMate.fromJson(String source) =>
      TeamMate.fromMap(json.decode(source));

  @override
  String toString() =>
      'TeamMate(summonerId: $summonerId, championId: $championId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TeamMate &&
        other.summonerId == summonerId &&
        other.championId == championId;
  }

  @override
  int get hashCode => summonerId.hashCode ^ championId.hashCode;
}
