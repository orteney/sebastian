import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sebastian/data/lcu/models/challenge.dart';
import 'package:sebastian/di/di.dart';
import 'package:sebastian/presentation/challenge_champions/challenge_champions_dialog.dart';

import 'bloc/challenges_bloc.dart';

class ChallengesPage extends StatelessWidget {
  const ChallengesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChallengesBloc(getIt())..add(InitChallengesEvent()),
      child: BlocBuilder<ChallengesBloc, ChallengesState>(
        builder: (context, state) {
          return switch (state) {
            LoadingChallengesState _ => const Center(child: CircularProgressIndicator()),
            LoadedChallengesState state => LoadedChallengesWidget(state: state),
          };
        },
      ),
    );
  }
}

class LoadedChallengesWidget extends StatelessWidget {
  const LoadedChallengesWidget({
    super.key,
    required this.state,
  });

  final LoadedChallengesState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: state.challenges.length,
            itemBuilder: (context, index) {
              final challenge = state.challenges[index];

              return ChallengeCard(
                challenge: challenge,
                onTap: challenge.completedIds.isEmpty
                    ? null
                    : () => showDialog(
                          context: context,
                          builder: (context) => ChallengeChampionsDialog(
                            challengeName: challenge.name,
                            availableChampions: challenge.availableIds,
                            completedChampionIds: challenge.completedIds,
                          ),
                        ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class ChallengeCard extends StatelessWidget {
  const ChallengeCard({
    super.key,
    required this.challenge,
    this.onTap,
  });

  final Challenge challenge;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final levelColor = switch (challenge.currentLevel) {
      ChallengeLevel.none => Colors.white,
      ChallengeLevel.iron => const Color(0xFF696969),
      ChallengeLevel.bronze => const Color(0xFF8c5139),
      ChallengeLevel.silver => const Color(0xFF81989c),
      ChallengeLevel.gold => const Color(0xFFce8639),
      ChallengeLevel.platinum => const Color(0xFF208c99),
      ChallengeLevel.diamond => const Color(0xFF576ace),
      ChallengeLevel.master => const Color(0xFFa137c2),
      ChallengeLevel.grandmaster => const Color(0xFFe17283),
      ChallengeLevel.challenger => const Color(0xFFf4c873),
    };

    final double progress = challenge.nextThreshold == 0
        ? 1
        : ((challenge.currentValue - challenge.currentThreshold) /
            (challenge.nextThreshold - challenge.currentThreshold));

    return Card.filled(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 8,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(challenge.name, style: theme.textTheme.titleMedium),
                            Text(
                              challenge.currentLevel.name,
                              style: theme.textTheme.labelSmall!.copyWith(color: levelColor, height: 1),
                            ),
                          ],
                        ),
                        Text(
                          '${challenge.currentValue.toInt()} / ${(challenge.nextThreshold == 0 ? challenge.currentThreshold : challenge.nextThreshold).toInt()}',
                          style: theme.textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      challenge.description,
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
            LinearProgressIndicator(
              value: progress,
              color: levelColor,
              backgroundColor: Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}
