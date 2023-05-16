part of 'champions_disenchanter_bloc.dart';

sealed class ChampionsDisenchanterState {}

class LoadingChampionsDisenchanterState extends ChampionsDisenchanterState {}

class EmptyChampionsDisenchanterState extends ChampionsDisenchanterState {}

class SelectChampionsDisenchanterState extends ChampionsDisenchanterState with EquatableMixin {
  final List<SelectedLootCount> loots;
  final SortField sortField;
  final SummaryDisenchantLoot summary;

  SelectChampionsDisenchanterState({
    required this.loots,
    required this.sortField,
    required this.summary,
  });

  @override
  List<Object?> get props => [loots, sortField, summary];

  SelectChampionsDisenchanterState copyWith({
    List<SelectedLootCount>? loots,
    SortField? sortField,
    SummaryDisenchantLoot? summary,
  }) {
    return SelectChampionsDisenchanterState(
      loots: loots ?? this.loots,
      sortField: sortField ?? this.sortField,
      summary: summary ?? this.summary,
    );
  }
}

class DisenchantingChampionsDisenchanterState extends ChampionsDisenchanterState with EquatableMixin {
  final int toDisenchantEntriesCount;
  final int completedEntriesCount;

  DisenchantingChampionsDisenchanterState({
    required this.toDisenchantEntriesCount,
    required this.completedEntriesCount,
  });

  @override
  List<Object?> get props => [toDisenchantEntriesCount, completedEntriesCount];

  DisenchantingChampionsDisenchanterState copyWith({
    int? toDisenchantEntriesCount,
    int? completedEntriesCount,
  }) {
    return DisenchantingChampionsDisenchanterState(
      toDisenchantEntriesCount: toDisenchantEntriesCount ?? this.toDisenchantEntriesCount,
      completedEntriesCount: completedEntriesCount ?? this.completedEntriesCount,
    );
  }
}
