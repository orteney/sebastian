import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:champmastery/data/lcu.dart';
import 'package:champmastery/data/lcu_store.dart';
import 'package:champmastery/data/repositories/champion_repository.dart';
import 'package:champmastery/data/repositories/league_client_event_repository.dart';
import 'package:champmastery/data/repositories/summoner_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final LcuStore _lcuStore;
  final LCU _lcu;
  final SummonerRepository _summonerRepository;
  final ChampionRepository _championRepository;
  final LeagueClientEventRepository _leagueClientEventRepository;

  HomeBloc(
    this._lcuStore,
    this._lcu,
    this._summonerRepository,
    this._championRepository,
    this._leagueClientEventRepository,
  ) : super(InitialHomeState()) {
    on<StartHomeEvent>(_onStartHomeEvent);
    on<PickLolPathHomeEvent>(_onPickLolPathHomeEvent);
    on<LoadCurrentSummonerInfoHomeEvent>(_onLoadCurrentSummonerInfoHomeEvent);
    on<EndGameHomeEvent>(_onEndGameHomeEvent);
  }

  StreamSubscription? _pickSessionSubscription;
  StreamSubscription? _gameEndEventSubscription;

  Future<void> _onStartHomeEvent(StartHomeEvent event, Emitter<HomeState> emit) async {
    if (state is! InitialHomeState) {
      emit(InitialHomeState());
    }

    try {
      await _lcu.init();
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
    try {
      _lcuStore.putLcuLockfilePath(event.pickedPath);
      add(StartHomeEvent());
    } catch (e) {
      return emit(LolPathUnspecifiedHomeState(message: 'Что-то не удалось найти файлы лиги легенд, не обманываешь?'));
    }
  }

  Future<void> _onLoadCurrentSummonerInfoHomeEvent(
    LoadCurrentSummonerInfoHomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(LoadingSummonerInfoHomeState());

    final summoner = await _summonerRepository.getCurrentSummoner();
    await _championRepository.updateChampions(summoner.summonerId);

    emit(LoadedHomeState(
      summonerId: summoner.summonerId,
    ));

    _gameEndEventSubscription ??= _leagueClientEventRepository.observeGameEndEvent().listen((event) {
      add(EndGameHomeEvent());
    });
  }

  Future<void> _onEndGameHomeEvent(EndGameHomeEvent event, Emitter<HomeState> emit) async {
    final summoner = await _summonerRepository.getCurrentSummoner();
    await _championRepository.updateChampions(summoner.summonerId);
  }

  @override
  Future<void> close() {
    _pickSessionSubscription?.cancel();
    _lcu.close();
    return super.close();
  }
}
