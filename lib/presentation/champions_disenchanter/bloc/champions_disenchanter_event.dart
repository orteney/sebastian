part of 'champions_disenchanter_bloc.dart';

abstract class ChampionsDisenchanterEvent {}

class LoadLootChampionsDisenchanterEvent extends ChampionsDisenchanterEvent {}

class IncreaseCountChampionsDisenchanterEvent extends ChampionsDisenchanterEvent {
  final SelectedLootCount selectedLoot;

  IncreaseCountChampionsDisenchanterEvent(this.selectedLoot);
}

class DecreaseChampionsDisenchanterEvent extends ChampionsDisenchanterEvent {
  final SelectedLootCount selectedLoot;

  DecreaseChampionsDisenchanterEvent(this.selectedLoot);
}

class DisenchantSelectedChampionsDisenchanterEvent extends ChampionsDisenchanterEvent {}

class SelectAllChampionsDisenchanterEvent extends ChampionsDisenchanterEvent {}

class UnselectAllChampionsDisenchanterEvent extends ChampionsDisenchanterEvent {}

class PickedSortFieldChampionsDisenchanterEvent extends ChampionsDisenchanterEvent {
  final SortField sortField;

  PickedSortFieldChampionsDisenchanterEvent(this.sortField);
}
