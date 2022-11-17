import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';

import 'package:sebastian/data/lcu/lcu.dart';
import 'package:sebastian/data/lcu/lcu_path_storage.dart';
import 'package:sebastian/data/repositories/champion_repository.dart';
import 'package:sebastian/data/repositories/items_repository.dart';
import 'package:sebastian/data/repositories/league_client_event_repository.dart';
import 'package:sebastian/data/repositories/perks_repository.dart';
import 'package:sebastian/data/repositories/spells_repository.dart';
import 'package:sebastian/data/repositories/summoner_repository.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_models.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final LcuPathStorage _lcuStore;
  final LCU _lcu;
  final SummonerRepository _summonerRepository;
  final ChampionRepository _championRepository;
  final PerksRepository _perksRepository;
  final ItemsRepository _itemsRepository;
  final SpellsRepository _spellsRepository;
  final LeagueClientEventRepository _leagueClientEventRepository;

  HomeBloc(
    this._lcuStore,
    this._lcu,
    this._summonerRepository,
    this._championRepository,
    this._perksRepository,
    this._itemsRepository,
    this._spellsRepository,
    this._leagueClientEventRepository,
  ) : super(InitialHomeState()) {
    on<StartHomeEvent>(_onStartHomeEvent);
    on<PickLolPathHomeEvent>(_onPickLolPathHomeEvent);
    on<LoadCurrentSummonerInfoHomeEvent>(_onLoadCurrentSummonerInfoHomeEvent);
    on<EndGameHomeEvent>(_onEndGameHomeEvent);
    on<TapDestinationHomeEvent>(_onTapDestinationHomeEvent);
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
      final lockfile = await _lcu.getLockfileFromLolDirectory(Directory(event.pickedPath));
      if (lockfile != null) {
        _lcuStore.putLcuLockfilePath(lockfile.path);
        return add(StartHomeEvent());
      }
    } catch (e) {/** Ommit error body */}

    return emit(LolPathUnspecifiedHomeState(message: 'Что-то не удалось найти файлы лиги легенд, не обманываешь?'));
  }

  Future<void> _onLoadCurrentSummonerInfoHomeEvent(
    LoadCurrentSummonerInfoHomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(LoadingSummonerInfoHomeState());

    try {
      final summoner = await _summonerRepository.getCurrentSummoner();
      await _championRepository.updateChampions(summoner.summonerId);
      await _perksRepository.updatePerks();
      await _itemsRepository.updateItems();
      await _spellsRepository.updateSpells();

      emit(LoadedHomeState(
        summonerId: summoner.summonerId,
        destination: Destination.mastery,
      ));

      _gameEndEventSubscription ??= _leagueClientEventRepository.observeGameEndEvent().listen((event) {
        add(EndGameHomeEvent());
      });
    } catch (e) {
      emit(ErrorHomeState(message: e.toString()));
    }
  }

  Future<void> _onEndGameHomeEvent(EndGameHomeEvent event, Emitter<HomeState> emit) async {
    final summoner = await _summonerRepository.getCurrentSummoner();
    await _championRepository.updateChampions(summoner.summonerId);
  }

  void _onTapDestinationHomeEvent(TapDestinationHomeEvent event, Emitter<HomeState> emit) {
    if (this.state is! LoadedHomeState) return;

    final state = this.state as LoadedHomeState;

    if (state.destination == event.destination) return;

    emit(state.copyWith(destination: event.destination));
  }

  @override
  Future<void> close() {
    _pickSessionSubscription?.cancel();
    _gameEndEventSubscription?.cancel();
    _lcu.close();
    return super.close();
  }
}
