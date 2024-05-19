class Summoner {
  final int accountId;
  final String displayName;
  final int summonerId;
  final int summonerLevel;
  final int xpSinceLastLevel;
  final int xpUntilNextLevel;

  Summoner({
    required this.accountId,
    required this.displayName,
    required this.summonerId,
    required this.summonerLevel,
    required this.xpSinceLastLevel,
    required this.xpUntilNextLevel,
  });

  Summoner copyWith({
    int? accountId,
    String? displayName,
    int? summonerId,
    int? summonerLevel,
    int? xpSinceLastLevel,
    int? xpUntilNextLevel,
  }) {
    return Summoner(
      accountId: accountId ?? this.accountId,
      displayName: displayName ?? this.displayName,
      summonerId: summonerId ?? this.summonerId,
      summonerLevel: summonerLevel ?? this.summonerLevel,
      xpSinceLastLevel: xpSinceLastLevel ?? this.xpSinceLastLevel,
      xpUntilNextLevel: xpUntilNextLevel ?? this.xpUntilNextLevel,
    );
  }

  @override
  String toString() {
    return 'Summoner(accountId: $accountId, displayName: $displayName, summonerId: $summonerId, summonerLevel: $summonerLevel, xpSinceLastLevel: $xpSinceLastLevel, xpUntilNextLevel: $xpUntilNextLevel)';
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
        other.xpUntilNextLevel == xpUntilNextLevel;
  }

  @override
  int get hashCode {
    return accountId.hashCode ^
        displayName.hashCode ^
        summonerId.hashCode ^
        summonerLevel.hashCode ^
        xpSinceLastLevel.hashCode ^
        xpUntilNextLevel.hashCode;
  }
}
