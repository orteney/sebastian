import 'package:flutter/foundation.dart';

import 'package:sebastian/data/models/lcu_image.dart';

class ChampionSkin {
  final int id;
  final int championId;
  final String name;
  final LcuImage splashImage;
  final List<int> chromaIds;

  ChampionSkin(this.id, this.championId, this.name, this.splashImage, this.chromaIds);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChampionSkin &&
        other.id == id &&
        other.championId == championId &&
        other.name == name &&
        other.splashImage == splashImage &&
        listEquals(other.chromaIds, chromaIds);
  }

  @override
  int get hashCode {
    return id.hashCode ^ championId.hashCode ^ name.hashCode ^ splashImage.hashCode ^ chromaIds.hashCode;
  }

  @override
  String toString() {
    return 'ChampionSkin(id: $id, championId: $championId, name: $name, splashImage: $splashImage, chromaIds: $chromaIds)';
  }
}
