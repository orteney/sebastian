// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blitz_builds_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlitzBuildResponse _$BlitzBuildResponseFromJson(Map<String, dynamic> json) =>
    BlitzBuildResponse(
      BlitzBuildResponseData.fromJson(json['data'] as Map<String, dynamic>),
    );

BlitzBuildResponseData _$BlitzBuildResponseDataFromJson(
        Map<String, dynamic> json) =>
    BlitzBuildResponseData(
      BlitzChampionBuildStats.fromJson(
          json['championBuildStats'] as Map<String, dynamic>),
    );

BlitzChampionBuildStats _$BlitzChampionBuildStatsFromJson(
        Map<String, dynamic> json) =>
    BlitzChampionBuildStats(
      (json['builds'] as List<dynamic>)
          .map((e) => BlitzBuild.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

BlitzBuild _$BlitzBuildFromJson(Map<String, dynamic> json) => BlitzBuild(
      json['games'] as int,
      (json['mythicAverageIndex'] as num).toDouble(),
      json['mythicId'] as int,
      json['primaryRune'] as int,
      json['wins'] as int,
      (json['runes'] as List<dynamic>)
          .map((e) => BlitzRune.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['skillOrders'] as List<dynamic>)
          .map((e) => BlitzSkillOrder.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['summonerSpells'] as List<dynamic>)
          .map((e) => BlitzSummonerSpells.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['startingItems'] as List<dynamic>)
          .map((e) => BlitzStartingItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['coreItems'] as List<dynamic>)
          .map((e) => BlitzItemSet.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['completedItems'] as List<dynamic>)
          .map((e) => BlitzItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['situationalItems'] as List<dynamic>)
          .map((e) => BlitzItemStat.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

BlitzRune _$BlitzRuneFromJson(Map<String, dynamic> json) => BlitzRune(
      json['games'] as int,
      json['wins'] as int,
      json['index'] as int,
      json['runeId'] as int,
      json['treeId'] as int?,
    );

BlitzSkillOrder _$BlitzSkillOrderFromJson(Map<String, dynamic> json) =>
    BlitzSkillOrder(
      json['games'] as int,
      json['wins'] as int,
      (json['skillOrder'] as List<dynamic>).map((e) => e as int).toList(),
    );

BlitzSummonerSpells _$BlitzSummonerSpellsFromJson(Map<String, dynamic> json) =>
    BlitzSummonerSpells(
      json['games'] as int,
      json['wins'] as int,
      (json['summonerSpellIds'] as List<dynamic>).map((e) => e as int).toList(),
    );

BlitzStartingItem _$BlitzStartingItemFromJson(Map<String, dynamic> json) =>
    BlitzStartingItem(
      json['games'] as int,
      json['wins'] as int,
      (json['startingItemIds'] as List<dynamic>).map((e) => e as int).toList(),
    );

BlitzItem _$BlitzItemFromJson(Map<String, dynamic> json) => BlitzItem(
      json['games'] as int,
      json['wins'] as int,
      (json['averageIndex'] as num).toDouble(),
      json['index'] as int,
      json['itemId'] as int,
    );

BlitzItemSet _$BlitzItemSetFromJson(Map<String, dynamic> json) => BlitzItemSet(
      json['games'] as int,
      json['wins'] as int,
      (json['itemIds'] as List<dynamic>).map((e) => e as int).toList(),
    );

BlitzItemStat _$BlitzItemStatFromJson(Map<String, dynamic> json) =>
    BlitzItemStat(
      json['games'] as int,
      json['wins'] as int,
      (json['averageIndex'] as num).toDouble(),
      json['itemId'] as int,
    );
