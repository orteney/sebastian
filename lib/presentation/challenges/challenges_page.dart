import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:sebastian/data/lcu/models/challenge.dart';
import 'package:sebastian/di/di.dart';
import 'package:sebastian/presentation/challenge_champions/challenge_champions_dialog.dart';
import 'package:sebastian/presentation/core/widgets/sebastian_message.dart';

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
    final appLocalizations = AppLocalizations.of(context);

    return Stack(
      children: [
        state.challenges.isEmpty
            ? Center(child: SebastianMessage(child: Text(appLocalizations.challengesEmpty)))
            : Padding(
                padding: const EdgeInsets.only(top: 32),
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 68),
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
        Align(
          alignment: Alignment.topCenter,
          child: ChallengesToolbar(
            state: state,
            onTapFilter: (filter) => context.read<ChallengesBloc>().add(ToggleFilterChallengesEvent(filter)),
            onTapGameModeFilter: (filter) =>
                context.read<ChallengesBloc>().add(ToggleGameModeFilterChallengesEvent(filter)),
            onTapRefresh: () => context.read<ChallengesBloc>().add(TapRefreshChallengesEvent()),
          ),
        ),
      ],
    );
  }
}

class ChallengesToolbar extends StatelessWidget {
  const ChallengesToolbar({
    super.key,
    required this.state,
    required this.onTapFilter,
    required this.onTapGameModeFilter,
    required this.onTapRefresh,
  });

  final LoadedChallengesState state;
  final void Function(ChallengesFilter) onTapFilter;
  final void Function(ChallengeGameModeFilter) onTapGameModeFilter;
  final VoidCallback onTapRefresh;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appLocalizations = AppLocalizations.of(context);

    return Card.filled(
      margin: const EdgeInsets.only(left: 12, top: 16, right: 12),
      color: theme.colorScheme.surfaceContainerHighest,
      elevation: 10,
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: 74,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 8),
          child: Row(
            children: [
              FilterChip(
                label: Text(appLocalizations.challengesFilterOnlyNonMaxed),
                selected: state.activeFilters.contains(ChallengesFilter.maxed),
                onSelected: (selected) => onTapFilter(ChallengesFilter.maxed),
              ),
              const VerticalDivider(),
              FilterChip(
                label: Text(appLocalizations.challengesFilterGameModeClassic),
                selected: state.gameModeFilter == ChallengeGameModeFilter.classic,
                onSelected: (selected) => onTapGameModeFilter(ChallengeGameModeFilter.classic),
              ),
              const SizedBox(width: 8),
              FilterChip(
                label: Text(appLocalizations.challengesFilterGameModeAram),
                selected: state.gameModeFilter == ChallengeGameModeFilter.aram,
                onSelected: (selected) => onTapGameModeFilter(ChallengeGameModeFilter.aram),
              ),
              const SizedBox(width: 8),
              FilterChip(
                label: Text(appLocalizations.challengesFilterGameModeVsAi),
                selected: state.gameModeFilter == ChallengeGameModeFilter.vsAi,
                onSelected: (selected) => onTapGameModeFilter(ChallengeGameModeFilter.vsAi),
              ),
              const SizedBox(width: 8),
              FilterChip(
                label: Text(appLocalizations.challengesFilterGameModeArena),
                selected: state.gameModeFilter == ChallengeGameModeFilter.arena,
                onSelected: (selected) => onTapGameModeFilter(ChallengeGameModeFilter.arena),
              ),
              const VerticalDivider(),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 200),
                    child: TextField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged: (value) => context.read<ChallengesBloc>().add(ChangeSearchQueryChallengesEvent(value)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              IconButton(
                onPressed: state.refreshing ? null : onTapRefresh,
                icon: state.refreshing
                    ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator())
                    : const Icon(Icons.refresh),
              ),
            ],
          ),
        ),
      ),
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

    return Card(
      color: theme.colorScheme.surfaceContainerHigh,
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
