import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:champmastery/data/models/chest_eligibility.dart';
import 'package:champmastery/data/models/summoner.dart';
import 'package:champmastery/di/di.dart';

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
    return SizedBox(
      width: 250,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              summoner.displayName,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _LevelProgress(
              currentLvl: summoner.summonerLevel,
              currentExp: summoner.xpSinceLastLevel,
              untilNextLvlExp: summoner.xpUntilNextLevel,
            ),
            const SizedBox(height: 32),
            if (summoner.chestEligibility != null) _AvailableChests(chests: summoner.chestEligibility!),
          ],
        ),
      ),
    );
  }
}

class _LevelProgress extends StatelessWidget {
  const _LevelProgress({
    Key? key,
    required this.currentLvl,
    required this.currentExp,
    required this.untilNextLvlExp,
  }) : super(key: key);

  final int currentLvl;
  final int currentExp;
  final int untilNextLvlExp;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'До следующего уровня $untilNextLvlExp опыта.',
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.titleMedium!,
        child: Row(
          children: [
            Text(currentLvl.toString()),
            const SizedBox(width: 16),
            Expanded(child: LinearProgressIndicator(value: currentExp / (currentExp + untilNextLvlExp))),
            const SizedBox(width: 16),
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

  String _formatChestTime(DateTime nextChestDateTime) {
    final now = DateTime.now();
    final difference = nextChestDateTime.difference(now);

    String when = '';
    if (difference.inDays > 0) {
      when = '${difference.inDays} дн.';
    } else if (difference.inHours > 0) {
      when = '${difference.inDays} ч.';
    } else {
      when = '${difference.inDays} мин.';
    }

    return 'Следующий сундук через $when';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Tooltip(
      message: _formatChestTime(chests.nextChestDateTime()),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (int i = 0; i < chests.maximumChests; i++)
            Image.asset(
              'assets/images/hextech_chest.webp',
              width: 28,
              height: 28,
              color: i + 1 > chests.earnableChests ? theme.disabledColor : null,
            ),
        ],
      ),
    );
  }
}
