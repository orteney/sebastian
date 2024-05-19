// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Loot _$LootFromJson(Map<String, dynamic> json) => Loot(
      count: (json['count'] as num).toInt(),
      itemDesc: json['itemDesc'] as String,
      disenchantLootName: json['disenchantLootName'] as String,
      disenchantValue: (json['disenchantValue'] as num).toInt(),
      itemStatus: json['itemStatus'] as String,
      lootId: json['lootId'] as String,
      lootName: json['lootName'] as String,
      refId: json['refId'] as String,
      storeItemId: (json['storeItemId'] as num).toInt(),
      redeemableStatus: json['redeemableStatus'] as String,
      type: json['type'] as String,
      tilePath: json['tilePath'] as String,
    );
