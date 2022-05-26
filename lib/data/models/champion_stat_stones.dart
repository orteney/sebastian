import 'dart:convert';

class ChampionStatStones {
  final int championId;
  final int milestonesPassed;
  final int stonesAvailable;
  final int stonesIlluminated;
  final int stonesOwned;

  ChampionStatStones({
    required this.championId,
    required this.milestonesPassed,
    required this.stonesAvailable,
    required this.stonesIlluminated,
    required this.stonesOwned,
  });

  factory ChampionStatStones.empty(int championId) => ChampionStatStones(
        championId: championId,
        milestonesPassed: 0,
        stonesAvailable: 0,
        stonesIlluminated: 0,
        stonesOwned: 0,
      );

  ChampionStatStones copyWith({
    int? championId,
    int? milestonesPassed,
    int? stonesAvailable,
    int? stonesIlluminated,
    int? stonesOwned,
  }) {
    return ChampionStatStones(
      championId: championId ?? this.championId,
      milestonesPassed: milestonesPassed ?? this.milestonesPassed,
      stonesAvailable: stonesAvailable ?? this.stonesAvailable,
      stonesIlluminated: stonesIlluminated ?? this.stonesIlluminated,
      stonesOwned: stonesOwned ?? this.stonesOwned,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'championId': championId,
      'milestonesPassed': milestonesPassed,
      'stonesAvailable': stonesAvailable,
      'stonesIlluminated': stonesIlluminated,
      'stonesOwned': stonesOwned,
    };
  }

  factory ChampionStatStones.fromMap(Map<String, dynamic> map) {
    return ChampionStatStones(
      championId: map['championId']?.toInt() ?? 0,
      milestonesPassed: map['milestonesPassed']?.toInt() ?? 0,
      stonesAvailable: map['stonesAvailable']?.toInt() ?? 0,
      stonesIlluminated: map['stonesIlluminated']?.toInt() ?? 0,
      stonesOwned: map['stonesOwned']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChampionStatStones.fromJson(String source) => ChampionStatStones.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ChampionStatStones(championId: $championId, milestonesPassed: $milestonesPassed, stonesAvailable: $stonesAvailable, stonesIlluminated: $stonesIlluminated, stonesOwned: $stonesOwned)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChampionStatStones &&
        other.championId == championId &&
        other.milestonesPassed == milestonesPassed &&
        other.stonesAvailable == stonesAvailable &&
        other.stonesIlluminated == stonesIlluminated &&
        other.stonesOwned == stonesOwned;
  }

  @override
  int get hashCode {
    return championId.hashCode ^
        milestonesPassed.hashCode ^
        stonesAvailable.hashCode ^
        stonesIlluminated.hashCode ^
        stonesOwned.hashCode;
  }
}
