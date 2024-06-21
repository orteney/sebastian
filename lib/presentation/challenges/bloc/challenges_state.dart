part of 'challenges_bloc.dart';

@immutable
sealed class ChallengesState {}

class LoadingChallengesState extends ChallengesState {}

class LoadedChallengesState extends ChallengesState with EquatableMixin {
  final List<Challenge> challenges;
  final Set<ChallengesFilter> activeFilters;
  final ChallengeGameModeFilter? gameModeFilter;
  final bool refreshing;

  LoadedChallengesState({
    required this.challenges,
    required this.activeFilters,
    this.gameModeFilter,
    this.refreshing = false,
  });

  LoadedChallengesState copyWith({
    List<Challenge>? challenges,
    Set<ChallengesFilter>? activeFilters,
    ChallengeGameModeFilter? Function()? gameModeFilter,
    bool? refreshing,
  }) {
    return LoadedChallengesState(
      challenges: challenges ?? this.challenges,
      activeFilters: activeFilters ?? this.activeFilters,
      gameModeFilter: gameModeFilter != null ? gameModeFilter() : this.gameModeFilter,
      refreshing: refreshing ?? this.refreshing,
    );
  }

  @override
  List<Object?> get props => [
        challenges,
        activeFilters,
        gameModeFilter,
        refreshing,
      ];
}
