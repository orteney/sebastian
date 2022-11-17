import 'package:sebastian/data/lcu/lcu.dart';
import 'package:sebastian/data/lcu/models/item.dart';
import 'package:sebastian/data/models/lcu_image.dart';

class ItemsRepository {
  final LCU _lcu;

  ItemsRepository(this._lcu);

  final _storage = <int, Item>{};

  Future<void> updateItems() async {
    final items = await _lcu.service.getItems();
    _storage.clear();
    for (var item in items) {
      _storage[item.id] = item;
    }
  }

  Item? getItem(int id) {
    return _storage[id];
  }

  LcuImage? getImageForItem(int id) {
    final item = getItem(id);
    if (item == null) return null;

    return _lcu.service.getLcuImage(item.iconPath);
  }
}
