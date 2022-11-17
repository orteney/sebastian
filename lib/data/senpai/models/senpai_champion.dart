import 'package:json_annotation/json_annotation.dart';

part 'senpai_champion.g.dart';

@JsonSerializable(createToJson: false)
class SenpaiChampion {
  SenpaiChampion({
    required this.filters,
  });

  List<Filter> filters;

  factory SenpaiChampion.fromJson(Map<String, dynamic> json) => _$SenpaiChampionFromJson(json);
}

@JsonSerializable(createToJson: false)
class Filter {
  Filter({
    required this.roleId,
    required this.winRate,
    required this.pickRate,
    required this.banRate,
    required this.keystones,
  });

  int roleId;
  double winRate;
  double pickRate;
  double banRate;
  List<Keystone> keystones;

  factory Filter.fromJson(Map<String, dynamic> json) => _$FilterFromJson(json);
}

@JsonSerializable(createToJson: false)
class Keystone {
  Keystone({
    required this.id,
    required this.winRate,
    required this.numMatches,
  });

  int id;
  double winRate;
  int numMatches;

  factory Keystone.fromJson(Map<String, dynamic> json) => _$KeystoneFromJson(json);
}
