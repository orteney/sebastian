import 'package:json_annotation/json_annotation.dart';
import 'package:sebastian/data/models/champion.dart';

part 'champion_dto.g.dart';

@JsonSerializable(createToJson: false)
class ChampionDto {
  final int id;
  final String name;
  final String alias;
  final String squarePortraitPath;
  final List<ChampionRoleDto> roles;

  const ChampionDto({
    required this.id,
    required this.name,
    required this.alias,
    required this.squarePortraitPath,
    required this.roles,
  });

  factory ChampionDto.fromJson(Map<String, dynamic> json) => _$ChampionDtoFromJson(json);
}

@JsonEnum()
enum ChampionRoleDto {
  assassin(ChampionRole.assassin),
  fighter(ChampionRole.fighter),
  mage(ChampionRole.mage),
  marksman(ChampionRole.marksman),
  support(ChampionRole.support),
  tank(ChampionRole.tank);

  final ChampionRole role;

  const ChampionRoleDto(this.role);
}
