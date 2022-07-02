import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:champmastery/data/lcu.dart';
import 'package:champmastery/data/models/lcu_image.dart';
import 'package:champmastery/data/models/loot.dart';
import 'package:champmastery/data/repositories/champion_repository.dart';
import 'package:champmastery/data/utils/cyrillic_comparator.dart';

part 'champions_disenchanter_event.dart';
part 'champions_disenchanter_models.dart';
part 'champions_disenchanter_state.dart';

class ChampionsDisenchanterBloc extends Bloc<ChampionsDisenchanterEvent, ChampionsDisenchanterState> {
  final LCU _lcu;
  final ChampionRepository _championRepository;

  ChampionsDisenchanterBloc(this._lcu, this._championRepository) : super(LoadingChampionsDisenchanterState()) {
    on<LoadLootChampionsDisenchanterEvent>(_onLoadLootChampionsDisenchanterEvent);
    on<IncreaseCountChampionsDisenchanterEvent>(_onIncreaseCountChampionsDisenchanterEvent);
    on<DecreaseChampionsDisenchanterEvent>(_onDecreaseChampionsDisenchanterEvent);
    on<DisenchantSelectedChampionsDisenchanterEvent>(_onDisenchantSelectedChampionsDisenchanterEvent);
    on<SelectAllChampionsDisenchanterEvent>(_onSelectAllChampionsDisenchanterEvent);
    on<UnselectAllChampionsDisenchanterEvent>(_onUnselectAllChampionsDisenchanterEvent);
    on<PickedSortFieldChampionsDisenchanterEvent>(_onPickedSortFieldChampionsDisenchanterEvent);

    add(LoadLootChampionsDisenchanterEvent());
  }

  Future<void> _onLoadLootChampionsDisenchanterEvent(
    LoadLootChampionsDisenchanterEvent event,
    Emitter<ChampionsDisenchanterState> emit,
  ) async {
    final loots = await _lcu.getPlayerLoot();

    final tokenLoots = <Loot>[];
    final championsLoots = <Loot>[];

    for (var loot in loots) {
      switch (loot.type) {
        case 'CHAMPION_RENTAL':
          championsLoots.add(loot);
          break;
        case 'CHAMPION_TOKEN':
          tokenLoots.add(loot);
          break;
      }
    }

    if (championsLoots.isEmpty) {
      return emit(EmptyChampionsDisenchanterState());
    }

    final selectableLoots = <SelectedLootCount>[];

    for (var championLoot in championsLoots) {
      int masteryLevel = 0;
      final champion = _championRepository.champions.where((element) => element.id == championLoot.storeItemId);
      if (champion.isNotEmpty) {
        masteryLevel = champion.first.mastery.championLevel;
      }

      selectableLoots.add(
        SelectedLootCount(
          loot: championLoot,
          count: _calcSafeToDisenchantCount(championLoot.count, masteryLevel),
          image: _lcu.getLcuImage(championLoot.tilePath),
          purchased: championLoot.redeemableStatus == 'ALREADY_OWNED',
          masteryLevel: masteryLevel,
          nextLevelTokensCount: _calcNextLevelTokensCount(
            tokenLoots,
            masteryLevel,
            championLoot.storeItemId.toString(),
          ),
        ),
      );
    }

    emit(SelectChampionsDisenchanterState(
      loots: _sortLootsByField(selectableLoots, SortField.name),
      sortField: SortField.name,
      summary: _calcSummary(selectableLoots),
    ));
  }

  int? _calcNextLevelTokensCount(List<Loot> tokenLoots, int masteryLevel, String championId) {
    if (masteryLevel >= 5 && masteryLevel < 7) {
      for (var tokenLoot in tokenLoots) {
        if (tokenLoot.refId == championId) {
          tokenLoots.remove(tokenLoot);
          return tokenLoot.count;
        }
      }

      return 0;
    }

    return null;
  }

  int _calcSafeToDisenchantCount(int lootCount, int masteryLevel) {
    switch (masteryLevel) {
      case 7:
        return lootCount;
      case 6:
        return max(0, lootCount - 1);
      case 5:
        return max(0, lootCount - 2);
      default:
        return 0;
    }
  }

  void _onIncreaseCountChampionsDisenchanterEvent(
    IncreaseCountChampionsDisenchanterEvent event,
    Emitter<ChampionsDisenchanterState> emit,
  ) {
    if (this.state is! SelectChampionsDisenchanterState) return;

    final state = this.state as SelectChampionsDisenchanterState;

    if (event.selectedLoot.count == event.selectedLoot.loot.count) {
      // Already max count selected
      return;
    }

    final index = state.loots.indexOf(event.selectedLoot);
    final newLoots = state.loots.toList();
    newLoots[index] = event.selectedLoot.copyWith(
      count: event.selectedLoot.count + 1,
    );

    emit(state.copyWith(
      loots: newLoots,
      summary: _calcSummary(newLoots),
    ));
  }

  void _onDecreaseChampionsDisenchanterEvent(
    DecreaseChampionsDisenchanterEvent event,
    Emitter<ChampionsDisenchanterState> emit,
  ) {
    if (this.state is! SelectChampionsDisenchanterState) return;

    final state = this.state as SelectChampionsDisenchanterState;

    if (event.selectedLoot.count == 0) {
      // Already min count selected
      return;
    }

    final index = state.loots.indexOf(event.selectedLoot);
    final newLoots = state.loots.toList();
    newLoots[index] = event.selectedLoot.copyWith(
      count: event.selectedLoot.count - 1,
    );

    emit(state.copyWith(
      loots: newLoots,
      summary: _calcSummary(newLoots),
    ));
  }

  void _onSelectAllChampionsDisenchanterEvent(
    SelectAllChampionsDisenchanterEvent event,
    Emitter<ChampionsDisenchanterState> emit,
  ) {
    if (this.state is! SelectChampionsDisenchanterState) return;

    final state = this.state as SelectChampionsDisenchanterState;

    final newLoots = state.loots.map((e) => e.copyWith(count: e.loot.count)).toList();

    emit(state.copyWith(
      loots: newLoots,
      summary: _calcSummary(newLoots),
    ));
  }

  void _onUnselectAllChampionsDisenchanterEvent(
    UnselectAllChampionsDisenchanterEvent event,
    Emitter<ChampionsDisenchanterState> emit,
  ) {
    if (this.state is! SelectChampionsDisenchanterState) return;

    final state = this.state as SelectChampionsDisenchanterState;

    final newLoots = state.loots.map((e) => e.copyWith(count: 0)).toList();

    emit(state.copyWith(
      loots: newLoots,
      summary: _calcSummary(newLoots),
    ));
  }

  SummaryDisenchantLoot _calcSummary(List<SelectedLootCount> selectedLoots) {
    final disenchantableLoots = selectedLoots.where((element) => element.count > 0);

    return SummaryDisenchantLoot(
      totalEssence: disenchantableLoots.fold(
          0, (previousValue, element) => previousValue + element.loot.disenchantValue * element.count),
      totalCount: disenchantableLoots.fold(0, (previousValue, element) => previousValue + element.count),
    );
  }

  Future<void> _onDisenchantSelectedChampionsDisenchanterEvent(
    DisenchantSelectedChampionsDisenchanterEvent event,
    Emitter<ChampionsDisenchanterState> emit,
  ) async {
    if (this.state is! SelectChampionsDisenchanterState) return;

    final state = this.state as SelectChampionsDisenchanterState;

    final disenchantableLoots = state.loots.where((element) => element.count > 0);

    if (disenchantableLoots.isEmpty) return;

    var disenchantingState = DisenchantingChampionsDisenchanterState(
      toDisenchantEntriesCount: disenchantableLoots.length,
      completedEntriesCount: 0,
    );

    emit(disenchantingState);

    for (var loot in disenchantableLoots) {
      try {
        await _lcu.disenchantChampion(loot.loot.lootId, loot.count);
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      } finally {
        disenchantingState = disenchantingState.copyWith(
          completedEntriesCount: disenchantingState.completedEntriesCount + 1,
        );

        emit(disenchantingState);
      }
    }

    add(LoadLootChampionsDisenchanterEvent());
  }

  void _onPickedSortFieldChampionsDisenchanterEvent(
    PickedSortFieldChampionsDisenchanterEvent event,
    Emitter<ChampionsDisenchanterState> emit,
  ) {
    if (this.state is! SelectChampionsDisenchanterState) return;

    final state = this.state as SelectChampionsDisenchanterState;

    if (state.sortField == event.sortField) return;

    emit(state.copyWith(
      sortField: event.sortField,
      loots: _sortLootsByField(state.loots, event.sortField),
    ));
  }

  List<SelectedLootCount> _sortLootsByField(List<SelectedLootCount> loots, SortField sortField) {
    var sortedLoots = loots.toList();

    switch (sortField) {
      case SortField.name:
        sortedLoots.sort(((a, b) => cyrillicCompare(a.loot.itemDesc, b.loot.itemDesc)));
        break;
      case SortField.value:
        sortedLoots.sort(((a, b) => a.loot.disenchantValue.compareTo(b.loot.disenchantValue)));
        sortedLoots = sortedLoots.reversed.toList();
        break;
    }

    return sortedLoots;
  }
}
