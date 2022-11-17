import 'package:json_annotation/json_annotation.dart';

part 'loot.g.dart';

@JsonSerializable(createToJson: false)
class Loot {
  final int count;
  final String itemDesc;
  final String disenchantLootName;
  final int disenchantValue;
  final String itemStatus;
  final String lootId;
  final String lootName;
  final String refId;
  final int storeItemId;
  final String redeemableStatus;
  final String type;
  final String tilePath;

  Loot({
    required this.count,
    required this.itemDesc,
    required this.disenchantLootName,
    required this.disenchantValue,
    required this.itemStatus,
    required this.lootId,
    required this.lootName,
    required this.refId,
    required this.storeItemId,
    required this.redeemableStatus,
    required this.type,
    required this.tilePath,
  });

  Loot copyWith({
    int? count,
    String? itemDesc,
    String? disenchantLootName,
    int? disenchantValue,
    String? itemStatus,
    String? lootId,
    String? lootName,
    String? refId,
    int? storeItemId,
    String? redeemableStatus,
    String? type,
    String? tilePath,
  }) {
    return Loot(
      count: count ?? this.count,
      itemDesc: itemDesc ?? this.itemDesc,
      disenchantLootName: disenchantLootName ?? this.disenchantLootName,
      disenchantValue: disenchantValue ?? this.disenchantValue,
      itemStatus: itemStatus ?? this.itemStatus,
      lootId: lootId ?? this.lootId,
      lootName: lootName ?? this.lootName,
      refId: refId ?? this.refId,
      storeItemId: storeItemId ?? this.storeItemId,
      redeemableStatus: redeemableStatus ?? this.redeemableStatus,
      type: type ?? this.type,
      tilePath: tilePath ?? this.tilePath,
    );
  }

  @override
  String toString() {
    return 'Loot(count: $count, itemDesc: $itemDesc, disenchantLootName: $disenchantLootName, disenchantValue: $disenchantValue, itemStatus: $itemStatus, lootId: $lootId, lootName: $lootName, refId: $refId, storeItemId: $storeItemId, redeemableStatus: $redeemableStatus, type: $type, tilePath: $tilePath)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Loot &&
        other.count == count &&
        other.itemDesc == itemDesc &&
        other.disenchantLootName == disenchantLootName &&
        other.disenchantValue == disenchantValue &&
        other.itemStatus == itemStatus &&
        other.lootId == lootId &&
        other.lootName == lootName &&
        other.refId == refId &&
        other.storeItemId == storeItemId &&
        other.redeemableStatus == redeemableStatus &&
        other.type == type &&
        other.tilePath == tilePath;
  }

  @override
  int get hashCode {
    return count.hashCode ^
        itemDesc.hashCode ^
        disenchantLootName.hashCode ^
        disenchantValue.hashCode ^
        itemStatus.hashCode ^
        lootId.hashCode ^
        lootName.hashCode ^
        refId.hashCode ^
        storeItemId.hashCode ^
        redeemableStatus.hashCode ^
        type.hashCode ^
        tilePath.hashCode;
  }

  factory Loot.fromJson(Map<String, dynamic> json) => _$LootFromJson(json);
}
