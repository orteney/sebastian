import 'package:flutter/foundation.dart';

import 'package:champmastery/data/models/chamption.dart';
import 'package:champmastery/data/models/summoner.dart';
import 'package:champmastery/presentation/home/home_models.dart';

abstract class HomeState {}

class InitialHomeState extends HomeState {}

class LolPathUnspecifiedHomeState extends HomeState {
  final String? message;

  LolPathUnspecifiedHomeState({this.message});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LolPathUnspecifiedHomeState && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class LolNotLaunchedOrWrongPathProvidedHomeState extends HomeState {}

class ErrorHomeState extends HomeState {
  final String message;

  ErrorHomeState({
    required this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ErrorHomeState && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class LoadingSummonerInfoHomeState extends HomeState {}

class SummonerInfoHomeState extends HomeState {
  final Summoner summoner;

  final ChampionsTableColumn? sortColumn;
  final bool? ascending;
  final List<Champion> champions;

  SummonerInfoHomeState({
    required this.summoner,
    this.sortColumn,
    this.ascending,
    required this.champions,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SummonerInfoHomeState &&
        other.summoner == summoner &&
        other.sortColumn == sortColumn &&
        other.ascending == ascending &&
        listEquals(other.champions, champions);
  }

  @override
  int get hashCode {
    return summoner.hashCode ^ sortColumn.hashCode ^ ascending.hashCode ^ champions.hashCode;
  }

  SummonerInfoHomeState copyWith({
    Summoner? summoner,
    ChampionsTableColumn? sortColumn,
    bool? ascending,
    List<Champion>? champions,
  }) {
    return SummonerInfoHomeState(
      summoner: summoner ?? this.summoner,
      sortColumn: sortColumn ?? this.sortColumn,
      ascending: ascending ?? this.ascending,
      champions: champions ?? this.champions,
    );
  }
}

class PickInfoHomeState extends HomeState {
  final SummonerInfoHomeState summonerInfoState;

  final Champion? myChampion;
  final List<Champion> teamMatesChampions;
  final List<Champion> benchChampions;

  PickInfoHomeState({
    required this.summonerInfoState,
    required this.myChampion,
    required this.teamMatesChampions,
    required this.benchChampions,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PickInfoHomeState &&
        other.summonerInfoState == summonerInfoState &&
        other.myChampion == myChampion &&
        listEquals(other.teamMatesChampions, teamMatesChampions) &&
        listEquals(other.benchChampions, benchChampions);
  }

  @override
  int get hashCode {
    return summonerInfoState.hashCode ^ myChampion.hashCode ^ teamMatesChampions.hashCode ^ benchChampions.hashCode;
  }

  PickInfoHomeState copyWith({
    SummonerInfoHomeState? summonerInfoState,
    Champion? myChampion,
    List<Champion>? teamMatesChampions,
    List<Champion>? benchChampions,
  }) {
    return PickInfoHomeState(
      summonerInfoState: summonerInfoState ?? this.summonerInfoState,
      myChampion: myChampion ?? this.myChampion,
      teamMatesChampions: teamMatesChampions ?? this.teamMatesChampions,
      benchChampions: benchChampions ?? this.benchChampions,
    );
  }
}
