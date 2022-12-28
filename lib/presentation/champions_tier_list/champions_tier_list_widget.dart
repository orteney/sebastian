import 'package:flutter/material.dart';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sebastian/di/di.dart';
import 'package:sebastian/domain/champion_tier/champion_tier.dart';
import 'package:sebastian/domain/core/role.dart';
import 'package:sebastian/presentation/core/colors.dart';
import 'package:sebastian/presentation/core/widgets/icons/role_icon.dart';
import 'package:sebastian/presentation/core/widgets/unknown_bloc_state.dart';

import 'bloc/champions_tier_list_bloc.dart';
import 'bloc/champions_tier_list_models.dart';

class ChampionsTierListWidget extends StatelessWidget {
  const ChampionsTierListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChampionsTierListBloc(getIt(), getIt())..add(InitChampionsTierListEvent()),
      child: BlocBuilder<ChampionsTierListBloc, ChampionsTierListState>(
        builder: (context, state) {
          if (state is InitialChampionsTierListState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is LoadedChampionsTierListState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      QueuePicker(
                        currentQueue: state.currentQueue,
                        onChanged: (value) => context
                            .read<ChampionsTierListBloc>()
                            .add(ChangeQueueChampionsTierListEvent(pickedQueue: value)),
                      ),
                      if (state.currentQueue != AvailableQueue.aram)
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: _RolePicker(
                            role: state.roleFilter,
                            onChanged: (value) => context
                                .read<ChampionsTierListBloc>()
                                .add(ChangeRoleChampionsTierListEvent(pickedRole: value)),
                          ),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  child: _ChampionsTable(
                    championTiers: state.championTiers,
                    sortAscending: state.ascending,
                    sortColumnIndex: ChampionTierTableColumn.values.indexOf(state.sortColumn),
                    onSortColumn: (columnIndex, ascending) {
                      context.read<ChampionsTierListBloc>().add(
                            ChangeSortChampionsTierListEvent(
                              column: ChampionTierTableColumn.values[columnIndex],
                              ascending: ascending,
                            ),
                          );
                    },
                  ),
                ),
              ],
            );
          }

          if (state is AramPickInfoChampionsTierListState) {
            return _AramChampionsTable(
              benchChampionTiers: state.benchChampions,
              teamChampionTiers: state.teamChampions,
            );
          }

          return UnknownBlocState(blocState: state);
        },
      ),
    );
  }
}

class QueuePicker extends StatelessWidget {
  const QueuePicker({
    super.key,
    required this.currentQueue,
    this.onChanged,
  });

  final AvailableQueue currentQueue;
  final ValueChanged<AvailableQueue?>? onChanged;

  @override
  Widget build(BuildContext context) {
    final items = <DropdownMenuItem<AvailableQueue>>[];

    for (var queue in AvailableQueue.values) {
      final String text;
      switch (queue) {
        case AvailableQueue.aram:
          text = 'ARAM';
          break;
        case AvailableQueue.rankedSolo5X5:
          text = 'Ранговая';
          break;
      }

      items.add(
        DropdownMenuItem(
          value: queue,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(text),
          ),
        ),
      );
    }

    return DropdownButton<AvailableQueue>(
      value: currentQueue,
      underline: const SizedBox.shrink(),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      onChanged: onChanged,
      items: items,
    );
  }
}

class _RolePicker extends StatelessWidget {
  const _RolePicker({
    required this.role,
    this.onChanged,
  });

  final Role? role;
  final ValueChanged<Role?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Role>(
      value: role,
      underline: const SizedBox.shrink(),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      onChanged: onChanged,
      items: [
        const DropdownMenuItem(
          value: null,
          child: RoleIcon(role: null),
        ),
        for (var role in Role.values)
          DropdownMenuItem(
            value: role,
            child: RoleIcon(role: role),
          ),
      ],
    );
  }
}

class _ChampionsTable extends StatelessWidget {
  const _ChampionsTable({
    Key? key,
    required this.championTiers,
    this.sortAscending = true,
    this.sortColumnIndex,
    this.onSortColumn,
  }) : super(key: key);

  final List<ChampionTier> championTiers;
  final bool sortAscending;
  final int? sortColumnIndex;
  final DataColumnSortCallback? onSortColumn;

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      minWidth: 800,
      sortColumnIndex: sortColumnIndex,
      sortAscending: sortAscending,
      headingTextStyle: const TextStyle(fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),
      columnSpacing: 24,
      columns: _buildDataColumns(onSortColumn),
      rows: [
        for (var championTier in championTiers) _buildDataRow(championTier),
      ],
    );
  }
}

class _AramChampionsTable extends StatelessWidget {
  const _AramChampionsTable({
    Key? key,
    required this.teamChampionTiers,
    required this.benchChampionTiers,
  }) : super(key: key);

  final List<ChampionTier> teamChampionTiers;
  final List<ChampionTier> benchChampionTiers;

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      minWidth: 800,
      headingTextStyle: const TextStyle(fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),
      columnSpacing: 24,
      columns: _buildDataColumns(),
      rows: [
        for (var championTier in benchChampionTiers)
          _buildDataRow(
            championTier,
          ),
        for (var championTier in teamChampionTiers)
          _buildDataRow(
            championTier,
            color: SebastianColors.myTeamChampionRowColor,
          ),
      ],
    );
  }
}

List<DataColumn> _buildDataColumns([DataColumnSortCallback? onSortColumn]) {
  return [
    DataColumn2(
      label: const Text('Роль'),
      fixedWidth: 65,
      onSort: onSortColumn,
    ),
    DataColumn2(
      label: const Text('Чемпион'),
      size: ColumnSize.M,
      onSort: onSortColumn,
    ),
    DataColumn2(
      label: const Text('Ранг'),
      fixedWidth: 75,
      onSort: onSortColumn,
    ),
    DataColumn2(
      label: const Text('Побед'),
      size: ColumnSize.S,
      onSort: onSortColumn,
      numeric: true,
    ),
    DataColumn2(
      label: const Text('Блокировок'),
      size: ColumnSize.S,
      onSort: onSortColumn,
      numeric: true,
    ),
    DataColumn2(
      label: const Text('Выборов'),
      size: ColumnSize.S,
      onSort: onSortColumn,
      numeric: true,
    ),
    DataColumn2(
      label: const Text('Игр'),
      size: ColumnSize.S,
      onSort: onSortColumn,
      numeric: true,
    ),
  ];
}

DataRow _buildDataRow(ChampionTier championTier, {Color? color}) {
  return DataRow(
    color: color == null ? null : MaterialStateProperty.all(color),
    cells: <DataCell>[
      DataCell(
        championTier.role == null ? const SizedBox.shrink() : RoleIcon(role: championTier.role!),
      ),
      DataCell(Text(championTier.championName)),
      DataCell(
        Center(child: Text(championTier.tierRank?.toString() ?? '')),
      ),
      DataCell(Text('${championTier.winRate.toStringAsFixed(1)} %')),
      DataCell(Text('${championTier.banRate.toStringAsFixed(1)} %')),
      DataCell(Text('${championTier.pickRate.toStringAsFixed(1)} %')),
      DataCell(Text(championTier.games.toString())),
    ],
  );
}