import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:sebastian/data/lcu/pick_session.dart';
import 'package:sebastian/data/models/champion.dart';
import 'package:sebastian/data/repositories/champion_repository.dart';
import 'package:sebastian/data/repositories/league_client_event_repository.dart';

part 'champions_table_event.dart';
part 'champions_table_models.dart';
part 'champions_table_state.dart';

class ChampionsTableBloc extends Bloc<ChampionsTableEvent, ChampionsTableState> {
  final ChampionRepository _championRepository;
  final LeagueClientEventRepository _leagueClientEventRepository;

  StreamSubscription? _championsSubscription;
  StreamSubscription? _pickSessionSubscription;

  ChampionsTableBloc(
    int summonerId,
    this._championRepository,
    this._leagueClientEventRepository,
  ) : super(SummaryChampionsTableState(
          currentSummonerId: summonerId,
          champions: _championRepository.champions,
          sortColumn: ChampionsTableColumn.champion,
          ascending: ChampionsTableColumn.champion.initialSortAccending,
        )) {
    on<UpdatedChampionsTableEvent>(_onUpdatedChampionsTableEvent);
    on<ChangeSortChampionsTableEvent>(_onChangeSortChampionsTableEvent);
    on<PickSessionUpdatedChampionsTableEvent>(_onPickSessionUpdatedChampionsTableEvent);
    on<ChangeRoleFilterChampionsTableEvent>(_onChangeRoleFilterChampionsTableEvent);
    on<ChangeOnlySetFilterChampionsTableEvent>(_onChangeOnlySetFilterChampionsTableEvent);

    _championsSubscription = _championRepository.stream.listen((event) {
      add(UpdatedChampionsTableEvent(updatedChampions: event));
    });

    _pickSessionSubscription ??= _leagueClientEventRepository.observePickSession().listen((event) {
      add(PickSessionUpdatedChampionsTableEvent(pickSession: event));
    });
  }

  void _onUpdatedChampionsTableEvent(
    UpdatedChampionsTableEvent event,
    Emitter<ChampionsTableState> emit,
  ) {
    final state = this.state;

    var updatedChampions = event.updatedChampions;

    if (state is SummaryChampionsTableState) {
      emit(state.copyWith(
        champions: _filterAndSortChampions(
          updatedChampions,
          state.sortColumn,
          state.ascending,
          state.roleFilter,
          state.onlyMasterySet,
        ),
      ));
    }
  }

  void _onChangeSortChampionsTableEvent(
    ChangeSortChampionsTableEvent event,
    Emitter<ChampionsTableState> emit,
  ) {
    if (this.state is! SummaryChampionsTableState) return;

    final state = this.state as SummaryChampionsTableState;

    if (state.sortColumn == event.column) {
      if (state.ascending == event.ascending) return;

      return emit(state.copyWith(
        ascending: event.ascending,
        sortColumn: event.column,
        champions: state.champions.reversed.toList(),
      ));
    }

    emit(state.copyWith(
      sortColumn: event.column,
      ascending: event.column.initialSortAccending,
      champions: _filterAndSortChampions(
        state.champions,
        event.column,
        event.column.initialSortAccending,
        state.roleFilter,
        state.onlyMasterySet,
      ),
    ));
  }

  void _onPickSessionUpdatedChampionsTableEvent(
    PickSessionUpdatedChampionsTableEvent event,
    Emitter<ChampionsTableState> emit,
  ) {
    final SummaryChampionsTableState summaryState;
    if (state is SummaryChampionsTableState) {
      summaryState = state as SummaryChampionsTableState;
    } else if (state is PickInfoChampionsTableState) {
      summaryState = (state as PickInfoChampionsTableState).summaryState;
    } else {
      return;
    }

    final pickSession = event.pickSession;
    if (pickSession == null || pickSession.isCustomGame || !pickSession.benchEnabled) {
      emit(summaryState);
      return;
    }

    Champion? myChampion;
    final List<Champion> teamChampions = [];

    for (var element in pickSession.myTeam) {
      if (element.summonerId == summaryState.currentSummonerId) {
        myChampion = _championRepository.getChampion(element.championId);
      } else {
        final champion = _championRepository.getChampion(element.championId);
        if (champion != null) {
          teamChampions.add(champion);
        }
      }
    }

    final List<Champion> benchChampions = [];
    for (var benchChampion in pickSession.benchChampions) {
      final champion = _championRepository.getChampion(benchChampion.championId);
      if (champion != null) {
        benchChampions.add(champion);
      }
    }

    emit(PickInfoChampionsTableState(
      summaryState: summaryState,
      myChampion: myChampion,
      teamMatesChampions: teamChampions,
      benchChampions: benchChampions,
    ));
  }

  void _onChangeRoleFilterChampionsTableEvent(
    ChangeRoleFilterChampionsTableEvent event,
    Emitter<ChampionsTableState> emit,
  ) {
    if (this.state is! SummaryChampionsTableState) return;

    final state = this.state as SummaryChampionsTableState;

    if (event.roleFilter == state.roleFilter) return;

    return emit(state.copyWith(
      roleFilter: () => event.roleFilter,
      champions: _filterAndSortChampions(
        _championRepository.champions,
        state.sortColumn,
        state.ascending,
        event.roleFilter,
        state.onlyMasterySet,
      ),
    ));
  }

  void _onChangeOnlySetFilterChampionsTableEvent(
    ChangeOnlySetFilterChampionsTableEvent event,
    Emitter<ChampionsTableState> emit,
  ) {
    if (this.state is! SummaryChampionsTableState) return;

    final state = this.state as SummaryChampionsTableState;

    emit(state.copyWith(
      onlyMasterySet: event.enabled,
      champions: _filterAndSortChampions(
        _championRepository.champions,
        state.sortColumn,
        state.ascending,
        state.roleFilter,
        event.enabled,
      ),
    ));
  }

  List<Champion> _filterAndSortChampions(
    List<Champion> champions,
    ChampionsTableColumn column,
    bool ascending,
    ChampionRole? roleFilter,
    bool onlyMasterySet,
  ) {
    if (column == ChampionsTableColumn.champion) {
      // _sortChampions expect already sorted by name list in that case
      champions = _championRepository.champions;
    }

    if (onlyMasterySet) {
      champions = champions.where((element) => element.inMasterySet).toList();
    }

    if (roleFilter != null) {
      champions = champions.where((element) => element.roles.contains(roleFilter)).toList();
    }

    return _sortChampions(champions, column, ascending);
  }

  List<Champion> _sortChampions(List<Champion> champions, ChampionsTableColumn column, bool ascending) {
    var sortedChampions = champions.toList();

    switch (column) {
      case ChampionsTableColumn.ordinal:
        // Do nothing
        return sortedChampions;

      case ChampionsTableColumn.champion:
        // Default sort
        break;
      case ChampionsTableColumn.level:
        sortedChampions.sort(((a, b) => a.mastery.championLevel.compareTo(b.mastery.championLevel)));
        break;
      case ChampionsTableColumn.points:
        sortedChampions.sort(((a, b) => a.mastery.championPoints.compareTo(b.mastery.championPoints)));
        break;
      case ChampionsTableColumn.progress:
        sortedChampions.sort(_compareChampionsByProgress);
        break;
      case ChampionsTableColumn.milestones:
        sortedChampions.sort(_compareChampionsByMilestones);
        break;
      case ChampionsTableColumn.statStones:
        sortedChampions.sort((a, b) => a.statStones.milestonesPassed.compareTo(b.statStones.milestonesPassed));
        break;
    }

    if (!ascending) {
      sortedChampions = sortedChampions.reversed.toList();
    }

    return sortedChampions;
  }

  int _compareChampionsByProgress(Champion a, Champion b) {
    if (a.mastery.championPointsUntilNextLevel <= 0 && b.mastery.championPointsUntilNextLevel <= 0) {
      return a.mastery.tokensEarned.compareTo(b.mastery.tokensEarned);
    }

    return a.mastery.championPointsUntilNextLevel.compareTo(b.mastery.championPointsUntilNextLevel) * -1;
  }

  int _compareChampionsByMilestones(Champion a, Champion b) {
    final milestoneCompare = a.mastery.championSeasonMilestone.compareTo(b.mastery.championSeasonMilestone);
    if (milestoneCompare != 0) return milestoneCompare;

    final gradesLeftA = a.mastery.nextSeasonMilestone.requireGradeCounts.values.sum - a.mastery.milestoneGrades.length;
    final gradesLeftB = b.mastery.nextSeasonMilestone.requireGradeCounts.values.sum - b.mastery.milestoneGrades.length;
    return gradesLeftA.compareTo(gradesLeftB) * -1;
  }

  @override
  Future<void> close() {
    _championsSubscription?.cancel();
    _pickSessionSubscription?.cancel();
    return super.close();
  }
}
