import 'dart:convert';

import 'package:champmastery/data/models/chest_eligibility.dart';

class Summoner {
  final int accountId;
  final String displayName;
  final int summonerId;
  final int summonerLevel;
  final int xpSinceLastLevel;
  final int xpUntilNextLevel;
  final ChestEligibility? chestEligibility;

  Summoner({
    required this.accountId,
    required this.displayName,
    required this.summonerId,
    required this.summonerLevel,
    required this.xpSinceLastLevel,
    required this.xpUntilNextLevel,
    this.chestEligibility,
  });

  Map<String, dynamic> toMap() {
    return {
      'accountId': accountId,
      'displayName': displayName,
      'summonerId': summonerId,
      'summonerLevel': summonerLevel,
      'xpSinceLastLevel': xpSinceLastLevel,
      'xpUntilNextLevel': xpUntilNextLevel,
      'chestEligibility': chestEligibility?.toMap(),
    };
  }

  factory Summoner.fromMap(Map<String, dynamic> map) {
    return Summoner(
      accountId: map['accountId']?.toInt() ?? 0,
      displayName: map['displayName'] ?? '',
      summonerId: map['summonerId']?.toInt() ?? 0,
      summonerLevel: map['summonerLevel']?.toInt() ?? 0,
      xpSinceLastLevel: map['xpSinceLastLevel']?.toInt() ?? 0,
      xpUntilNextLevel: map['xpUntilNextLevel']?.toInt() ?? 0,
      chestEligibility: map['chestEligibility'] != null ? ChestEligibility.fromMap(map['chestEligibility']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Summoner.fromJson(String source) => Summoner.fromMap(json.decode(source));

  Summoner copyWith({
    int? accountId,
    String? displayName,
    int? summonerId,
    int? summonerLevel,
    int? xpSinceLastLevel,
    int? xpUntilNextLevel,
    ChestEligibility? chestEligibility,
  }) {
    return Summoner(
      accountId: accountId ?? this.accountId,
      displayName: displayName ?? this.displayName,
      summonerId: summonerId ?? this.summonerId,
      summonerLevel: summonerLevel ?? this.summonerLevel,
      xpSinceLastLevel: xpSinceLastLevel ?? this.xpSinceLastLevel,
      xpUntilNextLevel: xpUntilNextLevel ?? this.xpUntilNextLevel,
      chestEligibility: chestEligibility ?? this.chestEligibility,
    );
  }

  @override
  String toString() {
    return 'Summoner(accountId: $accountId, displayName: $displayName, summonerId: $summonerId, summonerLevel: $summonerLevel, xpSinceLastLevel: $xpSinceLastLevel, xpUntilNextLevel: $xpUntilNextLevel, chestEligibility: $chestEligibility)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Summoner &&
        other.accountId == accountId &&
        other.displayName == displayName &&
        other.summonerId == summonerId &&
        other.summonerLevel == summonerLevel &&
        other.xpSinceLastLevel == xpSinceLastLevel &&
        other.xpUntilNextLevel == xpUntilNextLevel &&
        other.chestEligibility == chestEligibility;
  }

  @override
  int get hashCode {
    return accountId.hashCode ^
        displayName.hashCode ^
        summonerId.hashCode ^
        summonerLevel.hashCode ^
        xpSinceLastLevel.hashCode ^
        xpUntilNextLevel.hashCode ^
        chestEligibility.hashCode;
  }
}
