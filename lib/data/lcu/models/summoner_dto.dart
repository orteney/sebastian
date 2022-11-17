import 'package:json_annotation/json_annotation.dart';

part 'summoner_dto.g.dart';

@JsonSerializable(createToJson: false)
class SummonerDto {
  final int accountId;
  final String displayName;
  final int summonerId;
  final int summonerLevel;
  final int xpSinceLastLevel;
  final int xpUntilNextLevel;

  SummonerDto({
    required this.accountId,
    required this.displayName,
    required this.summonerId,
    required this.summonerLevel,
    required this.xpSinceLastLevel,
    required this.xpUntilNextLevel,
  });

  factory SummonerDto.fromJson(Map<String, dynamic> json) => _$SummonerDtoFromJson(json);
}
