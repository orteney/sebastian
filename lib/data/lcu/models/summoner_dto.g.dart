// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summoner_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SummonerDto _$SummonerDtoFromJson(Map<String, dynamic> json) => SummonerDto(
      accountId: (json['accountId'] as num).toInt(),
      displayName: json['displayName'] as String,
      summonerId: (json['summonerId'] as num).toInt(),
      summonerLevel: (json['summonerLevel'] as num).toInt(),
      xpSinceLastLevel: (json['xpSinceLastLevel'] as num).toInt(),
      xpUntilNextLevel: (json['xpUntilNextLevel'] as num).toInt(),
    );
