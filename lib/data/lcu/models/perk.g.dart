// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'perk.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Perk _$PerkFromJson(Map<String, dynamic> json) => Perk(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      iconPath: json['iconPath'] as String,
    );

Map<String, dynamic> _$PerkToJson(Perk instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'iconPath': instance.iconPath,
    };
