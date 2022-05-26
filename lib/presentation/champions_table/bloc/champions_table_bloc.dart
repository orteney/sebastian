import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:champmastery/data/models/champion.dart';
import 'package:champmastery/data/models/pick_session.dart';
import 'package:champmastery/data/repositories/champion_repository.dart';
import 'package:champmastery/data/repositories/league_client_event_repository.dart';

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
          ascending: true,
          sortColumn: ChampionsTableColumn.champion,
        )) {
    on<UpdatedChampionsTableEvent>(_onUpdatedChampionsTableEvent);
    on<ChangeSortChampionsTableEvent>(_onChangeSortChampionsTableEvent);
    on<PickSessionUpdatedChampionsTableEvent>(_onPickSessionUpdatedChampionsTableEvent);

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
      if (state.sortColumn != ChampionsTableColumn.champion || !state.ascending) {
        updatedChampions = _sortChampions(updatedChampions, state.sortColumn, state.ascending);
      }

      emit(state.copyWith(champions: updatedChampions));
    }
  }

  void _onChangeSortChampionsTableEvent(
    ChangeSortChampionsTableEvent event,
    Emitter<ChampionsTableState> emit,
  ) {
    if (this.state is! SummaryChampionsTableState) return;

    final state = this.state as SummaryChampionsTableState;

    emit(state.copyWith(
      sortColumn: event.column,
      ascending: event.ascending,
      champions: _sortChampions(state.champions, event.column, event.ascending),
    ));
  }

  List<Champion> _sortChampions(List<Champion> champions, ChampionsTableColumn column, bool ascending) {
    var sortedChampions = champions.toList();

    switch (column) {
      case ChampionsTableColumn.champion:
        // Из-за проблем в сортировке буквы Ё проще достать правильно отсортированный по алфавиту список
        sortedChampions = _championRepository.champions.toList();
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
      case ChampionsTableColumn.tillNextLevel:
        sortedChampions.sort(
          ((a, b) => a.mastery.championPointsUntilNextLevel.compareTo(b.mastery.championPointsUntilNextLevel)),
        );
        break;
      case ChampionsTableColumn.statStones:
        sortedChampions.sort(
          ((a, b) => a.statStones.milestonesPassed.compareTo(b.statStones.milestonesPassed)),
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
    if (pickSession == null) {
      emit(summaryState);
      return;
    }

    Champion? myChampion;
    final List<Champion> teamChampions = [];

    for (var element in pickSession.myTeam) {
      if (element.summonerId == summaryState.currentSummonerId) {
        myChampion = _findChampion(element.championId, summaryState.champions);
      } else {
        final champion = _findChampion(element.championId, summaryState.champions);
        if (champion != null) {
          teamChampions.add(champion);
        }
      }
    }

    final List<Champion> benchChampions = [];
    for (var championId in pickSession.benchChampionIds) {
      final champion = _findChampion(championId, summaryState.champions);
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

  Champion? _findChampion(int? champId, List<Champion> champions) {
    if (champId == null || champId == 0) return null;
    for (var champion in champions) {
      if (champion.id == champId) return champion;
    }

    return null;
  }

  @override
  Future<void> close() {
    _championsSubscription?.cancel();
    _pickSessionSubscription?.cancel();
    return super.close();
  }
}
