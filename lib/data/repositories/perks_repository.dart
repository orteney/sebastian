import 'package:sebastian/data/lcu/lcu.dart';
import 'package:sebastian/data/lcu/models/perk.dart';
import 'package:sebastian/data/models/lcu_image.dart';

class PerksRepository {
  final LCU _lcu;

  PerksRepository(this._lcu);

  final _storage = <int, Perk>{};

  Future<void> updatePerks() async {
    final perks = await _lcu.service.getPerks();
    _storage.clear();
    for (var perk in perks) {
      _storage[perk.id] = perk;
    }
  }

  Perk getPerk(int id) {
    return _storage[id]!;
  }

  LcuImage getImageForPerk(int id) {
    return _lcu.service.getLcuImage(getPerk(id).iconPath);
  }
}
