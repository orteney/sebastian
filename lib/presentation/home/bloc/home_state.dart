part of 'home_bloc.dart';

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

class LoadedHomeState extends HomeState {
  final int summonerId;

  LoadedHomeState({
    required this.summonerId,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoadedHomeState && other.summonerId == summonerId;
  }

  @override
  int get hashCode => summonerId.hashCode;
}
