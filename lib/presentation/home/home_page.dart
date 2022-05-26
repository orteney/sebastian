import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:champmastery/di/di.dart';
import 'package:champmastery/presentation/champions_table/champions_table_widget.dart';
import 'package:champmastery/presentation/core/widgets/unknown_bloc_state.dart';
import 'package:champmastery/presentation/summoner/summoner_widget.dart';

import 'bloc/home_bloc.dart';
import 'screens/message_with_retry.dart';
import 'screens/message_wth_loading.dart';
import 'screens/pick_lol_path.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
      )..add(StartHomeEvent()),
      child: Scaffold(
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

            if (state is LoadedHomeState) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SummonerWidget(),
                  const VerticalDivider(),
                  Expanded(child: ChampionsTableWidget(summonerId: state.summonerId)),
                ],
              );
            }

            return UnknownBlocState(blocState: state);
          },
        ),
      ),
    );
  }
}
