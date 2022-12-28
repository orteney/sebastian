part of 'champions_table_bloc.dart';

enum ChampionsTableColumn {
  champion(true),
  level(false),
  points(false),
  progress(false),
  statStones(false),
  chestEarned(false);

  final bool initialSortAccending;

  const ChampionsTableColumn(this.initialSortAccending);
}
