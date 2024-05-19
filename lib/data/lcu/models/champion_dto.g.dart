// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'champion_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChampionDto _$ChampionDtoFromJson(Map<String, dynamic> json) => ChampionDto(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      alias: json['alias'] as String,
      squarePortraitPath: json['squarePortraitPath'] as String,
      roles: (json['roles'] as List<dynamic>)
          .map((e) => $enumDecode(_$ChampionRoleDtoEnumMap, e))
          .toList(),
    );

const _$ChampionRoleDtoEnumMap = {
  ChampionRoleDto.assassin: 'assassin',
  ChampionRoleDto.fighter: 'fighter',
  ChampionRoleDto.mage: 'mage',
  ChampionRoleDto.marksman: 'marksman',
  ChampionRoleDto.support: 'support',
  ChampionRoleDto.tank: 'tank',
};
