import 'package:json_annotation/json_annotation.dart';

part 'challenge.g.dart';

///{
///    "availableIds": [],
///    "capstoneGroupId": 1,
///    "capstoneGroupName": "IMAGINATION",
///    "category": "IMAGINATION",
///    "childrenIds": [
///        101100,
///        101200,
///        101300
///    ],
///    "completedIds": [],
///    "currentLevel": "MASTER",
///    "currentLevelAchievedTime": 1685647225358,
///    "currentThreshold": 1850.0,
///    "currentValue": 2090.0,
///    "description": "Earn progress from challenges in the ARAM Warrior, ARAM Finesse, and ARAM Champion groups",
///    "descriptionShort": "Earn progress from challenges in the ARAM Warrior, ARAM Finesse, and ARAM Champion groups",
///    "friendsAtLevels": [],
///    "gameModes": [],
///    "hasLeaderboard": false,
///    "iconPath": "",
///    "id": 101000,
///    "idListType": "NONE",
///    "isApex": true,
///    "isCapstone": true,
///    "isReverseDirection": false,
///    "levelToIconPath": {
///        "BRONZE": "/lol-game-data/assets/ASSETS/Challenges/Config/101000/Tokens/BRONZE.png",
///        "CHALLENGER": "/lol-game-data/assets/ASSETS/Challenges/Config/101000/Tokens/CHALLENGER.png",
///        "DIAMOND": "/lol-game-data/assets/ASSETS/Challenges/Config/101000/Tokens/DIAMOND.png",
///        "GOLD": "/lol-game-data/assets/ASSETS/Challenges/Config/101000/Tokens/GOLD.png",
///        "GRANDMASTER": "/lol-game-data/assets/ASSETS/Challenges/Config/101000/Tokens/GRANDMASTER.png",
///        "IRON": "/lol-game-data/assets/ASSETS/Challenges/Config/101000/Tokens/IRON.png",
///        "MASTER": "/lol-game-data/assets/ASSETS/Challenges/Config/101000/Tokens/MASTER.png",
///        "PLATINUM": "/lol-game-data/assets/ASSETS/Challenges/Config/101000/Tokens/PLATINUM.png",
///        "SILVER": "/lol-game-data/assets/ASSETS/Challenges/Config/101000/Tokens/SILVER.png"
///    },
///    "name": "ARAM Authority",
///    "nextLevel": "",
///    "nextLevelIconPath": "",
///    "nextThreshold": 0.0,
///    "parentId": 1,
///    "parentName": "",
///    "percentile": 0.3,
///    "playersInLevel": 0,
///    "pointsAwarded": 100,
///    "position": 0,
///    "previousLevel": "",
///    "previousValue": 0.0,
///    "priority": 1.0,
///    "retireTimestamp": 0,
///    "source": "CHALLENGES",
///    "thresholds": {
///        "BRONZE": {
///            "rewards": [
///                {
///                    "asset": "",
///                    "category": "CHALLENGE_POINTS",
///                    "name": "",
///                    "quantity": 10
///                }
///            ],
///            "value": 85.0
///        },
///        ...
///    },
///    "valueMapping": ""
///}
@JsonSerializable(createToJson: false)
class Challenge {
  final int id;
  final String name;
  final String description;
  final bool isCapstone;
  final List<int> availableIds;
  final List<int> completedIds;
  final double percentile;
  final int position;
  final int pointsAwarded;
  final ChallengeLevel currentLevel;
  final double currentValue;
  final double currentThreshold;
  final double nextThreshold;
  final String nextLevel;

  @JsonKey(unknownEnumValue: ChallengeGameMode.unknown)
  final List<ChallengeGameMode> gameModes;

  @JsonKey(includeFromJson: false)
  final bool isFavorite;

  Challenge(
    this.id,
    this.name,
    this.description,
    this.isCapstone,
    this.availableIds,
    this.completedIds,
    this.percentile,
    this.position,
    this.pointsAwarded,
    this.currentLevel,
    this.currentValue,
    this.currentThreshold,
    this.nextThreshold,
    this.nextLevel,
    this.gameModes, {
    this.isFavorite = false,
  });

  factory Challenge.fromJson(Map<String, dynamic> json) => _$ChallengeFromJson(json);

  Challenge copyWith({
    int? id,
    String? name,
    String? description,
    bool? isCapstone,
    List<int>? availableIds,
    List<int>? completedIds,
    double? percentile,
    int? position,
    int? pointsAwarded,
    ChallengeLevel? currentLevel,
    double? currentValue,
    double? currentThreshold,
    double? nextThreshold,
    String? nextLevel,
    List<ChallengeGameMode>? gameModes,
    bool? isFavorite,
  }) {
    return Challenge(
      id ?? this.id,
      name ?? this.name,
      description ?? this.description,
      isCapstone ?? this.isCapstone,
      availableIds ?? this.availableIds,
      completedIds ?? this.completedIds,
      percentile ?? this.percentile,
      position ?? this.position,
      pointsAwarded ?? this.pointsAwarded,
      currentLevel ?? this.currentLevel,
      currentValue ?? this.currentValue,
      currentThreshold ?? this.currentThreshold,
      nextThreshold ?? this.nextThreshold,
      nextLevel ?? this.nextLevel,
      gameModes ?? this.gameModes,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

@JsonEnum(valueField: 'name')
enum ChallengeLevel {
  none('NONE'),
  iron('IRON'),
  bronze('BRONZE'),
  silver('SILVER'),
  gold('GOLD'),
  platinum('PLATINUM'),
  diamond('DIAMOND'),
  master('MASTER'),
  grandmaster('GRANDMASTER'),
  challenger('CHALLENGER');

  const ChallengeLevel(this.name);

  final String name;
}

@JsonEnum(valueField: 'name')
enum ChallengeGameMode {
  classic('CLASSIC'),
  aram('ARAM'),
  arena('CHERRY'),
  unknown('UNKNOWN');

  const ChallengeGameMode(this.name);

  final String name;
}
