// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'champion_pick_bloc.dart';

@immutable
abstract class ChampionPickState {}

class NoActiveChampionPickState extends ChampionPickState {}

class NoPickedChampionPickState extends ChampionPickState {}

class ActiveChampionPickState extends ChampionPickState with EquatableMixin {
  final Champion pickedChampion;
  final Role role;
  final List<SenpaiBuildInfo> builds;
  final int selectedBuildIndex;
  final Map<int, LcuImage> runesImages;
  final Map<int, LcuImage> itemImages;
  final Map<int, LcuImage> summonerSpellImages;

  ActiveChampionPickState({
    required this.pickedChampion,
    required this.role,
    required this.builds,
    required this.selectedBuildIndex,
    required this.runesImages,
    required this.itemImages,
    required this.summonerSpellImages,
  });

  @override
  List<Object?> get props => [
        pickedChampion,
        role,
        builds,
        selectedBuildIndex,
        runesImages,
        itemImages,
        summonerSpellImages,
      ];

  ActiveChampionPickState copyWith({
    Champion? pickedChampion,
    Role? role,
    List<SenpaiBuildInfo>? builds,
    int? selectedBuildIndex,
    Map<int, LcuImage>? runesImages,
    Map<int, LcuImage>? itemImages,
    Map<int, LcuImage>? summonerSpellImages,
  }) {
    return ActiveChampionPickState(
      pickedChampion: pickedChampion ?? this.pickedChampion,
      role: role ?? this.role,
      builds: builds ?? this.builds,
      selectedBuildIndex: selectedBuildIndex ?? this.selectedBuildIndex,
      runesImages: runesImages ?? this.runesImages,
      itemImages: itemImages ?? this.itemImages,
      summonerSpellImages: summonerSpellImages ?? this.summonerSpellImages,
    );
  }
}
