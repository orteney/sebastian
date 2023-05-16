part of 'champions_tier_list_bloc.dart';

sealed class ChampionsTierListState {}

class InitialChampionsTierListState extends ChampionsTierListState {}

class LoadedChampionsTierListState extends ChampionsTierListState {
  final AvailableQueue currentQueue;
  final ChampionTierTableColumn sortColumn;
  final bool ascending;
  final List<ChampionTier> championTiers;
  final Role? roleFilter;

  LoadedChampionsTierListState({
    required this.currentQueue,
    required this.sortColumn,
    required this.ascending,
    required this.championTiers,
    this.roleFilter,
  });

  LoadedChampionsTierListState copyWith({
    AvailableQueue? currentQueue,
    ChampionTierTableColumn? sortColumn,
    bool? ascending,
    List<ChampionTier>? championTiers,
    Role? Function()? roleFilter,
  }) {
    return LoadedChampionsTierListState(
      currentQueue: currentQueue ?? this.currentQueue,
      sortColumn: sortColumn ?? this.sortColumn,
      ascending: ascending ?? this.ascending,
      championTiers: championTiers ?? this.championTiers,
      roleFilter: roleFilter != null ? roleFilter() : this.roleFilter,
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
