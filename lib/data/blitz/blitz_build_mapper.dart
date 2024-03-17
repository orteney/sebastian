import 'package:collection/collection.dart';

import 'package:sebastian/data/blitz/models/blitz_builds_response.dart';
import 'package:sebastian/domain/builds/build_info.dart';

class BlitzBuildMapper {
  BuildInfo call(BlitzBuild blitzBuild) {
    blitzBuild.keystone.sortBy((element) => element.pickRate as num);
    final keyStone = blitzBuild.keystone.last;

    return BuildInfo(
      keystoneId: keyStone.keystoneId,
      winRate: ((blitzBuild.wins / blitzBuild.games) * 100).roundToDouble(),
      numMatches: blitzBuild.games,
      itemBuild: _mapBuildItems(
        blitzBuild.startingItems,
        blitzBuild.coreItems,
        blitzBuild.situationalItems,
      ),
      summonerSpells: blitzBuild.summonerSpells.first.summonerSpellIds,
      runes: _mapBlitzRunes(keyStone, blitzBuild.runes, blitzBuild.shards),
      skillPath: blitzBuild.skillOrders?.firstOrNull?.skillOrder,
      skillOrder: null,
    );
  }

  Runes _mapBlitzRunes(
    BlitzKeystone keystone,
    List<BlitzRunes> runes,
    BlitzShards shards,
  ) {
    final List<List<BlitzRunes>> sortedRunes = [[], [], [], [], []];
    for (var rune in runes) {
      if (rune.index < 3 && rune.treeId != keystone.treeId || rune.index > 4) {
        continue;
      }

      sortedRunes[rune.index].add(rune);
    }

    for (var runes in sortedRunes) {
      runes.sortBy<num>((element) => element.pickRate);
    }

    final firstRune = sortedRunes[0].last;
    final primaryTree = <int>[
      keystone.keystoneId,
      firstRune.runeId,
      sortedRunes[1].last.runeId,
      sortedRunes[2].last.runeId,
    ];

    final subRune1 = sortedRunes[3].last;
    final subRune2 = sortedRunes[4].lastWhere(
      (rune) => rune.runeId != subRune1.runeId && rune.treeId == subRune1.treeId,
      orElse: () => sortedRunes[4].last,
    );
    final subPath = subRune1.treeId;
    final subTree = <int>[
      subRune1.runeId,
      subRune2.runeId,
    ];

    shards.offenseShard.sortBy((element) => element.pickRate as num);
    shards.flexShard.sortBy((element) => element.pickRate as num);
    shards.defenseShard.sortBy((element) => element.pickRate as num);

    final statTree = <int>[
      int.parse(shards.offenseShard.last.shardId),
      int.parse(shards.flexShard.last.shardId),
      int.parse(shards.defenseShard.last.shardId),
    ];

    return Runes(
      primaryPath: firstRune.treeId,
      primary: primaryTree,
      subPath: subPath,
      sub: subTree,
      stat: statTree,
    );
  }

  ItemBuild _mapBuildItems(
    List<BlitzStartingItems> startingItems,
    List<BlitzCoreItem> coreItems,
    List<BlitzSituationalItem> situationalItems,
  ) {
    startingItems.sortBy((element) => element.pickRate as num);
    coreItems.sortBy((element) => element.pickRate as num);
    situationalItems.sortBy((element) => element.pickRate as num);

    final startingBuild = startingItems.last.itemIds.map((e) => int.parse(e)).toList();

    final coreBuild = coreItems.last.itemIds.split(',').map((e) => int.parse(e)).toList();
    final coreBoots = coreBuild.firstWhereOrNull((element) => _boots.contains(element));
    if (coreBoots != null) {
      situationalItems.removeWhere((element) => _boots.contains(element.itemId));
    }

    // Add final support item to core build
    if (startingBuild.contains(_worldAtlasId)) {
      for (var item in situationalItems.reversed) {
        if (_finalItemsFromWorldAtlas.contains(item.itemId)) {
          coreBuild.add(item.itemId);
          break;
        }
      }
    }

    final finalBuild = {
      ...coreBuild,
      ...situationalItems.reversed.map((e) => e.itemId),
    }.take(6).toList();

    final situational = situationalItems.reversed
        .where((element) => !finalBuild.contains(element.itemId))
        .take(10)
        .map((e) => e.itemId)
        .toList();

    return ItemBuild(
      startBuild: startingBuild,
      coreBuild: coreBuild,
      finalBuild: finalBuild,
      situationalItems: situational,
    );
  }
}

const _boots = [
  1001,
  3158,
  3006,
  3009,
  3020,
  3047,
  3111,
  3117,
  2422,
];

const _worldAtlasId = 3865;
const _finalItemsFromWorldAtlas = [
  3869,
  3870,
  3871,
  3876,
  3877,
];
