part of 'challenges_bloc.dart';

@immutable
abstract class ChallengesEvent {}

class InitChallengesEvent extends ChallengesEvent {}

class ToggleFilterChallengesEvent extends ChallengesEvent {
  final ChallengesFilter filter;

  ToggleFilterChallengesEvent(this.filter);
}

class ToggleGameModeFilterChallengesEvent extends ChallengesEvent {
  final ChallengeGameModeFilter filter;

  ToggleGameModeFilterChallengesEvent(this.filter);
}

class TapRefreshChallengesEvent extends ChallengesEvent {}

class ChangeSearchQueryChallengesEvent extends ChallengesEvent {
  final String query;

  ChangeSearchQueryChallengesEvent(this.query);
}

class TapFavoriteChallengesEvent extends ChallengesEvent {
  final Challenge challenge;

  TapFavoriteChallengesEvent(this.challenge);
}
