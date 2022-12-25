part of 'champions_tier_list_bloc.dart';

abstract class ChampionsTierListEvent {}

class InitChampionsTierListEvent extends ChampionsTierListEvent {}

class ChangeSortChampionsTierListEvent extends ChampionsTierListEvent {
  final ChampionTierTableColumn column;
  final bool ascending;

  ChangeSortChampionsTierListEvent({
    required this.column,
    required this.ascending,
  });
}

class PickSessionUpdatedChampionsTierListEvent extends ChampionsTierListEvent {
  final PickSession? pickSession;

  PickSessionUpdatedChampionsTierListEvent({
    this.pickSession,
  });
}

class ChangeQueueChampionsTierListEvent extends ChampionsTierListEvent {
  final AvailableQueue? pickedQueue;

  ChangeQueueChampionsTierListEvent({
    required this.pickedQueue,
  });
}

class ChangeRoleChampionsTierListEvent extends ChampionsTierListEvent {
  final Role? pickedRole;

  ChangeRoleChampionsTierListEvent({
    required this.pickedRole,
  });
}
