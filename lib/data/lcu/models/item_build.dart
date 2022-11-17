import 'package:json_annotation/json_annotation.dart';

part 'item_build.g.dart';

@JsonSerializable(createFactory: false)
class ItemBuild {
  final List<Block> blocks;
  final String map;
  final String mode;
  final bool priority;
  final int sortrank;
  final String title;
  final String type;

  ItemBuild({
    required this.title,
    required this.blocks,
    this.map = 'any',
    this.mode = 'any',
    this.priority = true,
    this.sortrank = 0,
    this.type = 'custom',
  });

  Map<String, dynamic> toJson() => _$ItemBuildToJson(this);
}

@JsonSerializable(createFactory: false)
class Block {
  final String hideIfSummonerSpell;
  final List<Item> items;
  final int maxSummonerLevel;
  final int minSummonerLevel;
  final bool recMath;
  final String showIfSummonerSpell;
  final String type;

  Block({
    this.hideIfSummonerSpell = '',
    required this.items,
    this.maxSummonerLevel = -1,
    this.minSummonerLevel = -1,
    this.recMath = false,
    this.showIfSummonerSpell = '',
    required this.type,
  });

  Map<String, dynamic> toJson() => _$BlockToJson(this);
}

@JsonSerializable(createFactory: false)
class Item {
  final int count;
  final String id;

  Item({
    required this.count,
    required this.id,
  });

  Map<String, dynamic> toJson() => _$ItemToJson(this);

  Item copyWith({
    int? count,
    String? id,
  }) {
    return Item(
      count: count ?? this.count,
      id: id ?? this.id,
    );
  }
}
