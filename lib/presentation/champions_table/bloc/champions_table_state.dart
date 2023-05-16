part of 'champions_table_bloc.dart';

sealed class ChampionsTableState {}

class SummaryChampionsTableState extends ChampionsTableState with EquatableMixin {
  final int currentSummonerId;

  final ChampionsTableColumn sortColumn;
  final bool ascending;
  final List<Champion> champions;

  SummaryChampionsTableState({
    required this.currentSummonerId,
    this.sortColumn = ChampionsTableColumn.champion,
    this.ascending = true,
    required this.champions,
  });

  @override
  List<Object?> get props => [currentSummonerId, sortColumn, ascending, champions];

  SummaryChampionsTableState copyWith({
    int? currentSummonerId,
    ChampionsTableColumn? sortColumn,
    bool? ascending,
    List<Champion>? champions,
  }) {
    return SummaryChampionsTableState(
      currentSummonerId: currentSummonerId ?? this.currentSummonerId,
      sortColumn: sortColumn ?? this.sortColumn,
      ascending: ascending ?? this.ascending,
      champions: champions ?? this.champions,
    );
  }
}

class PickInfoChampionsTableState extends ChampionsTableState with EquatableMixin {
  final SummaryChampionsTableState summaryState;

  final Champion? myChampion;
  final List<Champion> teamMatesChampions;
  final List<Champion> benchChampions;

  PickInfoChampionsTableState({
    required this.summaryState,
    this.myChampion,
    required this.teamMatesChampions,
    required this.benchChampions,
  });

  @override
  List<Object?> get props => [summaryState, myChampion, teamMatesChampions, benchChampions];

  PickInfoChampionsTableState copyWith({
    SummaryChampionsTableState? summaryState,
    Champion? myChampion,
    List<Champion>? teamMatesChampions,
    List<Champion>? benchChampions,
  }) {
    return PickInfoChampionsTableState(
      summaryState: summaryState ?? this.summaryState,
      myChampion: myChampion ?? this.myChampion,
      teamMatesChampions: teamMatesChampions ?? this.teamMatesChampions,
      benchChampions: benchChampions ?? this.benchChampions,
    );
  }
}
