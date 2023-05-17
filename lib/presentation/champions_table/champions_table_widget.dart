import 'package:flutter/material.dart';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:sebastian/data/models/champion.dart';
import 'package:sebastian/di/di.dart';
import 'package:sebastian/presentation/core/colors.dart';
import 'package:sebastian/presentation/core/widgets/icons/chest_icon.dart';
import 'package:sebastian/presentation/core/widgets/icons/eternal_bonfire_icon.dart';
import 'package:sebastian/presentation/core/widgets/icons/mastery_icon.dart';

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
          return switch (state) {
            SummaryChampionsTableState state => _ChampionsTable(
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
              ),
            PickInfoChampionsTableState state => _PickTable(
                myChampion: state.myChampion,
                benchChampions: state.benchChampions,
                teamChampions: state.teamMatesChampions,
              ),
          };
        },
      ),
    );
  }
}

const _kTableMinWidth = 700.0;
const _kTableColumnSpacing = 24.0;

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
      minWidth: _kTableMinWidth,
      columnSpacing: _kTableColumnSpacing,
      fixedLeftColumns: 1,
      sortColumnIndex: sortColumnIndex,
      sortAscending: sortAscending,
      headingTextStyle: const TextStyle(fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),
      columns: _buildChampionColumns(appLocalizations, onSortColumn),
      rows: champions.map((champion) => _buildChampionRow(appLocalizations, champion)).toList(),
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
      minWidth: _kTableMinWidth,
      columnSpacing: _kTableColumnSpacing,
      headingTextStyle: const TextStyle(fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),
      columns: _buildChampionColumns(appLocalizations),
      rows: [
        ...benchChampions.map((e) => _buildChampionRow(appLocalizations, e)),
        if (myChampion != null) _buildChampionRow(appLocalizations, myChampion!, SebastianColors.myChampionRowColor),
        ...teamChampions.map((e) => _buildChampionRow(appLocalizations, e, SebastianColors.myTeamChampionRowColor)),
      ],
    );
  }
}

/// Do not forget change order in [ChampionsTableColumn]
List<DataColumn> _buildChampionColumns(
  AppLocalizations appLocalizations, [
  DataColumnSortCallback? onSortColumn,
]) {
  return <DataColumn>[
    DataColumn2(
      onSort: onSortColumn,
      size: ColumnSize.M,
      label: Text(appLocalizations.masteryTableColumnChampion),
    ),
    DataColumn2(
      onSort: onSortColumn,
      fixedWidth: 85,
      label: Center(
        child: Padding(
          padding: EdgeInsets.only(left: onSortColumn != null ? 18 : 0),
          child: const MasteryIcon(
            size: Size(24, 24),
            color: Colors.white,
          ),
        ),
      ),
    ),
    DataColumn2(
      onSort: onSortColumn,
      numeric: true,
      size: ColumnSize.M,
      label: Text(appLocalizations.masteryTableColumnPoints),
    ),
    DataColumn2(
      onSort: onSortColumn,
      numeric: true,
      size: ColumnSize.M,
      label: Text(appLocalizations.masteryTableColumnProgress),
    ),
    DataColumn2(
      onSort: onSortColumn,
      size: ColumnSize.M,
      numeric: true,
      label: Text(appLocalizations.masteryTableColumnEternals),
    ),
    const DataColumn2(
      fixedWidth: 60,
      label: Center(
        child: ChestIcon(
          size: Size(20, 20),
          color: Colors.white,
        ),
      ),
    ),
  ];
}

DataRow _buildChampionRow(
  AppLocalizations appLocalizations,
  Champion champion, [
  Color? color,
]) {
  return DataRow(
    color: color != null ? MaterialStateProperty.all(color) : null,
    cells: <DataCell>[
      DataCell(Text(champion.name)),
      DataCell(Center(child: Text(champion.mastery.championLevel.toString()))),
      DataCell(Text(champion.mastery.championPoints.toString())),
      DataCell(Text(switch (champion.mastery.championLevel) {
        7 => appLocalizations.masteryTableMaxProgress,
        6 => '${champion.mastery.tokensEarned}/3',
        5 => '${champion.mastery.tokensEarned}/2',
        _ => champion.mastery.championPointsUntilNextLevel.toString(),
      })),
      DataCell(Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(champion.statStones.milestonesPassed.toString()),
          const SizedBox(width: 4),
          const EternalBonfireIcon(size: Size(16, 16)),
          const SizedBox(width: 12),
          Text(appLocalizations.masteryTableStatStonesCount(champion.statStones.stonesOwned))
        ],
      )),
      DataCell(Center(child: Checkbox(value: champion.mastery.chestGranted, onChanged: null))),
    ],
  );
}
