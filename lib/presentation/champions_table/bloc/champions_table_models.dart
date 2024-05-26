part of 'champions_table_bloc.dart';

enum ChampionsTableColumn {
  ordinal(true),
  champion(true),
  level(false),
  points(false),
  progress(false),
  milestones(false),
  statStones(false);

  final bool initialSortAccending;

  const ChampionsTableColumn(this.initialSortAccending);
}
