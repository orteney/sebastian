// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blitz_primary_role_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlitzPrimaryRoleResponse _$BlitzPrimaryRoleResponseFromJson(
        Map<String, dynamic> json) =>
    BlitzPrimaryRoleResponse(
      BlitzPrimaryRoleData.fromJson(json['data'] as Map<String, dynamic>),
    );

BlitzPrimaryRoleData _$BlitzPrimaryRoleDataFromJson(
        Map<String, dynamic> json) =>
    BlitzPrimaryRoleData(
      $enumDecode(_$BlitzRoleEnumMap, json['primaryRole']),
    );

const _$BlitzRoleEnumMap = {
  BlitzRole.adc: 'ADC',
  BlitzRole.jungle: 'JUNGLE',
  BlitzRole.mid: 'MID',
  BlitzRole.support: 'SUPPORT',
  BlitzRole.top: 'TOP',
};
