import 'dart:convert';

class ChestEligibility {
  final int earnableChests;
  final int maximumChests;
  final int nextChestRechargeTime;

  ChestEligibility({
    required this.earnableChests,
    required this.maximumChests,
    required this.nextChestRechargeTime,
  });

  DateTime nextChestDateTime() {
    return DateTime.fromMillisecondsSinceEpoch(nextChestRechargeTime).toLocal();
  }

  ChestEligibility copyWith({
    int? earnableChests,
    int? maximumChests,
    int? nextChestRechargeTime,
  }) {
    return ChestEligibility(
      earnableChests: earnableChests ?? this.earnableChests,
      maximumChests: maximumChests ?? this.maximumChests,
      nextChestRechargeTime: nextChestRechargeTime ?? this.nextChestRechargeTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'earnableChests': earnableChests,
      'maximumChests': maximumChests,
      'nextChestRechargeTime': nextChestRechargeTime,
    };
  }

  factory ChestEligibility.fromMap(Map<String, dynamic> map) {
    return ChestEligibility(
      earnableChests: map['earnableChests']?.toInt() ?? 0,
      maximumChests: map['maximumChests']?.toInt() ?? 0,
      nextChestRechargeTime: map['nextChestRechargeTime']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChestEligibility.fromJson(String source) => ChestEligibility.fromMap(json.decode(source));

  @override
  String toString() =>
      'ChestEligibility(earnableChests: $earnableChests, maximumChests: $maximumChests, nextChestRechargeTime: $nextChestRechargeTime)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChestEligibility &&
        other.earnableChests == earnableChests &&
        other.maximumChests == maximumChests &&
        other.nextChestRechargeTime == nextChestRechargeTime;
  }

  @override
  int get hashCode => earnableChests.hashCode ^ maximumChests.hashCode ^ nextChestRechargeTime.hashCode;
}
