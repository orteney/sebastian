import 'dart:convert';

class Loot {
  final int count;
  final String itemDesc;
  final String disenchantLootName;
  final int disenchantValue;
  final String itemStatus;
  final String lootId;
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
      redeemableStatus: redeemableStatus ?? this.redeemableStatus,
      type: type ?? this.type,
      tilePath: tilePath ?? this.tilePath,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'count': count,
      'itemDesc': itemDesc,
      'disenchantLootName': disenchantLootName,
      'disenchantValue': disenchantValue,
      'itemStatus': itemStatus,
      'lootId': lootId,
      'redeemableStatus': redeemableStatus,
      'type': type,
      'tilePath': tilePath,
    };
  }

  factory Loot.fromMap(Map<String, dynamic> map) {
    return Loot(
      count: map['count']?.toInt() ?? 0,
      itemDesc: map['itemDesc'] ?? '',
      disenchantLootName: map['disenchantLootName'] ?? '',
      disenchantValue: map['disenchantValue']?.toInt() ?? 0,
      itemStatus: map['itemStatus'] ?? '',
      lootId: map['lootId'] ?? '',
      redeemableStatus: map['redeemableStatus'] ?? '',
      type: map['type'] ?? '',
      tilePath: map['tilePath'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Loot.fromJson(String source) => Loot.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Loot(count: $count, itemDesc: $itemDesc, disenchantLootName: $disenchantLootName, disenchantValue: $disenchantValue, itemStatus: $itemStatus, lootId: $lootId, redeemableStatus: $redeemableStatus, type: $type, tilePath: $tilePath)';
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
        redeemableStatus.hashCode ^
        type.hashCode ^
        tilePath.hashCode;
  }
}
