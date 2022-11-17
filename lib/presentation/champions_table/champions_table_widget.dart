import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:sebastian/data/models/champion.dart';
import 'package:sebastian/di/di.dart';
import 'package:sebastian/presentation/core/widgets/unknown_bloc_state.dart';

import 'bloc/champions_table_bloc.dart';

class ChampionsTableWidget extends StatelessWidget {
  const ChampionsTableWidget({super.key, required this.summonerId});

  final int summonerId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChampionsTableBloc(summonerId, getIt(), getIt()),
      child: BlocBuilder<ChampionsTableBloc, ChampionsTableState>(
        builder: (context, state) {
          if (state is SummaryChampionsTableState) {
            return _ChampionsTable(
              champions: state.champions,
              sortAscending: state.ascending,
              sortColumnIndex: ChampionsTableColumn.values.indexOf(state.sortColumn),
              onSortColumn: (int columnIndex, bool ascending) {
                context.read<ChampionsTableBloc>().add(
                      ChangeSortChampionsTableEvent(
                        column: ChampionsTableColumn.values[columnIndex],
                        ascending: ascending,
                      ),
                    );
              },
            );
          }

          if (state is PickInfoChampionsTableState) {
            return _PickTable(
              myChampion: state.myChampion,
              benchChampions: state.benchChampions,
              teamChampions: state.teamMatesChampions,
            );
          }

          return UnknownBlocState(blocState: state);
        },
      ),
    );
  }
}

class _ChampionsTable extends StatelessWidget {
  const _ChampionsTable({
    Key? key,
    required this.champions,
    this.sortAscending = true,
    this.sortColumnIndex,
    this.onSortColumn,
  }) : super(key: key);

  final List<Champion> champions;
  final bool sortAscending;
  final int? sortColumnIndex;
  final DataColumnSortCallback? onSortColumn;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return DataTable2(
      minWidth: 700,
      fixedLeftColumns: 1,
      sortColumnIndex: sortColumnIndex,
      sortAscending: sortAscending,
      headingTextStyle: const TextStyle(fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),
      columns: _buildChampionColumns(onSortColumn),
      rows: champions.map((champion) => _buildChampionRow(appLocalizations, champion, _ChampionType.none)).toList(),
    );
  }
}

class _PickTable extends StatelessWidget {
  const _PickTable({
    this.myChampion,
    required this.benchChampions,
    required this.teamChampions,
  });

  final Champion? myChampion;
  final List<Champion> benchChampions;
  final List<Champion> teamChampions;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return DataTable2(
      minWidth: 700,
      fixedLeftColumns: 1,
      headingTextStyle: const TextStyle(fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),
      columns: _buildChampionColumns(),
      rows: [
        if (myChampion != null) _buildChampionRow(appLocalizations, myChampion!, _ChampionType.my),
        ...benchChampions.map((e) => _buildChampionRow(appLocalizations, e, _ChampionType.bench)),
        ...teamChampions.map((e) => _buildChampionRow(appLocalizations, e, _ChampionType.teamMate)),
      ],
    );
  }
}

/// Do not forget change order in [ChampionsTableColumn]
List<DataColumn> _buildChampionColumns([DataColumnSortCallback? onSortColumn]) {
  return <DataColumn>[
    DataColumn2(
      onSort: onSortColumn,
      label: const Text('Чемпион'),
      size: ColumnSize.M,
    ),
    DataColumn2(
      onSort: onSortColumn,
      numeric: true,
      label: const Text('Ур.'),
      size: ColumnSize.S,
    ),
    DataColumn2(
      onSort: onSortColumn,
      numeric: true,
      label: const Text('Очков'),
      size: ColumnSize.M,
    ),
    DataColumn2(
      onSort: onSortColumn,
      numeric: true,
      label: const Text('Прогресс'),
      size: ColumnSize.M,
    ),
    DataColumn2(
      onSort: onSortColumn,
      label: const Text('Вечные'),
      size: ColumnSize.M,
    ),
    DataColumn2(
      onSort: onSortColumn,
      label: const Text('Сундук?'),
      size: ColumnSize.S,
    ),
  ];
}

enum _ChampionType {
  none,
  my,
  bench,
  teamMate,
}

DataRow _buildChampionRow(AppLocalizations appLocalizations, Champion champion, _ChampionType type) {
  MaterialStateProperty<Color>? rowColor;

  switch (type) {
    case _ChampionType.none:
      break;
    case _ChampionType.my:
      rowColor = MaterialStateProperty.all(const Color(0xFF14460F));
      break;
    case _ChampionType.bench:
      rowColor = MaterialStateProperty.all(const Color(0xFF4A460F));
      break;
    case _ChampionType.teamMate:
      rowColor = MaterialStateProperty.all(const Color(0xFF141045));
      break;
  }

  Widget progressRowData;

  if (champion.mastery.championLevel == 7) {
    progressRowData = const Text('Мастер');
  } else if (champion.mastery.championLevel == 6) {
    progressRowData = Text('${champion.mastery.tokensEarned}/3');
  } else if (champion.mastery.championLevel == 5) {
    progressRowData = Text('${champion.mastery.tokensEarned}/2');
  } else {
    progressRowData = Text(champion.mastery.championPointsUntilNextLevel.toString());
  }

  return DataRow(
    color: rowColor,
    cells: <DataCell>[
      DataCell(Text(champion.name)),
      DataCell(Text(champion.mastery.championLevel.toString())),
      DataCell(Text(champion.mastery.championPoints.toString())),
      DataCell(progressRowData),
      DataCell(Text(
        '${appLocalizations.championsTableMilestonesCount(champion.statStones.milestonesPassed)}\n${appLocalizations.championsTableStonesCount(champion.statStones.stonesOwned)}',
      )),
      DataCell(Checkbox(value: champion.mastery.chestGranted, onChanged: null)),
    ],
  );
}
