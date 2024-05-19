import 'package:json_annotation/json_annotation.dart';

part 'champion_full_dto.g.dart';

@JsonSerializable(createToJson: false)
class ChampionFullDto {
  final int id;
  final List<SkinDto> skins;

  ChampionFullDto(this.id, this.skins);

  factory ChampionFullDto.fromJson(Map<String, dynamic> json) => _$ChampionFullDtoFromJson(json);
}

///{
///    "championId": 1,
///    "chromaPath": null,
///    "chromas": [],
///    "collectionSplashVideoPath": null,
///    "disabled": false,
///    "emblems": [],
///    "featuresText": null,
///    "id": 1000,
///    "isBase": true,
///    "lastSelected": false,
///    "loadScreenPath": "/lol-game-data/assets/ASSETS/Characters/Annie/Skins/Base/AnnieLoadScreen.jpg",
///    "name": "Annie",
///    "ownership": {
///        "loyaltyReward": false,
///        "owned": true,
///        "rental": {
///            "endDate": 0,
///            "purchaseDate": 0,
///            "rented": false,
///            "winCountRemaining": 0
///        },
///        "xboxGPReward": false
///    },
///    "questSkinInfo": {
///        "collectionCardPath": "",
///        "collectionDescription": "",
///        "descriptionInfo": [],
///        "name": "",
///        "productType": null,
///        "splashPath": "",
///        "tiers": [],
///        "tilePath": "",
///        "uncenteredSplashPath": ""
///    },
///    "rarityGemPath": "",
///    "skinAugments": {
///        "augments": []
///    },
///    "skinType": "",
///    "splashPath": "/lol-game-data/assets/ASSETS/Characters/Annie/Skins/Base/Images/annie_splash_centered_0.jpg",
///    "splashVideoPath": null,
///    "stillObtainable": false,
///    "tilePath": "/lol-game-data/assets/ASSETS/Characters/Annie/Skins/Base/Images/annie_splash_tile_0.jpg",
///    "uncenteredSplashPath": "/lol-game-data/assets/ASSETS/Characters/Annie/Skins/Base/Images/annie_splash_uncentered_0.jpg"
///}
@JsonSerializable(createToJson: false)
class SkinDto {
  final int id;
  final String name;
  final String splashPath;
  final List<ChromaDto> chromas;

  SkinDto(this.id, this.name, this.splashPath, this.chromas);

  factory SkinDto.fromJson(Map<String, dynamic> json) => _$SkinDtoFromJson(json);
}

/// {
///     "championId": 1,
///     "chromaPath": "/lol-game-data/assets/v1/champion-chroma-images/1/1043.png",
///     "colors": [
///         "#FFEE59",
///         "#FFEE59"
///     ],
///     "disabled": false,
///     "id": 1043,
///     "lastSelected": false,
///     "name": "",
///     "ownership": {
///         "loyaltyReward": false,
///         "owned": false,
///         "rental": {
///             "endDate": 0,
///             "purchaseDate": 0,
///             "rented": false,
///             "winCountRemaining": 0
///         },
///         "xboxGPReward": false
///     },
///     "stillObtainable": false
/// },
@JsonSerializable(createToJson: false)
class ChromaDto {
  final int id;

  ChromaDto(this.id);

  factory ChromaDto.fromJson(Map<String, dynamic> json) => _$ChromaDtoFromJson(json);
}
