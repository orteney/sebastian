import 'package:flutter/foundation.dart';

import 'package:sebastian/data/lcu/models/champion_mastery.dart';
import 'package:sebastian/data/lcu/models/champion_stat_stones.dart';

class Champion {
  final int id;
  final String name;
  final ChampionMastery mastery;
  final ChampionStatStones statStones;
  final List<ChampionRole> roles;

  Champion({
    required this.id,
    required this.name,
    required this.mastery,
    required this.statStones,
    required this.roles,
  });

  Champion copyWith({
    int? id,
    String? name,
    ChampionMastery? mastery,
    ChampionStatStones? statStones,
    List<ChampionRole>? roles,
  }) {
    return Champion(
      id: id ?? this.id,
      name: name ?? this.name,
      mastery: mastery ?? this.mastery,
      statStones: statStones ?? this.statStones,
      roles: roles ?? this.roles,
    );
  }

  @override
  bool operator ==(covariant Champion other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.mastery == mastery &&
        other.statStones == statStones &&
        listEquals(other.roles, roles);
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ mastery.hashCode ^ statStones.hashCode ^ roles.hashCode;
  }

  @override
  String toString() {
    return 'Champion{id=$id, name=$name, mastery=$mastery, statStones=$statStones, roles=$roles}';
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
