import 'package:json_annotation/json_annotation.dart';
import 'package:sebastian/data/blitz/models/request_variables.dart';

part 'all_champions_stats.g.dart';

@JsonSerializable(createToJson: false)
class ChampionsStatsResponse {
  final ChampionsStatsData data;

  ChampionsStatsResponse(this.data);

  factory ChampionsStatsResponse.fromJson(Map<String, dynamic> json) => _$ChampionsStatsResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class ChampionsStatsData {
  final List<ChampionStats> allChampionStats;

  ChampionsStatsData(this.allChampionStats);

  factory ChampionsStatsData.fromJson(Map<String, dynamic> json) => _$ChampionsStatsDataFromJson(json);
}

@JsonSerializable(createToJson: false)
class ChampionStats {
  final int championId;

  final int games;
  final int wins;

  final BlitzRole? role;
  final TierListTier? tierListTier;

  final double? banRate;
  final double pickRate;

  ChampionStats(
    this.championId,
    this.games,
    this.wins,
    this.role,
    this.tierListTier,
    this.banRate,
    this.pickRate,
  );

  factory ChampionStats.fromJson(Map<String, dynamic> json) => _$ChampionStatsFromJson(json);
}

@JsonSerializable(createToJson: false)
class TierListTier {
  final int tierRank;
  final int previousTierRank;

  TierListTier(this.tierRank, this.previousTierRank);

  factory TierListTier.fromJson(Map<String, dynamic> json) => _$TierListTierFromJson(json);
}
