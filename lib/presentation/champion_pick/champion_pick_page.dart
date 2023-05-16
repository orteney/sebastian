import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:sebastian/data/models/lcu_image.dart';
import 'package:sebastian/domain/builds/build_info.dart';
import 'package:sebastian/domain/core/role.dart';
import 'package:sebastian/presentation/champion_pick/bloc/champion_pick_bloc.dart';
import 'package:sebastian/presentation/core/widgets/blurry_container.dart';
import 'package:sebastian/presentation/core/widgets/icons/role_icon.dart';
import 'package:sebastian/presentation/core/widgets/sebastian_message.dart';
import 'package:sebastian/presentation/core/widgets/snackbar_presenter.dart';

import 'widgets/build_details.dart';

class ChampionPickPage extends StatelessWidget {
  const ChampionPickPage({super.key, required this.summonerId});

  final int summonerId;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return BlocBuilder<ChampionPickBloc, ChampionPickState>(
      builder: (context, state) {
        return switch (state) {
          NoActiveChampionPickState _ => Center(
              child: SebastianMessage(
                child: Text(appLocalizations.championPickNotInLobbyMessage),
              ),
            ),
          NoPickedChampionPickState _ => Center(
              child: SebastianMessage(
                child: Text(appLocalizations.championPickNoPickedChampionMessage),
              ),
            ),
          ActiveChampionPickState _ => SnackbarPresenter(
              messageStream: context.read<ChampionPickBloc>().errorMessageStream,
              child: _ActiveChampionPickWidget(state: state),
            ),
        };
      },
    );
  }
}

class _ActiveChampionPickWidget extends StatelessWidget {
  const _ActiveChampionPickWidget({
    required this.state,
  });

  final ActiveChampionPickState state;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final bool hasBuilds = state.builds.isNotEmpty;

    return Ink(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          colorFilter: const ColorFilter.mode(
            Color(0x80000000),
            BlendMode.srcOver,
          ),
          image: NetworkImage(
            state.splashImage.url,
            headers: state.splashImage.headers,
          ),
        ),
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      state.pickedChampion.name,
                      style: theme.textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(width: 16),
                    _RoleTag(role: state.role),
                    const SizedBox(width: 16),
                    OutlinedButton.icon(
                      onPressed: hasBuilds
                          ? () =>
                              context.read<ChampionPickBloc>().add(TapImportBuildChampionPickEvent(appLocalizations))
                          : null,
                      icon: const Icon(Icons.file_upload_rounded),
                      label: Text(appLocalizations.championPickImportButton),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (!hasBuilds)
                  SebastianMessage(
                    child: Text(
                      appLocalizations.championPickNoBuildsMessage,
                      style: theme.textTheme.titleLarge,
                    ),
                  )
                else ...[
                  Row(
                    children: List.generate(
                      state.builds.length,
                      (index) {
                        final build = state.builds[index];

                        return Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: _BuildTab(
                            keyPerkIcon: state.runesImages[build.keystoneId]!,
                            championBuild: build,
                            color: index == state.selectedBuildIndex ? state.selectedPerkStyle.color : null,
                            onTap: () =>
                                context.read<ChampionPickBloc>().add(TapAvailableBuildTabChampionPickEvent(index)),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return BuildDetails(
                        singleColumn: constraints.maxWidth < 720,
                        championBuild: state.builds[state.selectedBuildIndex],
                        runesImages: state.runesImages,
                        itemImages: state.itemImages,
                        summonerSpellImages: state.summonerSpellImages,
                        color: state.selectedPerkStyle.color,
                      );
                    },
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RoleTag extends StatelessWidget {
  final Role? role;

  const _RoleTag({
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (role == null) {
      return Text(
        'ARAM',
        style: TextStyle(color: theme.colorScheme.primary),
      );
    }

    return DropdownButton<Role>(
      value: role,
      underline: const SizedBox.shrink(),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      onChanged: (role) => context.read<ChampionPickBloc>().add(SelectRoleChampionPickEvent(role!)),
      items: [
        for (var role in Role.values)
          DropdownMenuItem(
            value: role,
            child: RoleIcon(role: role),
          ),
      ],
    );
  }
}

class _BuildTab extends StatelessWidget {
  const _BuildTab({
    required this.championBuild,
    required this.color,
    required this.keyPerkIcon,
    this.onTap,
  });

  final BuildInfo championBuild;
  final LcuImage keyPerkIcon;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final textStyle = Theme.of(context).textTheme.bodyMedium;

    const borderRadius = BorderRadius.all(Radius.circular(12));

    return BlurryContainer(
      color: color ?? Colors.transparent,
      borderRadius: borderRadius,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 12),
          child: Row(
            children: [
              Image.network(keyPerkIcon.url, headers: keyPerkIcon.headers, height: 50, width: 50),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(appLocalizations.winrate(championBuild.winRate), style: textStyle),
                  Text(appLocalizations.matchesCount(championBuild.numMatches), style: textStyle),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
