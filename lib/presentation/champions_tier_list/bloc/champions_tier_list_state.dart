part of 'champions_tier_list_bloc.dart';

abstract class ChampionsTierListState {}

class InitialChampionsTierListState extends ChampionsTierListState {}

class LoadedChampionsTierListState extends ChampionsTierListState {
  final AvailableQueue currentQueue;
  final ChampionTierTableColumn sortColumn;
  final bool ascending;
  final List<ChampionTier> championTiers;

  LoadedChampionsTierListState({
    required this.currentQueue,
    required this.sortColumn,
    required this.ascending,
    required this.championTiers,
  });

  LoadedChampionsTierListState copyWith({
    AvailableQueue? currentQueue,
    ChampionTierTableColumn? sortColumn,
    bool? ascending,
    List<ChampionTier>? championTiers,
  }) {
    return LoadedChampionsTierListState(
      currentQueue: currentQueue ?? this.currentQueue,
      sortColumn: sortColumn ?? this.sortColumn,
      ascending: ascending ?? this.ascending,
      championTiers: championTiers ?? this.championTiers,
    );
  }
}

class AramPickInfoChampionsTierListState extends ChampionsTierListState {
  final LoadedChampionsTierListState loadedState;

  final List<ChampionTier> teamChampions;
  final List<ChampionTier> benchChampions;

  AramPickInfoChampionsTierListState({
    required this.loadedState,
    required this.teamChampions,
    required this.benchChampions,
  });
}
