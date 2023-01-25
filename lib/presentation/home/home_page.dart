import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:sebastian/di/di.dart';
import 'package:sebastian/presentation/champion_pick/bloc/champion_pick_bloc.dart';
import 'package:sebastian/presentation/champion_pick/champion_pick_page.dart';
import 'package:sebastian/presentation/champions_disenchanter/champions_disenchanter_widget.dart';
import 'package:sebastian/presentation/champions_table/champions_table_widget.dart';
import 'package:sebastian/presentation/champions_tier_list/champions_tier_list_widget.dart';
import 'package:sebastian/presentation/core/widgets/app_version.dart';
import 'package:sebastian/presentation/core/widgets/unknown_bloc_state.dart';
import 'package:sebastian/presentation/summoner/summoner_widget.dart';

import 'bloc/home_bloc.dart';
import 'screens/message_with_retry.dart';
import 'screens/message_wth_loading.dart';
import 'screens/pick_lol_path.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (context) => HomeBloc(
        getIt(),
        getIt(),
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
              return MessageWithLoading(message: appLocalizations.homeMessageConnecting);
            }

            if (state is LolPathUnspecifiedHomeState) {
              return PickLolPathScreen(
                onRetryTap: () => context.read<HomeBloc>().add(StartHomeEvent()),
                onPickedPath: (path) => context.read<HomeBloc>().add(PickLolPathHomeEvent(pickedPath: path)),
              );
            }

            if (state is PickedWrongLolPathHomeState) {
              return PickLolPathScreen(
                pickedWrongPath: true,
                onRetryTap: () => context.read<HomeBloc>().add(StartHomeEvent()),
                onPickedPath: (path) => context.read<HomeBloc>().add(PickLolPathHomeEvent(pickedPath: path)),
              );
            }

            if (state is LolNotLaunchedOrWrongPathProvidedHomeState) {
              return MessageWithRetryScreen(
                message: appLocalizations.homeMessageLolOffline,
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
              return MessageWithLoading(message: appLocalizations.homeMessageLoadingData);
            }

            if (state is LoadedHomeState) {
              Widget body;

              switch (state.destination) {
                case Destination.championPick:
                  body = ChampionPickPage(summonerId: state.summonerId);
                  break;
                case Destination.mastery:
                  body = ChampionsTableWidget(summonerId: state.summonerId);
                  break;
                case Destination.disenchanter:
                  body = const ChampionsDisenchanterWidget();
                  break;
                case Destination.stats:
                  body = const ChampionsTierListWidget();
                  break;
              }

              return BlocProvider(
                create: (context) => ChampionPickBloc(
                  state.summonerId,
                  getIt(),
                  getIt(),
                  getIt(),
                  getIt(),
                  getIt(),
                  getIt(),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NavigationDrawer(
                      currentDestination: state.destination,
                      autoAcceptGame: state.autoAcceptEnabled,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8, right: 8, bottom: 8),
                        child: Material(
                          type: MaterialType.card,
                          clipBehavior: Clip.antiAlias,
                          borderRadius: const BorderRadius.all(Radius.circular(12)),
                          child: body,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            return UnknownBlocState(blocState: state);
          },
        ),
      ),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({
    super.key,
    required this.currentDestination,
    required this.autoAcceptGame,
  });

  final Destination currentDestination;
  final bool autoAcceptGame;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return SizedBox(
      width: 216,
      child: Column(
        children: [
          const Card(
            elevation: 0,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: SummonerWidget(),
            ),
          ),
          Card(
            elevation: 0,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Column(
              children: [
                NavigationMenuItem(
                  destination: Destination.championPick,
                  isChecked: Destination.championPick == currentDestination,
                ),
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 16),
                  title: Tooltip(
                    message: appLocalizations.homeAutoacceptTooltip,
                    child: Text(appLocalizations.homeAutoaccept),
                  ),
                  style: ListTileStyle.drawer,
                  trailing: Switch(
                    value: autoAcceptGame,
                    onChanged: (value) => context.read<HomeBloc>().add(ToggleAutoAcceptHomeEvent()),
                  ),
                ),
              ],
            ),
          ),
          Card(
            elevation: 0,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Column(
              children: [
                NavigationMenuItem(
                  destination: Destination.mastery,
                  isChecked: Destination.mastery == currentDestination,
                ),
                NavigationMenuItem(
                  destination: Destination.stats,
                  isChecked: Destination.stats == currentDestination,
                ),
                NavigationMenuItem(
                  destination: Destination.disenchanter,
                  isChecked: Destination.disenchanter == currentDestination,
                ),
              ],
            ),
          ),
          const Spacer(),
          const SizedBox(height: 16),
          const AppVersion(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class NavigationMenuItem extends StatelessWidget {
  const NavigationMenuItem({
    super.key,
    required this.destination,
    required this.isChecked,
  });

  final Destination destination;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    String name;

    switch (destination) {
      case Destination.mastery:
        name = appLocalizations.homeNavigationMastery;
        break;
      case Destination.disenchanter:
        name = appLocalizations.homeNavigationDisenchanter;
        break;
      case Destination.championPick:
        name = appLocalizations.homeNavigationCurrentGame;
        break;
      case Destination.stats:
        name = appLocalizations.homeNavigationTierList;
    }

    return ListTile(
      title: Text(name),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      style: ListTileStyle.drawer,
      selected: isChecked,
      onTap: () => context.read<HomeBloc>().add(TapDestinationHomeEvent(destination)),
    );
  }
}
