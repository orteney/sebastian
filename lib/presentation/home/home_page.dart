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
import 'package:sebastian/presentation/home/screens/lol_not_launched_or_wrong_path.dart';
import 'package:sebastian/presentation/summoner/summoner_widget.dart';

import 'bloc/home_bloc.dart';
import 'screens/message_with_retry.dart';
import 'screens/message_wth_loading.dart';
import 'screens/pick_lol_path.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return BlocProvider(
      create: (context) => HomeBloc(
        getIt(),
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
            return switch (state) {
              InitialHomeState _ => MessageWithLoading(message: appLocalizations.homeMessageConnecting),
              LolPathUnspecifiedHomeState _ => PickLolPathScreen(
                  onRetryTap: () => context.read<HomeBloc>().add(StartHomeEvent()),
                  onPickedPath: (path) => context.read<HomeBloc>().add(PickLolPathHomeEvent(pickedPath: path)),
                ),
              PickedWrongLolPathHomeState _ => PickLolPathScreen(
                  pickedWrongPath: true,
                  onRetryTap: () => context.read<HomeBloc>().add(StartHomeEvent()),
                  onPickedPath: (path) => context.read<HomeBloc>().add(PickLolPathHomeEvent(pickedPath: path)),
                ),
              LolNotLaunchedOrWrongPathProvidedHomeState _ => LolNotLaunchedOrWrongPathProvidedScreen(
                  message: appLocalizations.homeMessageLolOffline,
                  onTapRetry: () => context.read<HomeBloc>().add(StartHomeEvent()),
                  onTapChangePath: () => context.read<HomeBloc>().add(TapClearLolPathHomeEvent()),
                ),
              ErrorHomeState _ => MessageWithRetryScreen(
                  message: state.message,
                  onTapRetry: () => context.read<HomeBloc>().add(StartHomeEvent()),
                ),
              LoadingSummonerInfoHomeState _ => MessageWithLoading(message: appLocalizations.homeMessageLoadingData),
              LoadedHomeState _ => LoadedHomeStateWidget(state: state),
            };
          },
        ),
      ),
    );
  }
}

class LoadedHomeStateWidget extends StatelessWidget {
  const LoadedHomeStateWidget({
    required this.state,
    super.key,
  });

  final LoadedHomeState state;

  @override
  Widget build(BuildContext context) {
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
              child: Card(
                margin: EdgeInsets.zero,
                // type: MaterialType.card,
                clipBehavior: Clip.antiAlias,
                // borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: switch (state.destination) {
                  Destination.championPick => ChampionPickPage(summonerId: state.summonerId),
                  Destination.mastery => ChampionsTableWidget(summonerId: state.summonerId),
                  Destination.disenchanter => const ChampionsDisenchanterWidget(),
                  Destination.stats => const ChampionsTierListWidget(),
                },
              ),
            ),
          ),
        ],
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
    final appLocalizations = AppLocalizations.of(context);

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
    final appLocalizations = AppLocalizations.of(context);

    return ListTile(
      title: Text(switch (destination) {
        Destination.mastery => appLocalizations.homeNavigationMastery,
        Destination.disenchanter => appLocalizations.homeNavigationDisenchanter,
        Destination.championPick => appLocalizations.homeNavigationCurrentGame,
        Destination.stats => appLocalizations.homeNavigationTierList
      }),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      style: ListTileStyle.drawer,
      selected: isChecked,
      onTap: () => context.read<HomeBloc>().add(TapDestinationHomeEvent(destination)),
    );
  }
}
