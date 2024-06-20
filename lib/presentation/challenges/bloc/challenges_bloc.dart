import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:sebastian/data/lcu/models/challenge.dart';
import 'package:sebastian/data/repositories/challenges_repository.dart';

part 'challenges_event.dart';
part 'challenges_state.dart';

class ChallengesBloc extends Bloc<ChallengesEvent, ChallengesState> {
  final ChallengesRepository _challengesRepository;

  ChallengesBloc(
    this._challengesRepository,
  ) : super(LoadingChallengesState()) {
    on<InitChallengesEvent>(_onInitChallengesEvent);
  }

  Future<void> _onInitChallengesEvent(
    InitChallengesEvent event,
    Emitter<ChallengesState> emit,
  ) async {
    final challenges = await _challengesRepository.getChallenges();
    emit(LoadedChallengesState(
      challenges: challenges,
    ));
  }
}
