import 'package:json_annotation/json_annotation.dart';

part 'chest_eligibility.g.dart';

@JsonSerializable(createToJson: false)
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

  factory ChestEligibility.fromJson(Map<String, dynamic> json) => _$ChestEligibilityFromJson(json);
}
