part of 'champions_table_bloc.dart';

@immutable
abstract class ChampionsTableEvent {}

class UpdatedChampionsTableEvent extends ChampionsTableEvent {
  final List<Champion> updatedChampions;

  UpdatedChampionsTableEvent({
    required this.updatedChampions,
  });
}

class ChangeSortChampionsTableEvent extends ChampionsTableEvent {
  final ChampionsTableColumn column;
  final bool ascending;

  ChangeSortChampionsTableEvent({
    required this.column,
    required this.ascending,
  });
}

class PickSessionUpdatedChampionsTableEvent extends ChampionsTableEvent {
  final PickSession? pickSession;

  PickSessionUpdatedChampionsTableEvent({
    this.pickSession,
  });
}

class ChangeRoleFilterChampionsTableEvent extends ChampionsTableEvent {
  final ChampionRole? roleFilter;

  ChangeRoleFilterChampionsTableEvent(this.roleFilter);
}

class ChangeOnlySetFilterChampionsTableEvent extends ChampionsTableEvent {
  final bool enabled;

  ChangeOnlySetFilterChampionsTableEvent(this.enabled);
}
