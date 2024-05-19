part of 'champion_pick_bloc.dart';

sealed class ChampionPickState {}

class NoActiveChampionPickState extends ChampionPickState {}

class NoPickedChampionPickState extends ChampionPickState {}

class ActiveChampionPickState extends ChampionPickState with EquatableMixin {
  final int championId;
  final String championName;
  final int skinId;
  final String skinName;
  final LcuImage splashImage;
  final Role? role;
  final List<BuildInfo> builds;
  final int selectedBuildIndex;
  final PerkStyle? selectedPerkStyle;
  final Map<int, LcuImage> runesImages;
  final Map<int, LcuImage> itemImages;
  final Map<int, LcuImage> summonerSpellImages;

  ActiveChampionPickState({
    required this.championId,
    required this.championName,
    required this.skinId,
    required this.skinName,
    required this.splashImage,
    required this.role,
    required this.builds,
    required this.selectedBuildIndex,
    required this.selectedPerkStyle,
    required this.runesImages,
    required this.itemImages,
    required this.summonerSpellImages,
  });

  @override
  List<Object?> get props {
    return [
      championId,
      championName,
      skinId,
      skinName,
      splashImage,
      role,
      builds,
      selectedBuildIndex,
      selectedPerkStyle,
      runesImages,
      itemImages,
      summonerSpellImages,
    ];
  }

  ActiveChampionPickState copyWith({
    int? championId,
    String? championName,
    int? skinId,
    String? skinName,
    LcuImage? splashImage,
    Role? role,
    List<BuildInfo>? builds,
    int? selectedBuildIndex,
    PerkStyle? selectedPerkStyle,
    Map<int, LcuImage>? runesImages,
    Map<int, LcuImage>? itemImages,
    Map<int, LcuImage>? summonerSpellImages,
  }) {
    return ActiveChampionPickState(
      championId: championId ?? this.championId,
      championName: championName ?? this.championName,
      skinId: skinId ?? this.skinId,
      skinName: skinName ?? this.skinName,
      splashImage: splashImage ?? this.splashImage,
      role: role ?? this.role,
      builds: builds ?? this.builds,
      selectedBuildIndex: selectedBuildIndex ?? this.selectedBuildIndex,
      selectedPerkStyle: selectedPerkStyle ?? this.selectedPerkStyle,
      runesImages: runesImages ?? this.runesImages,
      itemImages: itemImages ?? this.itemImages,
      summonerSpellImages: summonerSpellImages ?? this.summonerSpellImages,
    );
  }
}
