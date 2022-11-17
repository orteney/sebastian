// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'champion_dto.g.dart';

@JsonSerializable(createToJson: false)
class ChampionDto {
  final int id;
  final String name;
  final String alias;
  final String squarePortraitPath;
  final List<String> roles;

  const ChampionDto({
    required this.id,
    required this.name,
    required this.alias,
    required this.squarePortraitPath,
    required this.roles,
  });

  factory ChampionDto.fromJson(Map<String, dynamic> json) => _$ChampionDtoFromJson(json);
}
