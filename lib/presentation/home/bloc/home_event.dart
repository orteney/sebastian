part of 'home_bloc.dart';

abstract class HomeEvent {}

class StartHomeEvent extends HomeEvent {}

class PickLolPathHomeEvent extends HomeEvent {
  final String pickedPath;

  PickLolPathHomeEvent({
    required this.pickedPath,
  });
}

class LoadCurrentSummonerInfoHomeEvent extends HomeEvent {}

class TapDestinationHomeEvent extends HomeEvent {
  final Destination destination;

  TapDestinationHomeEvent(this.destination);
}

class ToggleAutoAcceptHomeEvent extends HomeEvent {}
