import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import 'package:sebastian/di/di.dart';
import 'package:sebastian/presentation/core/widgets/icons/collection_tag.dart';
import 'package:sebastian/presentation/core/widgets/icons/mastery_tag.dart';
import 'package:sebastian/presentation/core/widgets/sebastian_message.dart';

import 'bloc/champions_disenchanter_bloc.dart';

class ChampionsDisenchanterWidget extends StatelessWidget {
  const ChampionsDisenchanterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (context) => ChampionsDisenchanterBloc(getIt(), getIt()),
      child: BlocBuilder<ChampionsDisenchanterBloc, ChampionsDisenchanterState>(
        builder: (context, state) {
          return switch (state) {
            LoadingChampionsDisenchanterState _ => const Center(child: CircularProgressIndicator()),
            EmptyChampionsDisenchanterState _ => Center(child: Text(appLocalizations.disenchanterNoShardsMessage)),
            SelectChampionsDisenchanterState _ => SelectChampionsDisenchanterStateWidget(state: state),
            DisenchantingChampionsDisenchanterState _ => DisenchantingWidget(state: state),
          };
        },
      ),
    );
  }
}

class SelectChampionsDisenchanterStateWidget extends StatelessWidget {
  const SelectChampionsDisenchanterStateWidget({
    required this.state,
    super.key,
  });

  final SelectChampionsDisenchanterState state;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 32),
          child: GridView.builder(
            padding: const EdgeInsets.only(left: 8, bottom: 8, top: 68, right: 8),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
            ),
            itemCount: state.loots.length,
            itemBuilder: (context, index) {
              final lootCount = state.loots[index];

              return _LootCard(
                key: Key(lootCount.loot.lootId),
                lootCount: lootCount,
              );
            },
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: _SummaryDisenchantWidget(
            sortField: state.sortField,
            summaryDisenchantLoot: state.summary,
          ),
        ),
      ],
    );
  }
}

class _LootCard extends StatelessWidget {
  const _LootCard({
    super.key,
    required this.lootCount,
  });

  final SelectedLootCount lootCount;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Card(
      clipBehavior: Clip.hardEdge,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(lootCount.image.url, headers: lootCount.image.headers),
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!lootCount.purchased) const NotOwnedBadge(),
                  if (lootCount.nextLevelTokensCount != null)
                    MasteryBadge(
                      level: lootCount.masteryLevel,
                      nextLevelTokensCount: lootCount.nextLevelTokensCount!,
                    ),
                  const Spacer(),
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4, left: 4, right: 8, bottom: 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _BlueEssence(
                            value: lootCount.loot.disenchantValue,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black87,
                      Colors.black,
                    ],
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 24),
                    Text(
                      lootCount.loot.itemDesc,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 8),
                    OutlinedButtonTheme(
                      data: OutlinedButtonThemeData(
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(28, 28),
                          padding: EdgeInsets.zero,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton(
                            onPressed: () => context
                                .read<ChampionsDisenchanterBloc>()
                                .add(DecreaseChampionsDisenchanterEvent(lootCount)),
                            child: const Icon(Icons.remove),
                          ),
                          Text(
                            appLocalizations.disenchanterShardCount(lootCount.count, lootCount.loot.count),
                            style: const TextStyle(fontSize: 16),
                          ),
                          OutlinedButton(
                            onPressed: () => context
                                .read<ChampionsDisenchanterBloc>()
                                .add(IncreaseCountChampionsDisenchanterEvent(lootCount)),
                            child: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NotOwnedBadge extends StatelessWidget {
  const NotOwnedBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Tooltip(
        message: appLocalizations.disenchanterNotOwnedBadgeTooltip,
        child: const CollectionTag(),
      ),
    );
  }
}

class MasteryBadge extends StatelessWidget {
  const MasteryBadge({
    super.key,
    required this.level,
    required this.nextLevelTokensCount,
  });

  final int level;
  final int nextLevelTokensCount;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Tooltip(
        message: appLocalizations.disenchanterMasteryBadgeTooltip(level, nextLevelTokensCount),
        child: const MasteryTag(),
      ),
    );
  }
}

class _SummaryDisenchantWidget extends StatelessWidget {
  const _SummaryDisenchantWidget({
    required this.summaryDisenchantLoot,
    required this.sortField,
  });

  final SummaryDisenchantLoot summaryDisenchantLoot;
  final SortField sortField;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Card(
      margin: const EdgeInsets.only(left: 12, top: 16, right: 12),
      elevation: 10,
      clipBehavior: Clip.antiAlias,
      child: Container(
        height: 74,
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  PopupMenuButton(
                    icon: const Icon(Icons.sort),
                    tooltip: appLocalizations.disenchanterSortTooltip,
                    onSelected: (SortField selectedSort) => context
                        .read<ChampionsDisenchanterBloc>()
                        .add(PickedSortFieldChampionsDisenchanterEvent(selectedSort)),
                    itemBuilder: (context) => [
                      CheckedPopupMenuItem(
                        checked: sortField == SortField.name,
                        value: SortField.name,
                        child: Text(appLocalizations.disenchanterSortByName),
                      ),
                      CheckedPopupMenuItem(
                        checked: sortField == SortField.value,
                        value: SortField.value,
                        child: Text(appLocalizations.disenchanterSortByPrice),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () =>
                        context.read<ChampionsDisenchanterBloc>().add(UnselectAllChampionsDisenchanterEvent()),
                    icon: const Icon(Icons.indeterminate_check_box),
                    tooltip: appLocalizations.disenchanterRemoveAllButton,
                  ),
                  IconButton(
                    onPressed: () =>
                        context.read<ChampionsDisenchanterBloc>().add(SelectAllChampionsDisenchanterEvent()),
                    icon: const Icon(Icons.add_box),
                    tooltip: appLocalizations.disenchanterAddAllButton,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: () =>
                  context.read<ChampionsDisenchanterBloc>().add(DisenchantSelectedChampionsDisenchanterEvent()),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(appLocalizations.disenchanterDisenchantButton),
                  Row(
                    children: [
                      Text(appLocalizations.disenchanterShardsCount(summaryDisenchantLoot.totalCount)),
                      const Icon(Icons.arrow_right_alt),
                      _BlueEssence(value: summaryDisenchantLoot.totalEssence)
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BlueEssence extends StatelessWidget {
  const _BlueEssence({required this.value});

  final int value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/images/currency_champion.png', width: 24, height: 24),
        Text(
          NumberFormat.decimalPattern('ru').format(value),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            height: 24 / 16,
          ),
        ),
      ],
    );
  }
}

class DisenchantingWidget extends StatelessWidget {
  const DisenchantingWidget({
    required this.state,
    super.key,
  });

  final DisenchantingChampionsDisenchanterState state;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Center(
      child: SebastianMessage(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(appLocalizations.disenchanterProgressMessage),
            const SizedBox(height: 16),
            ConstrainedBox(
              constraints: BoxConstraints.loose(const Size.fromWidth(300)),
              child: LinearProgressIndicator(
                value: state.completedEntriesCount / state.toDisenchantEntriesCount,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${state.completedEntriesCount} из ${state.toDisenchantEntriesCount}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
