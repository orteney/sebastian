part of 'home_bloc.dart';

sealed class HomeState {}

class InitialHomeState extends HomeState {}

class LolPathUnspecifiedHomeState extends HomeState {}

class PickedWrongLolPathHomeState extends HomeState {}

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

class LoadedHomeState extends HomeState with EquatableMixin {
  final int summonerId;
  final Destination destination;
  final bool autoAcceptEnabled;

  LoadedHomeState({
    required this.summonerId,
    required this.destination,
    required this.autoAcceptEnabled,
  });

  @override
  List<Object> get props => [summonerId, destination, autoAcceptEnabled];

  LoadedHomeState copyWith({
    int? summonerId,
    Destination? destination,
    bool? autoAcceptEnabled,
  }) {
    return LoadedHomeState(
      summonerId: summonerId ?? this.summonerId,
      destination: destination ?? this.destination,
      autoAcceptEnabled: autoAcceptEnabled ?? this.autoAcceptEnabled,
    );
  }
}
