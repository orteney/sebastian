part of 'champions_disenchanter_bloc.dart';

class SelectedLootCount {
  final Loot loot;
  final int count;
  final LcuImage image;
  final bool purchased;

  SelectedLootCount({
    required this.loot,
    required this.count,
    required this.image,
    required this.purchased,
  });

  SelectedLootCount copyWith({
    Loot? loot,
    int? count,
    LcuImage? image,
    bool? purchased,
  }) {
    return SelectedLootCount(
      loot: loot ?? this.loot,
      count: count ?? this.count,
      image: image ?? this.image,
      purchased: purchased ?? this.purchased,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SelectedLootCount &&
        other.loot == loot &&
        other.count == count &&
        other.image == image &&
        other.purchased == purchased;
  }

  @override
  int get hashCode {
    return loot.hashCode ^ count.hashCode ^ image.hashCode ^ purchased.hashCode;
  }
}

class SummaryDisenchantLoot {
  final int totalEssence;
  final int totalCount;

  SummaryDisenchantLoot({
    required this.totalEssence,
    required this.totalCount,
  });

  SummaryDisenchantLoot copyWith({
    int? totalEssence,
    int? totalCount,
  }) {
    return SummaryDisenchantLoot(
      totalEssence: totalEssence ?? this.totalEssence,
      totalCount: totalCount ?? this.totalCount,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SummaryDisenchantLoot && other.totalEssence == totalEssence && other.totalCount == totalCount;
  }

  @override
  int get hashCode => totalEssence.hashCode ^ totalCount.hashCode;
}

enum SortField {
  name,
  value,
}
