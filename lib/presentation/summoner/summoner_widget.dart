import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sebastian/data/lcu/models/chest_eligibility.dart';
import 'package:sebastian/data/models/summoner.dart';
import 'package:sebastian/di/di.dart';
import 'package:sebastian/presentation/core/widgets/chest_icon.dart';

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
        Text(
          summoner.displayName,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.start,
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
      message: 'До следующего уровня ${untilNextLvlExp - currentExp} опыта.',
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

  String _formatChestTime(DateTime nextChestDateTime) {
    final now = DateTime.now();
    final difference = nextChestDateTime.difference(now);

    String when = '';
    if (difference.inDays > 0) {
      when = '${difference.inDays} дн.';
    } else if (difference.inHours > 0) {
      when = '${difference.inHours} ч.';
    } else {
      when = '${difference.inMinutes} мин.';
    }

    return 'Следующий сундук через $when';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Tooltip(
      message: _formatChestTime(chests.nextChestDateTime()),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (int i = 0; i < chests.maximumChests; i++)
            CustomPaint(
              size: const Size(30, 30),
              painter: ChestIconPainter(
                color: i + 1 > chests.earnableChests ? theme.disabledColor : const Color(0xFFCDBE91),
              ),
            ),
        ],
      ),
    );
  }
}
