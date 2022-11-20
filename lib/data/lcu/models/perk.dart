import 'package:json_annotation/json_annotation.dart';

part 'perk.g.dart';

@JsonSerializable()
class Perk {
  final int id;
  final String name;
  final String iconPath;

  const Perk({
    required this.id,
    required this.name,
    required this.iconPath,
  });

  factory Perk.fromJson(Map<String, dynamic> json) => _$PerkFromJson(json);
  Map<String, dynamic> toJson() => _$PerkToJson(this);
}
