import 'package:champmastery/presentation/home/screens/summoner_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:champmastery/data/models/chamption.dart';
import 'package:champmastery/presentation/core/unknown_bloc_state.dart';
import 'package:champmastery/presentation/home/home_models.dart';

import 'home_bloc.dart';
import 'screens/message_with_retry.dart';
import 'screens/message_wth_loading.dart';
import 'screens/pick_lol_path.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is InitialHomeState) {
            return const MessageWithLoading(message: 'Соединяюсь с League of Legends');
          }

          if (state is LolPathUnspecifiedHomeState) {
            return PickLolPathScreen(
              customMessage: state.message,
              onPickedPath: (path) => context.read<HomeBloc>().add(PickLolPathHomeEvent(pickedPath: path)),
            );
          }

          if (state is LolNotLaunchedOrWrongPathProvidedHomeState) {
            return MessageWithRetryScreen(
              message: 'Похоже лига не запущена, нажми кнопку, когда запустится',
              onTapRetry: () => context.read<HomeBloc>().add(StartHomeEvent()),
            );
          }

          if (state is ErrorHomeState) {
            return MessageWithRetryScreen(
              message: state.message,
              onTapRetry: () => context.read<HomeBloc>().add(StartHomeEvent()),
            );
          }

          if (state is LoadingSummonerInfoHomeState) {
            return const MessageWithLoading(message: 'Загружаю информацию о призывателе');
          }

          if (state is SummonerInfoHomeState) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SummonerInfo(summoner: state.summoner),
                const VerticalDivider(),
                Expanded(
                  child: _ChampionsTable(
                    champions: state.champions,
                    sortAscending: state.ascending ?? true,
                    sortColumnIndex:
                        state.sortColumn != null ? ChampionsTableColumn.values.indexOf(state.sortColumn!) : null,
                    onSortColumn: (int columnIndex, bool ascending) => context.read<HomeBloc>().add(
                          ChangeSortHomeEvent(
                            column: ChampionsTableColumn.values[columnIndex],
                            ascending: ascending,
                          ),
                        ),
                  ),
                ),
              ],
            );
          }

          if (state is PickInfoHomeState) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SummonerInfo(summoner: state.summonerInfoState.summoner),
                const VerticalDivider(),
                Expanded(
                  child: _PickTable(
                    myChampion: state.myChampion,
                    benchChampions: state.benchChampions,
                    teamChampions: state.teamMatesChampions,
                  ),
                ),
              ],
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
    return SingleChildScrollView(
      child: DataTable(
        sortColumnIndex: sortColumnIndex,
        sortAscending: sortAscending,
        headingTextStyle: const TextStyle(fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),
        columns: _buildChampionColumns(onSortColumn),
        rows: champions.map((champion) => _buildChampionRow(champion, _ChampionType.none)).toList(),
      ),
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
    return SingleChildScrollView(
      child: DataTable(
        headingTextStyle: const TextStyle(fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),
        columns: _buildChampionColumns(),
        rows: [
          if (myChampion != null) _buildChampionRow(myChampion!, _ChampionType.my),
          ...benchChampions.map((e) => _buildChampionRow(e, _ChampionType.bench)),
          ...teamChampions.map((e) => _buildChampionRow(e, _ChampionType.teamMate)),
        ],
      ),
    );
  }
}

List<DataColumn> _buildChampionColumns([DataColumnSortCallback? onSortColumn]) {
  return <DataColumn>[
    DataColumn(
      onSort: onSortColumn,
      label: const Text('Чемпион'),
    ),
    DataColumn(
      onSort: onSortColumn,
      numeric: true,
      label: const Text('Уровень'),
    ),
    DataColumn(
      onSort: onSortColumn,
      numeric: true,
      label: const Text('Очков'),
    ),
    DataColumn(
      onSort: onSortColumn,
      numeric: true,
      label: const Text('До сл. ур.'),
    ),
    DataColumn(
      onSort: onSortColumn,
      label: const Text('Сундук?'),
    ),
  ];
}

enum _ChampionType {
  none,
  my,
  bench,
  teamMate,
}

DataRow _buildChampionRow(Champion champion, _ChampionType type) {
  MaterialStateProperty<Color>? rowColor;

  switch (type) {
    case _ChampionType.none:
      break;
    case _ChampionType.my:
      rowColor = MaterialStateProperty.all(Colors.green[900]!);
      break;
    case _ChampionType.bench:
      rowColor = MaterialStateProperty.all(Colors.yellow[900]!);
      break;
    case _ChampionType.teamMate:
      rowColor = MaterialStateProperty.all(Colors.blue[900]!);
      break;
  }

  return DataRow(
    color: rowColor,
    cells: <DataCell>[
      DataCell(Text(champion.name)),
      DataCell(Text(champion.mastery.championLevel.toString())),
      DataCell(Text(champion.mastery.championPoints.toString())),
      DataCell(Text(champion.mastery.championPointsUntilNextLevel.toString())),
      DataCell(Checkbox(value: champion.mastery.chestGranted, onChanged: null)),
    ],
  );
}
