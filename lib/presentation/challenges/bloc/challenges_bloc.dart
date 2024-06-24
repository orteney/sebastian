import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:sebastian/data/lcu/models/challenge.dart';
import 'package:sebastian/data/repositories/challenges_repository.dart';

import 'challenges_models.dart';
export 'challenges_models.dart';

part 'challenges_event.dart';
part 'challenges_state.dart';

class ChallengesBloc extends Bloc<ChallengesEvent, ChallengesState> {
  final ChallengesRepository _challengesRepository;

  ChallengesBloc(
    this._challengesRepository,
  ) : super(LoadingChallengesState()) {
    on<InitChallengesEvent>(_onInitChallengesEvent);
    on<ToggleFilterChallengesEvent>(_onToggleFilterChallengesEvent);
    on<ToggleGameModeFilterChallengesEvent>(_onToggleGameModeFilterChallengesEvent);
    on<TapRefreshChallengesEvent>(_onTapRefreshChallengesEvent);
    on<ChangeSearchQueryChallengesEvent>(_onChangeSearchQueryChallengesEvent);
    on<TapFavoriteChallengesEvent>(_onTapFavoriteChallengesEvent);
  }

  String? _searchQuery;

  Future<void> _onInitChallengesEvent(
    InitChallengesEvent event,
    Emitter<ChallengesState> emit,
  ) async {
    final challenges = await _challengesRepository.getChallenges();
    const filters = <ChallengesFilter>{};

    emit(LoadedChallengesState(
      challenges: _filterChallenges(
        challenges,
        filters,
        null,
        null,
      ).toList(growable: false),
      activeFilters: filters,
    ));
  }

  Future<void> _onToggleFilterChallengesEvent(
    ToggleFilterChallengesEvent event,
    Emitter<ChallengesState> emit,
  ) async {
    final state = this.state;
    if (state is! LoadedChallengesState) return;

    final filters = state.activeFilters.toSet();
    if (filters.contains(event.filter)) {
      filters.remove(event.filter);
    } else {
      filters.add(event.filter);
    }

    final challenges = await _challengesRepository.getChallenges();

    emit(state.copyWith(
      challenges: _filterChallenges(
        challenges,
        filters,
        state.gameModeFilter,
        _searchQuery,
      ).toList(growable: false),
      activeFilters: filters,
    ));
  }

  Future<void> _onToggleGameModeFilterChallengesEvent(
    ToggleGameModeFilterChallengesEvent event,
    Emitter<ChallengesState> emit,
  ) async {
    final state = this.state;
    if (state is! LoadedChallengesState) return;

    final challenges = await _challengesRepository.getChallenges();

    ChallengeGameModeFilter? filter = event.filter;
    if (state.gameModeFilter == filter) {
      filter = null;
    }

    emit(state.copyWith(
      challenges: _filterChallenges(
        challenges,
        state.activeFilters,
        filter,
        _searchQuery,
      ).toList(growable: false),
      gameModeFilter: () => filter,
    ));
  }

  Future<void> _onTapRefreshChallengesEvent(
    TapRefreshChallengesEvent event,
    Emitter<ChallengesState> emit,
  ) async {
    final state = this.state;
    if (state is! LoadedChallengesState) return;

    emit(state.copyWith(refreshing: true));

    final challenges = await _challengesRepository.getChallenges(cached: false);

    emit(state.copyWith(
      challenges: _filterChallenges(
        challenges,
        state.activeFilters,
        state.gameModeFilter,
        _searchQuery,
      ).toList(growable: false),
      refreshing: false,
    ));
  }

  Future<void> _onChangeSearchQueryChallengesEvent(
    ChangeSearchQueryChallengesEvent event,
    Emitter<ChallengesState> emit,
  ) async {
    final state = this.state;
    if (state is! LoadedChallengesState) return;

    final newQuery = event.query.toLowerCase();
    if (newQuery == _searchQuery) return;

    final challenges = await _challengesRepository.getChallenges();

    _searchQuery = newQuery;

    emit(state.copyWith(
      challenges: _filterChallenges(
        challenges,
        state.activeFilters,
        state.gameModeFilter,
        _searchQuery,
      ).toList(growable: false),
    ));
  }

  Future<void> _onTapFavoriteChallengesEvent(
    TapFavoriteChallengesEvent event,
    Emitter<ChallengesState> emit,
  ) async {
    final state = this.state;
    if (state is! LoadedChallengesState) return;

    _challengesRepository.toggleFavorite(event.challenge.id);
    final challenges = await _challengesRepository.getChallenges();

    emit(state.copyWith(
      challenges: _filterChallenges(
        challenges,
        state.activeFilters,
        state.gameModeFilter,
        _searchQuery,
      ).toList(),
    ));
  }

  Iterable<Challenge> _filterChallenges(
    List<Challenge> challenges,
    Set<ChallengesFilter> activeFilters,
    ChallengeGameModeFilter? gameModeFilter,
    String? query,
  ) sync* {
    const aiModeChallenges = [
      120001,
      120002,
      120003,
      121001,
      121002,
      121003,
    ];

    mainloop:
    for (var challenge in challenges) {
      if (query != null && query.isNotEmpty) {
        if (!(challenge.name.toLowerCase().contains(query) || challenge.description.toLowerCase().contains(query))) {
          continue;
        }
      }

      for (var filter in activeFilters) {
        switch (filter) {
          case ChallengesFilter.maxed:
            if (challenge.nextLevel.isEmpty) continue mainloop;
            break;
          case ChallengesFilter.favorites:
            if (!challenge.isFavorite) continue mainloop;
            break;
        }
      }

      switch (gameModeFilter) {
        case ChallengeGameModeFilter.classic:
          if (!challenge.gameModes.contains(ChallengeGameMode.classic)) continue;
          if (aiModeChallenges.contains(challenge.id)) continue;
          break;
        case ChallengeGameModeFilter.aram:
          if (!challenge.gameModes.contains(ChallengeGameMode.aram)) continue;
          break;
        case ChallengeGameModeFilter.vsAi:
          if (!aiModeChallenges.contains(challenge.id)) continue;
          break;
        case ChallengeGameModeFilter.arena:
          if (!challenge.gameModes.contains(ChallengeGameMode.arena)) continue;
          break;
        case null:
          break;
      }

      yield challenge;
    }
  }
}
