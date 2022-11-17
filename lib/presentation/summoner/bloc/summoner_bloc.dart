import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sebastian/data/models/summoner.dart';
import 'package:sebastian/data/repositories/summoner_repository.dart';

part 'summoner_event.dart';
part 'summoner_state.dart';

class SummonerBloc extends Bloc<SummonerEvent, SummonerState> {
  final SummonerRepository _summonerRepository;

  StreamSubscription? _subscription;

  SummonerBloc(this._summonerRepository) : super(SummonerState(summoner: _summonerRepository.load())) {
    on<UpdatedSummonerEvent>(_onUpdatedSummonerEvent);

    _subscription = _summonerRepository.stream().listen((event) => add(UpdatedSummonerEvent(summoner: event)));
  }

  void _onUpdatedSummonerEvent(UpdatedSummonerEvent event, Emitter<SummonerState> emit) {
    emit(SummonerState(summoner: event.summoner));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
