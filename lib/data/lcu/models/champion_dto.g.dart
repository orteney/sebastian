// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'champion_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChampionDto _$ChampionDtoFromJson(Map<String, dynamic> json) => ChampionDto(
      id: json['id'] as int,
      name: json['name'] as String,
      alias: json['alias'] as String,
      squarePortraitPath: json['squarePortraitPath'] as String,
      roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
    );
