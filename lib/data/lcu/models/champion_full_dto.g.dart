// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'champion_full_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChampionFullDto _$ChampionFullDtoFromJson(Map<String, dynamic> json) =>
    ChampionFullDto(
      (json['id'] as num).toInt(),
      (json['skins'] as List<dynamic>)
          .map((e) => SkinDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

SkinDto _$SkinDtoFromJson(Map<String, dynamic> json) => SkinDto(
      (json['id'] as num).toInt(),
      json['name'] as String,
      json['splashPath'] as String,
      (json['chromas'] as List<dynamic>)
          .map((e) => ChromaDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

ChromaDto _$ChromaDtoFromJson(Map<String, dynamic> json) => ChromaDto(
      (json['id'] as num).toInt(),
    );
