import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:sebastian/data/lcu/models/chest_eligibility.dart';
import 'package:sebastian/data/models/summoner.dart';
import 'package:sebastian/di/di.dart';
import 'package:sebastian/presentation/core/widgets/icons/chest_icon.dart';
import 'package:sebastian/presentation/summoner/secret_menu/secret_menu_dialog.dart';

import 'bloc/summoner_bloc.dart';

class SummonerWidget extends StatelessWidget {
  const SummonerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SummonerBloc(getIt()),
      child: BlocBuilder<SummonerBloc, SummonerState>(
        builder: (context, state) {
          if (state.summoner == null) {
            return const CircularProgressIndicator();
          }

          return _SummonerInfo(summoner: state.summoner!);
        },
      ),
    );
  }
}

class _SummonerInfo extends StatelessWidget {
  const _SummonerInfo({
    required this.summoner,
  });

  final Summoner summoner;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: () => showDialog(context: context, builder: (context) => const SecretMenuDialog()),
          child: Text(
            summoner.displayName,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.start,
          ),
        ),
        const SizedBox(height: 16),
        _LevelProgress(
          currentLvl: summoner.summonerLevel,
          currentExp: summoner.xpSinceLastLevel,
          untilNextLvlExp: summoner.xpUntilNextLevel,
        ),
        const SizedBox(height: 24),
        _AvailableChests(chests: summoner.chestEligibility),
      ],
    );
  }
}

class _LevelProgress extends StatelessWidget {
  const _LevelProgress({
    required this.currentLvl,
    required this.currentExp,
    required this.untilNextLvlExp,
  });

  final int currentLvl;
  final int currentExp;
  final int untilNextLvlExp;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Tooltip(
      message: appLocalizations.summonerNextLevelExpTooltip(untilNextLvlExp - currentExp),
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.titleMedium!,
        child: Row(
          children: [
            Text(currentLvl.toString()),
            const SizedBox(width: 8),
            Expanded(child: LinearProgressIndicator(value: currentExp / untilNextLvlExp)),
            const SizedBox(width: 8),
            Text((currentLvl + 1).toString()),
          ],
        ),
      ),
    );
  }
}

class _AvailableChests extends StatelessWidget {
  const _AvailableChests({required this.chests});

  final ChestEligibility chests;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appLocalizations = AppLocalizations.of(context);

    final now = DateTime.now();
    final difference = chests.nextChestDateTime().difference(now);

    final message = switch (difference) {
      Duration(inDays: 0, inHours: 0, inMinutes: int m) => appLocalizations.summonerNextChestTooltip('minutes', m),
      Duration(inDays: 0, inHours: int h) => appLocalizations.summonerNextChestTooltip('hours', h),
      Duration(inDays: int d) => appLocalizations.summonerNextChestTooltip('days', d),
    };

    return Tooltip(
      message: message,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (int i = 0; i < chests.maximumChests; i++)
            ChestIcon(
              size: const Size(24, 24),
              color: i + 1 > chests.earnableChests
                  ? theme.colorScheme.onSurface.withOpacity(0.38)
                  : const Color(0xFFCDBE91),
            ),
        ],
      ),
    );
  }
}
