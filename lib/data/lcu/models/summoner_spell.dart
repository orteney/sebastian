// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'summoner_spell.g.dart';

/// Example
/// {
///     "id": 4,
///     "name": "Скачок",
///     "description": "Телепортирует вашего чемпиона на небольшое расстояние в направлении курсора.",
///     "summonerLevel": 7,
///     "cooldown": 300,
///     "gameModes": [
///         "NEXUSBLITZ",
///         "URF",
///         "PRACTICETOOL",
///         "SNOWURF",
///         "TUTORIAL",
///         "CLASSIC",
///         "ARAM",
///         "DOOMBOTSTEEMO",
///         "ULTBOOK",
///         "ONEFORALL",
///         "ARSR",
///         "ASSASSINATE",
///         "FIRSTBLOOD",
///         "PROJECT",
///         "STARGUARDIAN"
///     ],
///     "iconPath": "/lol-game-data/assets/DATA/Spells/Icons2D/Summoner_flash.png"
/// }
@JsonSerializable(createToJson: false)
class SummonerSpell {
  final int id;
  final String name;
  final String iconPath;

  const SummonerSpell(
    this.id,
    this.name,
    this.iconPath,
  );

  factory SummonerSpell.fromJson(Map<String, dynamic> json) => _$SummonerSpellFromJson(json);
}
