import 'package:sebastian/data/lcu/lcu.dart';
import 'package:sebastian/data/lcu/models/summoner_spell.dart';
import 'package:sebastian/data/models/lcu_image.dart';

class SpellsRepository {
  final LCU _lcu;

  SpellsRepository(this._lcu);

  final _summonerSpellsStorage = <int, SummonerSpell>{};

  Future<void> updateSpells() async {
    final summonerSpells = await _lcu.service.getSummonerSpells();
    _summonerSpellsStorage.clear();
    for (var summonerSpell in summonerSpells) {
      _summonerSpellsStorage[summonerSpell.id] = summonerSpell;
    }
  }

  SummonerSpell getSummonerSpell(int id) {
    return _summonerSpellsStorage[id]!;
  }

  LcuImage getImageForSummonerSpell(int id) {
    return _lcu.service.getLcuImage(getSummonerSpell(id).iconPath);
  }
}
