import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:sebastian/data/lcu/pick_session.dart';
import 'package:sebastian/data/repositories/champion_tier_repository.dart';
import 'package:sebastian/data/repositories/league_client_event_repository.dart';
import 'package:sebastian/data/utils/cyrillic_comparator.dart';
import 'package:sebastian/domain/champion_tier/champion_tier.dart';
import 'package:sebastian/domain/core/role.dart';
import 'package:sebastian/presentation/core/bloc/bloc_mixins.dart';

import 'champions_tier_list_models.dart';

part 'champions_tier_list_event.dart';
part 'champions_tier_list_state.dart';

class ChampionsTierListBloc extends Bloc<ChampionsTierListEvent, ChampionsTierListState> with StreamSubscriptions {
  final ChampionTierRepository _championTierRepository;
  final LeagueClientEventRepository _leagueClientEventRepository;

  ChampionsTierListBloc(
    this._championTierRepository,
    this._leagueClientEventRepository,
  ) : super(InitialChampionsTierListState()) {
    on<InitChampionsTierListEvent>(_onInitChampionsStatsEvent);
    on<ChangeSortChampionsTierListEvent>(_onChangeSortChampionsTierListEvent);
    on<ChangeQueueChampionsTierListEvent>(_onChangeQueueChampionsTierListEvent);
    on<PickSessionUpdatedChampionsTierListEvent>(_onPickSessionUpdatedChampionsTableEvent);
    on<ChangeRoleChampionsTierListEvent>(_onChangeRoleChampionsTierListEvent);
  }

  void _onInitChampionsStatsEvent(
    InitChampionsTierListEvent event,
    Emitter<ChampionsTierListState> emit,
  ) async {
    const initialQueue = AvailableQueue.rankedSolo5X5;
    const initialSortColumn = ChampionTierTableColumn.tier;
    final initialSortAccending = initialSortColumn.initialSortAccending;

    final championTiers = await _championTierRepository.loadChampionTiers(initialQueue);

    emit(LoadedChampionsTierListState(
      currentQueue: initialQueue,
      sortColumn: initialSortColumn,
      ascending: initialSortAccending,
      roleFilter: null,
      championTiers: _sortChampionTiers(championTiers, initialSortColumn, initialSortAccending),
    ));

    _leagueClientEventRepository
        .observePickSession()
        .listen((event) => add(PickSessionUpdatedChampionsTierListEvent(pickSession: event)))
        .addTo(subscriptions);
  }

  void _onChangeSortChampionsTierListEvent(
    ChangeSortChampionsTierListEvent event,
    Emitter<ChampionsTierListState> emit,
  ) {
    if (this.state is! LoadedChampionsTierListState) return;

    final state = this.state as LoadedChampionsTierListState;

    if (state.sortColumn == event.column) {
      if (state.ascending == event.ascending) return;

      return emit(state.copyWith(
        ascending: event.ascending,
        sortColumn: event.column,
        championTiers: state.championTiers.reversed.toList(),
      ));
    }

    emit(state.copyWith(
      ascending: event.column.initialSortAccending,
      sortColumn: event.column,
      championTiers: _sortChampionTiers(
        state.championTiers,
        event.column,
        event.column.initialSortAccending,
      ),
    ));
  }

  Future<void> _onChangeQueueChampionsTierListEvent(
    ChangeQueueChampionsTierListEvent event,
    Emitter<ChampionsTierListState> emit,
  ) async {
    if (this.state is! LoadedChampionsTierListState) return;

    final state = this.state as LoadedChampionsTierListState;

    final queue = event.pickedQueue;
    if (queue == null) return;

    var championTiers = await _championTierRepository.loadChampionTiers(queue);

    if (queue != AvailableQueue.aram) {
      championTiers = _filterChampionTiers(championTiers, state.roleFilter);
    }

    emit(state.copyWith(
      currentQueue: queue,
      championTiers: _sortChampionTiers(championTiers, state.sortColumn, state.ascending),
    ));
  }

  Future<void> _onPickSessionUpdatedChampionsTableEvent(
    PickSessionUpdatedChampionsTierListEvent event,
    Emitter<ChampionsTierListState> emit,
  ) async {
    if (state is! LoadedChampionsTierListState && state is! AramPickInfoChampionsTierListState) return;

    LoadedChampionsTierListState loadedState;
    if (state is LoadedChampionsTierListState) {
      loadedState = state as LoadedChampionsTierListState;
    } else {
      loadedState = (state as AramPickInfoChampionsTierListState).loadedState;
    }

    final pickSession = event.pickSession;
    if (pickSession == null || pickSession.isCustomGame || !pickSession.benchEnabled) {
      if (state is! LoadedChampionsTierListState) {
        emit(loadedState);
      }
      return;
    }

    if (loadedState.currentQueue != AvailableQueue.aram) {
      // When current queue is not ARAM we should request aram data before
      final championTiers = await _championTierRepository.loadChampionTiers(AvailableQueue.aram);
      loadedState = loadedState.copyWith(
        currentQueue: AvailableQueue.aram,
        championTiers: _sortChampionTiers(
          championTiers,
          ChampionTierTableColumn.tier,
          ChampionTierTableColumn.tier.initialSortAccending,
        ),
      );
    }

    final teamChampionIds = <int>[for (var teamPick in pickSession.myTeam) teamPick.championId];
    final benchChampionIds = <int>[for (var benchChampion in pickSession.benchChampions) benchChampion.championId];

    final teamChampions = <ChampionTier>[];
    final benchChampions = <ChampionTier>[];

    for (var championTier in loadedState.championTiers) {
      final championId = championTier.championId;

      if (teamChampionIds.contains(championId)) {
        teamChampions.add(championTier);
        teamChampionIds.remove(championId);
      } else if (benchChampionIds.contains(championId)) {
        benchChampions.add(championTier);
        benchChampionIds.remove(championId);
      }

      if (teamChampionIds.isEmpty && benchChampionIds.isEmpty) break;
    }

    emit(AramPickInfoChampionsTierListState(
      loadedState: loadedState,
      teamChampions: teamChampions,
      benchChampions: benchChampions,
    ));
  }

  Future<void> _onChangeRoleChampionsTierListEvent(
    ChangeRoleChampionsTierListEvent event,
    Emitter<ChampionsTierListState> emit,
  ) async {
    if (this.state is! LoadedChampionsTierListState) return;

    final state = this.state as LoadedChampionsTierListState;

    if (state.roleFilter == event.pickedRole) return;

    List<ChampionTier> championTiers;

    if (state.roleFilter == null) {
      // Already has full data
      championTiers = state.championTiers;
    } else {
      // Refetch full data
      championTiers = await _championTierRepository.loadChampionTiers(state.currentQueue);
      championTiers = _sortChampionTiers(championTiers, state.sortColumn, state.ascending);
    }

    emit(state.copyWith(
      roleFilter: () => event.pickedRole,
      championTiers: _filterChampionTiers(championTiers, event.pickedRole),
    ));
  }

  List<ChampionTier> _filterChampionTiers(List<ChampionTier> championTiers, Role? role) {
    if (role == null) return championTiers;

    return championTiers.where((element) => element.role == role).toList();
  }

  List<ChampionTier> _sortChampionTiers(
    List<ChampionTier> championTiers,
    ChampionTierTableColumn column,
    bool ascending,
  ) {
    var sortedchampionTiers = championTiers.toList();

    switch (column) {
      case ChampionTierTableColumn.role:
        sortedchampionTiers.sort((a, b) {
          if (a.role == b.role) return a.originRank.compareTo(b.originRank);
          if (a.role == null) return 1;
          if (b.role == null) return -1;
          return (a.role!.index.compareTo(b.role!.index));
        });
        break;
      case ChampionTierTableColumn.champion:
        sortedchampionTiers.sort((a, b) => cyrillicCompare(a.championName, b.championName));
        break;
      case ChampionTierTableColumn.tier:
        sortedchampionTiers.sort((a, b) {
          // Tier must be sorted in reverse order (e.g. 1 more than 2 and 5 more than null)
          if (a.tierRank == b.tierRank) return -(a.originRank.compareTo(b.originRank));
          if (a.tierRank == null) return -1;
          if (b.tierRank == null) return 1;
          return -(a.tierRank!.compareTo(b.tierRank!));
        });
        break;
      case ChampionTierTableColumn.winRate:
        sortedchampionTiers.sort((a, b) => a.winRate.compareTo(b.winRate));
        break;
      case ChampionTierTableColumn.banRate:
        sortedchampionTiers.sort((a, b) => a.banRate.compareTo(b.banRate));
        break;
      case ChampionTierTableColumn.pickRate:
        sortedchampionTiers.sort((a, b) => a.pickRate.compareTo(b.pickRate));
        break;
      case ChampionTierTableColumn.games:
        sortedchampionTiers.sort((a, b) => a.games.compareTo(b.games));
        break;
    }

    if (!ascending) {
      sortedchampionTiers = sortedchampionTiers.reversed.toList();
    }

    return sortedchampionTiers;
  }
}
