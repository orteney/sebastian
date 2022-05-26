import 'package:champmastery/data/models/champion_mastery.dart';
import 'package:champmastery/data/models/champion_stat_stones.dart';

class Champion {
  final int id;
  final String name;
  final ChampionMastery mastery;
  final ChampionStatStones statStones;

  Champion({
    required this.id,
    required this.name,
    required this.mastery,
    required this.statStones,
  });

  Champion copyWith({
    int? id,
    String? name,
    ChampionMastery? mastery,
    ChampionStatStones? statStones,
  }) {
    return Champion(
      id: id ?? this.id,
      name: name ?? this.name,
      mastery: mastery ?? this.mastery,
      statStones: statStones ?? this.statStones,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Champion &&
        other.id == id &&
        other.name == name &&
        other.mastery == mastery &&
        other.statStones == statStones;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ mastery.hashCode ^ statStones.hashCode;
  }

  @override
  String toString() {
    return 'Champion(id: $id, name: $name, mastery: $mastery, statStones: $statStones)';
  }
}
