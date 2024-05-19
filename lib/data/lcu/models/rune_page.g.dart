// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rune_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RunePage _$RunePageFromJson(Map<String, dynamic> json) => RunePage(
      name: json['name'] as String,
      primaryStyleId: (json['primaryStyleId'] as num).toInt(),
      subStyleId: (json['subStyleId'] as num).toInt(),
      current: json['current'] as bool,
      selectedPerkIds: (json['selectedPerkIds'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$RunePageToJson(RunePage instance) => <String, dynamic>{
      'name': instance.name,
      'primaryStyleId': instance.primaryStyleId,
      'subStyleId': instance.subStyleId,
      'current': instance.current,
      'selectedPerkIds': instance.selectedPerkIds,
    };
