import 'package:rxdart/rxdart.dart';

import 'package:sebastian/data/lcu/lcu.dart';
import 'package:sebastian/data/lcu/models/champion_mastery.dart';
import 'package:sebastian/data/lcu/models/champion_stat_stones.dart';
import 'package:sebastian/data/models/champion.dart';
import 'package:sebastian/data/models/lcu_image.dart';
import 'package:sebastian/data/utils/cyrillic_comparator.dart';

class ChampionRepository {
  final LCU lcu;

  ChampionRepository({
    required this.lcu,
  });

  final _championsSubject = BehaviorSubject<List<Champion>>();

  Future<List<Champion>> updateChampions(int summonerId) async {
    var champions = _championsSubject.valueOrNull ?? await _loadRawChampions();

    final masteries = await lcu.service.getChampionMasteryList(summonerId);
    final statStones = await lcu.service.getChampionStatStones();

    champions = _merge(champions, masteries, statStones).toList();
    _championsSubject.add(champions);
    return champions;
  }

  Future<List<Champion>> _loadRawChampions() async {
    final dtos = await lcu.service.getChampionsSummary();

    final champions = <Champion>[];

    for (var dto in dtos) {
      if (dto.id == -1) continue;

      champions.add(
        Champion(
          id: dto.id,
          name: dto.name,
          mastery: ChampionMastery.empty(dto.id),
          statStones: ChampionStatStones.empty(dto.id),
          roles: dto.roles.map((e) => e.role).toList(),
        ),
      );
    }

    return champions..sort((a, b) => cyrillicCompare(a.name, b.name));
  }

  Iterable<Champion> _merge(
    List<Champion> champions,
    List<ChampionMastery> masteries,
    List<ChampionStatStones> statStones,
  ) sync* {
    final masteryMap = {for (var mastery in masteries) mastery.championId: mastery};
    final statStonesMap = {for (var statStone in statStones) statStone.championId: statStone};

    for (var champion in champions) {
      yield champion.copyWith(
        mastery: masteryMap[champion.id],
        statStones: statStonesMap[champion.id],
      );
    }
  }

  Stream<List<Champion>> get stream => _championsSubject.stream;

  List<Champion> get champions => _championsSubject.valueOrNull ?? const [];

  Champion? getChampion(int? championId) {
    if (championId == null || championId == 0) return null;

    for (var champion in champions) {
      if (champion.id == championId) return champion;
    }

    return null;
  }

  LcuImage getSplashImage(int championId) {
    return lcu.service.getLcuImage(
      '/lol-game-data/assets/v1/champion-splashes/$championId/${championId}000.jpg',
    );
  }
}
