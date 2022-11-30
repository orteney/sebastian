import 'package:collection/collection.dart';
import 'package:sebastian/data/blitz/models/blitz_builds_response.dart';
import 'package:sebastian/domain/builds/build_info.dart';

class BlitzBuildMapper {
  BuildInfo call(BlitzBuild blitzBuild) {
    return BuildInfo(
      keystoneId: blitzBuild.primaryRune,
      winRate: ((blitzBuild.wins / blitzBuild.games) * 100).roundToDouble(),
      numMatches: blitzBuild.games,
      itemBuild: _mapBuildItems(
        blitzBuild.mythicId,
        blitzBuild.startingItems,
        blitzBuild.coreItems,
        blitzBuild.completedItems,
        blitzBuild.situationalItems,
      ),
      summonerSpells: blitzBuild.summonerSpells.first.summonerSpellIds,
      runes: _mapBlitzRunes(blitzBuild.primaryRune, blitzBuild.runes),
      skillPath: blitzBuild.skillOrders.first.skillOrder,
      skillOrder: [],
    );
  }

  Runes _mapBlitzRunes(int primaryRune, List<BlitzRune> runes) {
    final List<List<BlitzRune>> sortedRunes = [[], [], [], [], [], [], [], []];

    for (var rune in runes) {
      sortedRunes[rune.index].add(rune);
    }

    final primaryPath = sortedRunes[0].first.treeId;
    final primaryTree = <int>[
      primaryRune,
      sortedRunes[0].first.runeId,
      sortedRunes[1].first.runeId,
      sortedRunes[2].first.runeId,
    ];
    final subPath = sortedRunes[3].first.treeId;
    final subTree = <int>[
      sortedRunes[3].first.runeId,
      sortedRunes[4].first.runeId,
    ];
    final statTree = <int>[
      sortedRunes[5].first.runeId,
      sortedRunes[6].first.runeId,
      sortedRunes[7].first.runeId,
    ];

    return Runes(
      primaryPath: primaryPath!,
      subPath: subPath!,
      primary: primaryTree,
      sub: subTree,
      stat: statTree,
    );
  }

  ItemBuild _mapBuildItems(
    int mythicId,
    List<BlitzStartingItem> startingItems,
    List<BlitzItemSet> coreItems,
    List<BlitzItem> completedItems,
    List<BlitzItemStat> situationalItems,
  ) {
    final coreBuild = coreItems.first.itemIds;
    final coreBoots = coreBuild.firstWhereOrNull((element) => _boots.contains(element));

    final finalItems = (completedItems.toList()
          ..removeWhere(
            (element) => coreBuild.contains(element.itemId) || (coreBoots != null && _boots.contains(element.itemId)),
          )
          ..sort((a, b) => a.averageIndex.compareTo(b.averageIndex)))
        .map<int>((e) => e.itemId);

    final finalBuild = (coreBuild.toList()..addAll(finalItems)).take(6).toList();

    final situational = (situationalItems.toList()..removeWhere((element) => finalBuild.contains(element.itemId)))
        .take(6)
        .map((e) => e.itemId)
        .toList();

    return ItemBuild(
      startBuild: startingItems.first.startingItemIds,
      coreBuild: coreBuild,
      finalBuild: finalBuild,
      situationalItems: situational,
      buildPath: [],
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
