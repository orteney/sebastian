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
    for (var champion in champions) {
      ChampionMastery? mastery;
      for (var element in masteries) {
        if (element.championId == champion.id) {
          mastery = element;
          break;
        }
      }

      ChampionStatStones? champStatStones;
      for (var statStone in statStones) {
        if (statStone.championId == champion.id) {
          champStatStones = statStone;
          break;
        }
      }

      yield champion.copyWith(mastery: mastery, statStones: champStatStones);
    }
  }

  Stream<List<Champion>> get stream => _championsSubject.stream;

  List<Champion> get champions => _championsSubject.valueOrNull ?? const [];

  Champion getChampion(int championId) {
    return champions.firstWhere((element) => element.id == championId);
  }

  LcuImage getSplashImage(int championId) {
    return lcu.service.getLcuImage(
      '/lol-game-data/assets/v1/champion-splashes/$championId/${championId}000.jpg',
    );
  }
}
