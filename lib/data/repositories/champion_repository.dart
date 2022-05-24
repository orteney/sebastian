import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

import 'package:champmastery/data/lcu.dart';
import 'package:champmastery/data/models/champion_mastery.dart';
import 'package:champmastery/data/models/champion.dart';

class ChampionRepository {
  final LCU lcu;

  ChampionRepository({
    required this.lcu,
  });

  final _championsSubject = BehaviorSubject<List<Champion>>();

  Future<List<Champion>> updateChampions(int summonerId) async {
    var champions = _championsSubject.valueOrNull ?? await _loadRawChampions();

    final masteries = await lcu.getChampionMasteryList(summonerId);

    champions = champions.map((champion) {
      ChampionMastery? mastery;

      for (var element in masteries) {
        if (element.championId == champion.id) {
          mastery = element;
          break;
        }
      }

      return champion.copyWith(mastery: mastery);
    }).toList();

    _championsSubject.add(champions);

    return champions;
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
        ),
      );
    }

    return champions;
  }

  Stream<List<Champion>> get stream => _championsSubject.stream;

  List<Champion> get champions => _championsSubject.valueOrNull ?? const [];
}
