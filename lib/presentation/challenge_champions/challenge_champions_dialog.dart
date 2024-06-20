import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sebastian/di/di.dart';

import 'bloc/challenge_champions_cubit.dart';

class ChallengeChampionsDialog extends StatefulWidget {
  const ChallengeChampionsDialog({
    super.key,
    required this.challengeName,
    required this.availableChampions,
    required this.completedChampionIds,
  });

  final String challengeName;
  final List<int> availableChampions;
  final List<int> completedChampionIds;

  @override
  State<ChallengeChampionsDialog> createState() => _ChallengeChampionsDialogState();
}

class _ChallengeChampionsDialogState extends State<ChallengeChampionsDialog> {
  late final ChallengeChampionsCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = ChallengeChampionsCubit(
      widget.availableChampions,
      widget.completedChampionIds,
      getIt(),
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      title: Text(widget.challengeName),
      content: SizedBox(
        width: MediaQuery.sizeOf(context).width / 2,
        child: BlocBuilder<ChallengeChampionsCubit, List<ChallengeChampionsModel>>(
          bloc: _cubit,
          builder: (context, state) {
            return GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 120),
              itemCount: state.length,
              itemBuilder: (context, index) {
                final model = state[index];

                return Card.outlined(
                  color: model.completed ? theme.colorScheme.surfaceContainerHigh : null,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        model.name,
                        style: theme.textTheme.titleSmall!,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(MaterialLocalizations.of(context).closeButtonLabel.toUpperCase()),
        ),
      ],
    );
  }
}
