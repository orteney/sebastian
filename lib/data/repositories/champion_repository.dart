import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

import 'package:champmastery/data/lcu.dart';
import 'package:champmastery/data/models/champion.dart';
import 'package:champmastery/data/models/champion_mastery.dart';
import 'package:champmastery/data/models/champion_stat_stones.dart';

class ChampionRepository {
  final LCU lcu;

  ChampionRepository({
    required this.lcu,
  });

  final _championsSubject = BehaviorSubject<List<Champion>>();

  Future<List<Champion>> updateChampions(int summonerId) async {
    var champions = _championsSubject.valueOrNull ?? await _loadRawChampions();

    final masteries = await lcu.getChampionMasteryList(summonerId);
    final statStones = await lcu.getChampionStatStones();

    champions = _merge(champions, masteries, statStones).toList();
    _championsSubject.add(champions);
    return champions;
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

  Future<List<Champion>> _loadRawChampions() async {
    final jsonString = await rootBundle.loadString('assets/champions_ru.json');
    final json = jsonDecode(jsonString);

    final champions = <Champion>[];

    for (var value in json) {
      final championId = value['id'] as int;

      champions.add(
        Champion(
          id: championId,
          name: value['name'],
          mastery: ChampionMastery.empty(championId),
          statStones: ChampionStatStones.empty(championId),
        ),
      );
    }

    return champions;
  }

  Stream<List<Champion>> get stream => _championsSubject.stream;

  List<Champion> get champions => _championsSubject.valueOrNull ?? const [];
}
