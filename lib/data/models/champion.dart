import 'package:flutter/foundation.dart';

import 'package:sebastian/data/lcu/models/champion_mastery.dart';
import 'package:sebastian/data/lcu/models/champion_stat_stones.dart';

class Champion {
  final int id;
  final String name;
  final ChampionMastery mastery;
  final ChampionStatStones statStones;
  final List<ChampionRole> roles;
  final bool inMasterySet;

  Champion({
    required this.id,
    required this.name,
    required this.mastery,
    required this.statStones,
    required this.roles,
    required this.inMasterySet,
  });

  Champion copyWith({
    int? id,
    String? name,
    ChampionMastery? mastery,
    ChampionStatStones? statStones,
    List<ChampionRole>? roles,
    bool? inMasterySet,
  }) {
    return Champion(
      id: id ?? this.id,
      name: name ?? this.name,
      mastery: mastery ?? this.mastery,
      statStones: statStones ?? this.statStones,
      roles: roles ?? this.roles,
      inMasterySet: inMasterySet ?? this.inMasterySet,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Champion &&
        other.id == id &&
        other.name == name &&
        other.mastery == mastery &&
        other.statStones == statStones &&
        listEquals(other.roles, roles) &&
        other.inMasterySet == inMasterySet;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        mastery.hashCode ^
        statStones.hashCode ^
        roles.hashCode ^
        inMasterySet.hashCode;
  }

  @override
  String toString() {
    return 'Champion(id: $id, name: $name, mastery: $mastery, statStones: $statStones, roles: $roles, inMasterySet: $inMasterySet)';
  }
}

enum ChampionRole {
  assassin,
  fighter,
  mage,
  marksman,
  support,
  tank,
}
