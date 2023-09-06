import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:sebastian/data/models/champion.dart';
import 'package:sebastian/data/lcu/pick_session.dart';
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
        champions: _sortChampions(updatedChampions, state.sortColumn, state.ascending),
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
      champions: _sortChampions(_championRepository.champions, event.column, event.column.initialSortAccending),
    ));
  }

  List<Champion> _sortChampions(List<Champion> champions, ChampionsTableColumn column, bool ascending) {
    var sortedChampions = champions.toList();

    switch (column) {
      case ChampionsTableColumn.champion:
        // Default sort
        break;
      case ChampionsTableColumn.level:
        sortedChampions.sort(((a, b) => a.mastery.championLevel.compareTo(b.mastery.championLevel)));
        break;
      case ChampionsTableColumn.points:
        sortedChampions.sort(((a, b) => a.mastery.championPoints.compareTo(b.mastery.championPoints)));
        break;
      case ChampionsTableColumn.chestEarned:
        sortedChampions.sort(((a, b) {
          if (a.mastery.chestGranted == b.mastery.chestGranted) {
            return 0;
          } else if (a.mastery.chestGranted) {
            return -1;
          }
          return 1;
        }));
        break;
      case ChampionsTableColumn.progress:
        sortedChampions.sort(
          (a, b) => a.mastery.championPointsUntilNextLevel.compareTo(b.mastery.championPointsUntilNextLevel),
        );
        break;
      case ChampionsTableColumn.statStones:
        sortedChampions.sort(
          (a, b) => a.statStones.milestonesPassed.compareTo(b.statStones.milestonesPassed),
        );
        break;
    }

    if (!ascending) {
      sortedChampions = sortedChampions.reversed.toList();
    }

    return sortedChampions;
  }

  void _onPickSessionUpdatedChampionsTableEvent(
    PickSessionUpdatedChampionsTableEvent event,
    Emitter<ChampionsTableState> emit,
  ) {
    if (state is! SummaryChampionsTableState && state is! PickInfoChampionsTableState) return;

    final SummaryChampionsTableState summaryState;
    if (state is SummaryChampionsTableState) {
      summaryState = state as SummaryChampionsTableState;
    } else {
      summaryState = (state as PickInfoChampionsTableState).summaryState;
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

    List<Champion> champions = _championRepository.champions;
    if (event.roleFilter != null) {
      champions = _championRepository.champions.where((e) => e.roles.contains(event.roleFilter)).toList();
    }

    return emit(state.copyWith(
      roleFilter: () => event.roleFilter,
      champions: _sortChampions(champions, state.sortColumn, state.ascending),
    ));
  }

  @override
  Future<void> close() {
    _championsSubscription?.cancel();
    _pickSessionSubscription?.cancel();
    return super.close();
  }
}
