import 'dart:convert';

class BlitzBuildResponse {
  final List<BlitzBuild> builds;

  BlitzBuildResponse(this.builds);

  factory BlitzBuildResponse.fromJson(Map<String, dynamic> json) {
    final result = json['data']['executeDatabricksQuery']['payload']['result'] as Map<String, dynamic>;

    return BlitzBuildResponse(
      result.isEmpty ? [] : (result['dataArray'] as List<dynamic>).map((data) => BlitzBuild.fromJsons(data)).toList(),
    );
  }
}

class BlitzBuild {
  //8
  final List<BlitzCoreItem> coreItems;

  //9
  final List<BlitzSituationalItem> situationalItems;

  //10
  final List<BlitzStartingItems> startingItems;

  //11
  final int games;
  //12
  final int wins;

  //14
  final List<BlitzRunes> runes;

  //15
  final BlitzShards shards;

  //16
  final List<BlitzSummonerSpells> summonerSpells;

  //17
  final List<BlitzSkillOrder>? skillOrders;

  //18
  final List<BlitzKeystone> keystone;

  BlitzBuild({
    required this.coreItems,
    required this.situationalItems,
    required this.startingItems,
    required this.games,
    required this.wins,
    required this.runes,
    required this.shards,
    required this.summonerSpells,
    required this.skillOrders,
    required this.keystone,
  });

  factory BlitzBuild.fromJsons(List<dynamic> data) => BlitzBuild(
        coreItems: (jsonDecode(data[8]) as List<dynamic>).map((json) => BlitzCoreItem.fromJson(json)).toList(),
        situationalItems:
            (jsonDecode(data[9]) as List<dynamic>).map((json) => BlitzSituationalItem.fromJson(json)).toList(),
        startingItems:
            (jsonDecode(data[10]) as List<dynamic>).map((json) => BlitzStartingItems.fromJson(json)).toList(),
        games: int.parse(data[11]),
        wins: int.parse(data[12]),
        runes: (jsonDecode(data[14]) as List<dynamic>).map((json) => BlitzRunes.fromJson(json)).toList(),
        shards: BlitzShards.fromJson(jsonDecode(data[15]) as Map<String, dynamic>),
        summonerSpells:
            (jsonDecode(data[16]) as List<dynamic>).map((json) => BlitzSummonerSpells.fromJson(json)).toList(),
        skillOrders: data[17] == null
            ? null
            : (jsonDecode(data[17]) as List<dynamic>).map((json) => BlitzSkillOrder.fromJson(json)).toList(),
        keystone: (jsonDecode(data[18]) as List<dynamic>).map((json) => BlitzKeystone.fromJson(json)).toList(),
      );
}

/// ARRAY<STRUCT<itemIds: STRING, games: BIGINT, wins: BIGINT, pick_rate: DOUBLE>>
class BlitzCoreItem {
  final String itemIds;
  final int games;
  final int wins;
  final double pickRate;

  BlitzCoreItem(this.itemIds, this.games, this.wins, this.pickRate);

  factory BlitzCoreItem.fromJson(Map<String, dynamic> json) => BlitzCoreItem(
        json['itemIds'] as String,
        int.parse(json['games']),
        int.parse(json['wins']),
        double.parse(json['pick_rate']),
      );
}

/// ARRAY<STRUCT<itemId: INT, games: BIGINT, wins: BIGINT, pick_rate: DOUBLE, averageIndex: DOUBLE>>
class BlitzSituationalItem {
  final int itemId;
  final int games;
  final int wins;
  final double pickRate;
  final double averageIndex;

  BlitzSituationalItem(this.itemId, this.games, this.wins, this.pickRate, this.averageIndex);

  factory BlitzSituationalItem.fromJson(Map<String, dynamic> json) => BlitzSituationalItem(
        int.parse(json['itemId']),
        int.parse(json['games']),
        int.parse(json['wins']),
        double.parse(json['pick_rate']),
        double.parse(json['averageIndex']),
      );
}

/// ARRAY<STRUCT<itemIds: ARRAY<STRING>, games: BIGINT, wins: BIGINT, pick_rate: DOUBLE>>
class BlitzStartingItems {
  final List<String> itemIds;
  final int games;
  final int wins;
  final double pickRate;

  BlitzStartingItems(this.itemIds, this.games, this.wins, this.pickRate);

  factory BlitzStartingItems.fromJson(Map<String, dynamic> json) => BlitzStartingItems(
        (json['itemIds'] as List<dynamic>).cast<String>(),
        int.parse(json['games']),
        int.parse(json['wins']),
        double.parse(json['pick_rate']),
      );
}

/// ARRAY<STRUCT<runeId: INT, treeId: INT, index: INT, games: BIGINT, wins: BIGINT, pick_rate: DOUBLE>>
class BlitzRunes {
  final int runeId;
  final int treeId;
  final int index;
  final int games;
  final int wins;
  final double pickRate;

  BlitzRunes(this.runeId, this.treeId, this.index, this.games, this.wins, this.pickRate);

  factory BlitzRunes.fromJson(Map<String, dynamic> json) => BlitzRunes(
        int.parse(json['runeId']),
        int.parse(json['treeId']),
        int.parse(json['index']),
        int.parse(json['games']),
        int.parse(json['wins']),
        double.parse(json['pick_rate']),
      );
}

/// ARRAY<STRUCT<summonerSpellIds: ARRAY<INT>, games: BIGINT, wins: BIGINT, pick_rate: DOUBLE>>
class BlitzSummonerSpells {
  final List<int> summonerSpellIds;
  final int games;
  final int wins;
  final double pickRate;

  BlitzSummonerSpells(this.summonerSpellIds, this.games, this.wins, this.pickRate);

  factory BlitzSummonerSpells.fromJson(Map<String, dynamic> json) => BlitzSummonerSpells(
        (json['summonerSpellIds'] as List<dynamic>).map((e) => int.parse(e)).toList(),
        int.parse(json['games']),
        int.parse(json['wins']),
        double.parse(json['pick_rate']),
      );
}

/// ARRAY<STRUCT<skillOrder: ARRAY<INT>, games: BIGINT, wins: BIGINT, pick_rate: DOUBLE>>"
class BlitzSkillOrder {
  final List<int> skillOrder;
  final int games;
  final int wins;
  final double pickRate;

  BlitzSkillOrder(this.skillOrder, this.games, this.wins, this.pickRate);

  factory BlitzSkillOrder.fromJson(Map<String, dynamic> json) => BlitzSkillOrder(
        (json['skillOrder'] as List<dynamic>).map((e) => int.parse(e)).toList(),
        int.parse(json['games']),
        int.parse(json['wins']),
        double.parse(json['pick_rate']),
      );
}

///ARRAY<STRUCT<keystone_id: INT, treeId: INT, games: BIGINT, wins: BIGINT, pick_rate: DOUBLE>>
class BlitzKeystone {
  final int keystoneId;
  final int treeId;
  final int games;
  final int wins;
  final double pickRate;

  BlitzKeystone(this.keystoneId, this.treeId, this.games, this.wins, this.pickRate);

  factory BlitzKeystone.fromJson(Map<String, dynamic> json) => BlitzKeystone(
        int.parse(json['keystone_id']),
        int.parse(json['treeId']),
        int.parse(json['games']),
        int.parse(json['wins']),
        double.parse(json['pick_rate']),
      );
}

///STRUCT<
///defenseShard: ARRAY<STRUCT<shard_id: STRING, games: BIGINT, wins: BIGINT, pick_rate: DOUBLE>>,
///flexShard: ARRAY<STRUCT<shard_id: STRING, games: BIGINT, wins: BIGINT, pick_rate: DOUBLE>>,
///offenseShard: ARRAY<STRUCT<shard_id: STRING, games: BIGINT, wins: BIGINT, pick_rate: DOUBLE>>
///>
class BlitzShards {
  final List<BlitzShard> defenseShard;
  final List<BlitzShard> flexShard;
  final List<BlitzShard> offenseShard;

  BlitzShards(this.defenseShard, this.flexShard, this.offenseShard);

  factory BlitzShards.fromJson(Map<String, dynamic> json) => BlitzShards(
        (json['defenseShard'] as List<dynamic>).map((e) => BlitzShard.fromJson(e)).toList(),
        (json['flexShard'] as List<dynamic>).map((e) => BlitzShard.fromJson(e)).toList(),
        (json['offenseShard'] as List<dynamic>).map((e) => BlitzShard.fromJson(e)).toList(),
      );

  @override
  String toString() => 'BlitzShards(defenseShard: $defenseShard, flexShard: $flexShard, offenseShard: $offenseShard)';
}

///ARRAY<STRUCT<shard_id: STRING, games: BIGINT, wins: BIGINT, pick_rate: DOUBLE>>
class BlitzShard {
  final String shardId;
  final int games;
  final int wins;
  final double pickRate;

  BlitzShard(this.shardId, this.games, this.wins, this.pickRate);

  factory BlitzShard.fromJson(Map<String, dynamic> json) => BlitzShard(
        json['shard_id'] as String,
        int.parse(json['games']),
        int.parse(json['wins']),
        double.parse(json['pick_rate']),
      );

  @override
  String toString() {
    return 'BlitzShard(shardId: $shardId, games: $games, wins: $wins, pickRate: $pickRate)';
  }
}
