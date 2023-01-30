part of 'champion_pick_bloc.dart';

@immutable
abstract class ChampionPickEvent {}

class PickSessionUpdatedChampionPickEvent extends ChampionPickEvent {
  final PickSession? pickSession;

  PickSessionUpdatedChampionPickEvent({
    required this.pickSession,
  });
}

class TapImportBuildChampionPickEvent extends ChampionPickEvent {
  final AppLocalizations appLocalizations;

  TapImportBuildChampionPickEvent(this.appLocalizations);
}

class TapAvailableBuildTabChampionPickEvent extends ChampionPickEvent {
  final int pickedIndex;

  TapAvailableBuildTabChampionPickEvent(this.pickedIndex);
}

class SelectRoleChampionPickEvent extends ChampionPickEvent {
  final Role pickedRole;

  SelectRoleChampionPickEvent(this.pickedRole);
}

class GameEndEventChampionPickEvent extends ChampionPickEvent {}
