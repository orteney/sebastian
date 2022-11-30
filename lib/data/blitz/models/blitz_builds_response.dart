import 'package:json_annotation/json_annotation.dart';

part 'blitz_builds_response.g.dart';

@JsonSerializable(createToJson: false)
class BlitzBuildResponse {
  final BlitzBuildResponseData data;

  BlitzBuildResponse(this.data);

  factory BlitzBuildResponse.fromJson(Map<String, dynamic> json) => _$BlitzBuildResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class BlitzBuildResponseData {
  final BlitzChampionBuildStats championBuildStats;

  BlitzBuildResponseData(this.championBuildStats);

  factory BlitzBuildResponseData.fromJson(Map<String, dynamic> json) => _$BlitzBuildResponseDataFromJson(json);
}

@JsonSerializable(createToJson: false)
class BlitzChampionBuildStats {
  final List<BlitzBuild> builds;

  BlitzChampionBuildStats(this.builds);

  factory BlitzChampionBuildStats.fromJson(Map<String, dynamic> json) => _$BlitzChampionBuildStatsFromJson(json);
}

@JsonSerializable(createToJson: false)
class BlitzBuild {
  final int games;
  final double mythicAverageIndex;
  final int mythicId;
  final int primaryRune;
  final int wins;
  final List<BlitzRune> runes;
  final List<BlitzSkillOrder> skillOrders;
  final List<BlitzSummonerSpells> summonerSpells;
  final List<BlitzStartingItem> startingItems;
  final List<BlitzItemSet> coreItems;
  final List<BlitzItem> completedItems;
  final List<BlitzItemStat> situationalItems;

  BlitzBuild(
    this.games,
    this.mythicAverageIndex,
    this.mythicId,
    this.primaryRune,
    this.wins,
    this.runes,
    this.skillOrders,
    this.summonerSpells,
    this.startingItems,
    this.coreItems,
    this.completedItems,
    this.situationalItems,
  );

  factory BlitzBuild.fromJson(Map<String, dynamic> json) => _$BlitzBuildFromJson(json);
}

@JsonSerializable(createToJson: false)
class BlitzRune {
  final int games;
  final int wins;
  final int index;
  final int runeId;
  final int? treeId;

  BlitzRune(
    this.games,
    this.wins,
    this.index,
    this.runeId,
    this.treeId,
  );

  factory BlitzRune.fromJson(Map<String, dynamic> json) => _$BlitzRuneFromJson(json);
}

@JsonSerializable(createToJson: false)
class BlitzSkillOrder {
  final int games;
  final int wins;
  final List<int> skillOrder;

  BlitzSkillOrder(
    this.games,
    this.wins,
    this.skillOrder,
  );

  factory BlitzSkillOrder.fromJson(Map<String, dynamic> json) => _$BlitzSkillOrderFromJson(json);
}

@JsonSerializable(createToJson: false)
class BlitzSummonerSpells {
  final int games;
  final int wins;
  final List<int> summonerSpellIds;

  BlitzSummonerSpells(
    this.games,
    this.wins,
    this.summonerSpellIds,
  );

  factory BlitzSummonerSpells.fromJson(Map<String, dynamic> json) => _$BlitzSummonerSpellsFromJson(json);
}

@JsonSerializable(createToJson: false)
class BlitzStartingItem {
  final int games;
  final int wins;
  final List<int> startingItemIds;

  BlitzStartingItem(
    this.games,
    this.wins,
    this.startingItemIds,
  );

  factory BlitzStartingItem.fromJson(Map<String, dynamic> json) => _$BlitzStartingItemFromJson(json);
}

@JsonSerializable(createToJson: false)
class BlitzItem {
  final int games;
  final int wins;
  final double averageIndex;
  final int index;
  final int itemId;

  BlitzItem(
    this.games,
    this.wins,
    this.averageIndex,
    this.index,
    this.itemId,
  );

  factory BlitzItem.fromJson(Map<String, dynamic> json) => _$BlitzItemFromJson(json);
}

@JsonSerializable(createToJson: false)
class BlitzItemSet {
  final int games;
  final int wins;
  final List<int> itemIds;

  BlitzItemSet(
    this.games,
    this.wins,
    this.itemIds,
  );

  factory BlitzItemSet.fromJson(Map<String, dynamic> json) => _$BlitzItemSetFromJson(json);
}

@JsonSerializable(createToJson: false)
class BlitzItemStat {
  final int games;
  final int wins;
  final double averageIndex;
  final int itemId;

  BlitzItemStat(
    this.games,
    this.wins,
    this.averageIndex,
    this.itemId,
  );

  factory BlitzItemStat.fromJson(Map<String, dynamic> json) => _$BlitzItemStatFromJson(json);
}
