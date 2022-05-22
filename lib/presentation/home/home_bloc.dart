import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as path;

import 'package:champmastery/data/lcu.dart';
import 'package:champmastery/data/lcu_store.dart';
import 'package:champmastery/data/models/chamption.dart';
import 'package:champmastery/data/repositories/champion_repository.dart';
import 'package:champmastery/data/repositories/pick_session_repository.dart';
import 'package:champmastery/data/repositories/summoner_repository.dart';

import 'home_event.dart';
import 'home_models.dart';
import 'home_state.dart';

export 'home_event.dart';
export 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(InitialHomeState()) {
    on<StartHomeEvent>(_onStartHomeEvent);
    on<PickLolPathHomeEvent>(_onPickLolPathHomeEvent);
    on<LoadCurrentSummonerInfoHomeEvent>(_onLoadCurrentSummonerInfoHomeEvent);
    on<ChangeSortHomeEvent>(_onChangeSortHomeEvent);
    on<PickSessionUpdatedHomeEvent>(_onPickSessionUpdatedHomeEvent);
  }

  late LcuStore _lcuStore;
  late LCU _lcu;
  late SummonerRepository _summonerRepository;
  late ChampionRepository _championRepository;
  late PickSessionRepository _pickSessionRepository;

  StreamSubscription? _pickSessionSubscription;

  Future<void> _onStartHomeEvent(StartHomeEvent event, Emitter<HomeState> emit) async {
    if (state is! InitialHomeState) {
      emit(InitialHomeState());
    }

    try {
      _lcuStore = await LcuStore.create();
      _lcu = await LCU.create(_lcuStore);

      _summonerRepository = SummonerRepository(lcu: _lcu);
      _championRepository = ChampionRepository(lcu: _lcu);
      _pickSessionRepository = PickSessionRepository(_lcu);

      add(LoadCurrentSummonerInfoHomeEvent());
    } on NoLockFilePathException {
      emit(LolPathUnspecifiedHomeState());
    } on LockFileNotFoundException {
      emit(LolNotLaunchedOrWrongPathProvidedHomeState());
    } catch (e) {
      emit(ErrorHomeState(message: e.toString()));
    }
  }

  Future<void> _onPickLolPathHomeEvent(PickLolPathHomeEvent event, Emitter<HomeState> emit) async {
    final lolPath = Directory(event.pickedPath);

    bool foundLolClients = false;
    File? lockfilePath;

    await for (final FileSystemEntity f in lolPath.list()) {
      if (f is File) {
        switch (path.basename(f.path)) {
          case 'lockfile':
            lockfilePath = f;
            break;
          case 'LeagueClient.exe':
          case 'LeagueClientUx.exe':
            foundLolClients = true;
            break;
        }
      }
    }

    if (lockfilePath == null) {
      if (foundLolClients) {
        lockfilePath = File(path.join(event.pickedPath, 'lockfile'));
      } else {
        return emit(LolPathUnspecifiedHomeState(message: 'Что-то не удалось найти файлы лиги легенд, не обманываешь?'));
      }
    }

    _lcuStore.putLcuLockfilePath(lockfilePath);
    add(StartHomeEvent());
  }

  Future<void> _onLoadCurrentSummonerInfoHomeEvent(
      LoadCurrentSummonerInfoHomeEvent event, Emitter<HomeState> emit) async {
    emit(LoadingSummonerInfoHomeState());

    final summoner = await _summonerRepository.getCurrentSummoner();
    final champions = await _championRepository.getChampions(summoner.summonerId);

    emit(SummonerInfoHomeState(
      summoner: summoner,
      champions: champions,
      ascending: true,
      sortColumn: ChampionsTableColumn.champion,
    ));

    _pickSessionSubscription = _pickSessionRepository.observePickSession().listen(
          (event) => add(PickSessionUpdatedHomeEvent(pickSession: event)),
        );
  }

  void _onChangeSortHomeEvent(ChangeSortHomeEvent event, Emitter<HomeState> emit) {
    if (this.state is! SummonerInfoHomeState) return;

    final state = this.state as SummonerInfoHomeState;

    var champions = state.champions.toList();

    switch (event.column) {
      case ChampionsTableColumn.champion:
        // Из-за проблем в сортировке буквы Ё проще достать правильно отсортированный по алфавиту список
        champions = _championRepository.cachedChampions?.toList() ?? [];
        break;
      case ChampionsTableColumn.level:
        champions.sort(((a, b) => a.mastery.championLevel.compareTo(b.mastery.championLevel)));
        break;
      case ChampionsTableColumn.points:
        champions.sort(((a, b) => a.mastery.championPoints.compareTo(b.mastery.championPoints)));
        break;
      case ChampionsTableColumn.chestEarned:
        champions.sort(((a, b) {
          if (a.mastery.chestGranted == b.mastery.chestGranted) {
            return 0;
          } else if (a.mastery.chestGranted) {
            return -1;
          }
          return 1;
        }));
        break;
      case ChampionsTableColumn.tillNextLevel:
        champions
            .sort(((a, b) => a.mastery.championPointsUntilNextLevel.compareTo(b.mastery.championPointsUntilNextLevel)));
        break;
    }

    if (!event.ascending) {
      champions = champions.reversed.toList();
    }

    emit(state.copyWith(
      sortColumn: event.column,
      ascending: event.ascending,
      champions: champions,
    ));
  }

  void _onPickSessionUpdatedHomeEvent(PickSessionUpdatedHomeEvent event, Emitter<HomeState> emit) {
    if (this.state is! SummonerInfoHomeState && this.state is! PickInfoHomeState) return;

    final SummonerInfoHomeState state;
    if (this.state is SummonerInfoHomeState) {
      state = this.state as SummonerInfoHomeState;
    } else {
      state = (this.state as PickInfoHomeState).summonerInfoState;
    }

    final pickSession = event.pickSession;
    if (pickSession == null) {
      emit(state);
      return;
    }

    Champion? myChampion;
    final List<Champion> teamChampions = [];

    for (var element in pickSession.myTeam) {
      if (element.summonerId == state.summoner.summonerId) {
        myChampion = _findChampion(element.championId, state.champions);
      } else {
        final champion = _findChampion(element.championId, state.champions);
        if (champion != null) {
          teamChampions.add(champion);
        }
      }
    }

    final List<Champion> benchChampions = [];
    for (var championId in pickSession.benchChampionIds) {
      final champion = _findChampion(championId, state.champions);
      if (champion != null) {
        benchChampions.add(champion);
      }
    }

    emit(PickInfoHomeState(
      summonerInfoState: state,
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
    _pickSessionSubscription?.cancel();
    _lcu.close();
    return super.close();
  }
}
