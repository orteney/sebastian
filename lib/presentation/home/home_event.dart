import 'package:champmastery/data/models/pick_session.dart';

import 'home_models.dart';

abstract class HomeEvent {}

class StartHomeEvent extends HomeEvent {}

class PickLolPathHomeEvent extends HomeEvent {
  final String pickedPath;

  PickLolPathHomeEvent({
    required this.pickedPath,
  });
}

class LoadCurrentSummonerInfoHomeEvent extends HomeEvent {}

class ChangeSortHomeEvent extends HomeEvent {
  final ChampionsTableColumn column;
  final bool ascending;

  ChangeSortHomeEvent({
    required this.column,
    required this.ascending,
  });
}

class PickSessionUpdatedHomeEvent extends HomeEvent {
  final PickSession? pickSession;

  PickSessionUpdatedHomeEvent({
    this.pickSession,
  });
}
