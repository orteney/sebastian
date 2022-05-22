import 'dart:convert';

import 'package:champmastery/data/lcu.dart';
import 'package:champmastery/data/models/champion_mastery.dart';
import 'package:champmastery/data/models/chamption.dart';
import 'package:flutter/services.dart';

class ChampionRepository {
  final LCU lcu;

  ChampionRepository({
    required this.lcu,
  });

  List<Champion>? cachedChampions;

  Future<List<Champion>> getChampions(int summonerId) async {
    cachedChampions ??= await _loadRawChampions();

    final masteries = await lcu.getChampionMasteryList(summonerId);

    cachedChampions = cachedChampions!.map((champion) {
      ChampionMastery? mastery;

      for (var element in masteries) {
        if (element.championId == champion.id) {
          mastery = element;
          break;
        }
      }

      return champion.copyWith(mastery: mastery);
    }).toList();

    return cachedChampions!;
  }

  Future<List<Champion>> _loadRawChampions() async {
    final jsonString = await rootBundle.loadString('assets/champions.json');
    final json = jsonDecode(jsonString);

    final champions = <Champion>[];

    final championsData = json['data'] as Map<String, dynamic>;
    championsData.forEach((key, value) {
      final championId = int.parse(value['key']);

      champions.add(
        Champion(
          id: championId,
          name: value['name'],
          mastery: ChampionMastery.empty(championId),
        ),
      );
    });

    return champions;
  }
}
