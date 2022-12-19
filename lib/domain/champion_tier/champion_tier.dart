import 'package:sebastian/domain/core/role.dart';

class ChampionTier {
  final int originRank;

  final int championId;
  final String championName;

  final int games;

  final Role? role;
  final int? tierRank;

  final double banRate;
  final double pickRate;
  final double winRate;

  ChampionTier({
    required this.originRank,
    required this.championId,
    required this.championName,
    required this.games,
    this.role,
    this.tierRank,
    required this.banRate,
    required this.pickRate,
    required this.winRate,
  });

  @override
  bool operator ==(covariant ChampionTier other) {
    if (identical(this, other)) return true;

    return other.originRank == originRank &&
        other.championId == championId &&
        other.championName == championName &&
        other.games == games &&
        other.role == role &&
        other.tierRank == tierRank &&
        other.banRate == banRate &&
        other.pickRate == pickRate &&
        other.winRate == winRate;
  }

  @override
  int get hashCode {
    return originRank.hashCode ^
        championId.hashCode ^
        championName.hashCode ^
        games.hashCode ^
        role.hashCode ^
        tierRank.hashCode ^
        banRate.hashCode ^
        pickRate.hashCode ^
        winRate.hashCode;
  }
}
