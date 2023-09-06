import 'package:sebastian/data/blitz/blitz_data_source.dart';
import 'package:sebastian/data/blitz/models/request_variables.dart';
import 'package:sebastian/data/repositories/champion_repository.dart';
import 'package:sebastian/domain/champion_tier/champion_tier.dart';
import 'package:sebastian/presentation/champions_tier_list/bloc/champions_tier_list_models.dart';

class ChampionTierRepository {
  final BlitzDataSource _blitzDataSource;
  final ChampionRepository _championRepository;

  ChampionTierRepository(
    this._blitzDataSource,
    this._championRepository,
  );

  final _cache = <AvailableQueue, List<ChampionTier>>{};

  Future<List<ChampionTier>> loadChampionTiers(AvailableQueue queue) async {
    if (_cache[queue] != null) return _cache[queue]!;

    final stats = await _blitzDataSource.getAllChampionsStats(AllChampionsStatsRequestVariables(queue.queue));

    final championTiers = <ChampionTier>[];
    for (var i = 0; i < stats.length; i++) {
      final stat = stats[i];

      final champion = _championRepository.getChampion(stat.championId);
      if (champion == null) continue; //Unknown champion, skip

      championTiers.add(
        ChampionTier(
          originRank: i,
          championId: stat.championId,
          championName: champion.name,
          games: stat.games,
          banRate: ((stat.banRate ?? 0) * 100),
          pickRate: (stat.pickRate * 100),
          winRate: ((stat.wins / stat.games) * 100),
          role: stat.role?.role,
          tierRank: stat.tierListTier?.tierRank,
        ),
      );
    }

    _cache[queue] = championTiers;
    return championTiers;
  }
}
