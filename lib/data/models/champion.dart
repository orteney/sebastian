import 'package:champmastery/data/models/champion_mastery.dart';

class Champion {
  final int id;
  final String name;
  final ChampionMastery mastery;

  Champion({
    required this.id,
    required this.name,
    required this.mastery,
  });

  Champion copyWith({
    int? id,
    String? name,
    ChampionMastery? mastery,
  }) {
    return Champion(
      id: id ?? this.id,
      name: name ?? this.name,
      mastery: mastery ?? this.mastery,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Champion && other.id == id && other.name == name && other.mastery == mastery;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ mastery.hashCode;

  @override
  String toString() => 'Champion(id: $id, name: $name, mastery: $mastery)';
}
