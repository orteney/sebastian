import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:sebastian/data/lcu/models/item_build.dart';
import 'package:sebastian/data/lcu/models/rune_page.dart';
import 'package:sebastian/data/lcu/pick_session.dart';
import 'package:sebastian/data/models/champion.dart';
import 'package:sebastian/data/models/lcu_image.dart';
import 'package:sebastian/data/repositories/champion_repository.dart';
import 'package:sebastian/data/repositories/items_repository.dart';
import 'package:sebastian/data/repositories/league_client_event_repository.dart';
import 'package:sebastian/data/repositories/perks_repository.dart';
import 'package:sebastian/data/repositories/spells_repository.dart';
import 'package:sebastian/data/senpai/models/senpai_build.dart';
import 'package:sebastian/data/senpai/senpai_data_source.dart';
import 'package:sebastian/presentation/champion_pick/bloc/champion_pick_models.dart';
import 'package:sebastian/presentation/core/bloc/bloc_mixins.dart';

part 'champion_pick_event.dart';
part 'champion_pick_state.dart';

class ChampionPickBloc extends Bloc<ChampionPickEvent, ChampionPickState> with ErrorStream {
  final int _summonerId;
  final LeagueClientEventRepository _leagueClientEventRepository;
  final SenpaiDataSource _senpaiDataSource;

  final ChampionRepository _championRepository;
  final PerksRepository _perksRepository;
  final ItemsRepository _itemsRepository;
  final SpellsRepository _spellsRepository;

  StreamSubscription? _pickSessionSubscription;

  ChampionPickBloc(
    this._summonerId,
    this._championRepository,
    this._perksRepository,
    this._itemsRepository,
    this._spellsRepository,
    this._leagueClientEventRepository,
    this._senpaiDataSource,
  ) : super(NoActiveChampionPickState()) {
    on<PickSessionUpdatedChampionPickEvent>(_onPickSessionUpdatedChampionPickEvent);
    on<TapAvailableBuildTabChampionPickEvent>(_onTapAvailableBuildTabChampionPickEvent);
    on<TapImportBuildChampionPickEvent>(_onTapImportBuildChampionPickEvent);
    on<SelectRoleChampionPickEvent>(_onSelectRoleChampionPickEvent);

    _pickSessionSubscription ??= _leagueClientEventRepository.observePickSession().listen((event) {
      add(PickSessionUpdatedChampionPickEvent(pickSession: event));
    });
  }

  Future<void> _onPickSessionUpdatedChampionPickEvent(
    PickSessionUpdatedChampionPickEvent event,
    Emitter<ChampionPickState> emit,
  ) async {
    if (event.pickSession == null) {
      return;
      //TODO
      return emit(NoActiveChampionPickState());
    }

    final pickSession = event.pickSession!;

    TeamPick? myPick;
    for (var element in pickSession.myTeam) {
      if (element.summonerId == _summonerId) {
        myPick = element;
        break;
      }
    }

    if (myPick == null || myPick.championId <= 0) {
      return emit(NoPickedChampionPickState());
    }

    final state = this.state;

    if (state is ActiveChampionPickState && myPick.championId == state.pickedChampion.id) {
      //We are looking on same pick
      return;
    }

    final champion = _championRepository.getChampion(myPick.championId);

    SenpaiBuild? build;
    Role role;

    if (pickSession.benchEnabled) {
      //Aram flow
      build = await _senpaiDataSource.fetchAramBuild(myPick.championId);
      role = Role.aram;
    } else {
      Role? assignedRole = Role.fromPosition(myPick.assignedPosition);
      try {
        build = await _senpaiDataSource.fetchRoleBuild(myPick.championId, roleId: assignedRole?.roleId);
      } catch (e) {
        // Guard: no available build for pair champion - role
        build = await _senpaiDataSource.fetchRoleBuild(myPick.championId);
      }
      role = Role.fromId(build.numMatches.roleId);
    }

    final builds = [
      build.numMatches,
      if (build.winRate != null) build.winRate!,
    ];

    emit(ActiveChampionPickState(
      pickedChampion: champion,
      role: role,
      builds: builds,
      selectedBuildIndex: 0,
      runesImages: _getPerksImages(builds),
      itemImages: _getItemImages(builds),
      summonerSpellImages: _getSummonerSpellImages(builds),
    ));
  }

  Future<void> _onSelectRoleChampionPickEvent(
    SelectRoleChampionPickEvent event,
    Emitter<ChampionPickState> emit,
  ) async {
    if (this.state is! ActiveChampionPickState) return;

    final state = this.state as ActiveChampionPickState;

    if (state.role == event.pickedRole) return;

    try {
      final build = await _senpaiDataSource.fetchRoleBuild(
        state.pickedChampion.id,
        roleId: event.pickedRole.roleId,
      );

      final builds = [
        build.numMatches,
        if (build.winRate != null) build.winRate!,
      ];

      emit(state.copyWith(
        role: event.pickedRole,
        builds: builds,
        selectedBuildIndex: 0,
        runesImages: _getPerksImages(builds),
        itemImages: _getItemImages(builds),
        summonerSpellImages: _getSummonerSpellImages(builds),
      ));
    } catch (e, stackTrace) {
      // Бывает такое, что для выбранной пары чемпион-роль нету билда
      onError('Нет сборки для этой роли :<', stackTrace);
    }
  }

  Map<int, LcuImage> _getPerksImages(List<SenpaiBuildInfo> builds) {
    final allPerks = <int>{};

    for (var build in builds) {
      allPerks
        ..addAll(build.build.runes.tree.primary)
        ..addAll(build.build.runes.tree.sub)
        ..addAll(build.build.runes.tree.stat);
    }

    return {for (var perk in allPerks) perk: _perksRepository.getImageForPerk(perk)};
  }

  Map<int, LcuImage> _getItemImages(List<SenpaiBuildInfo> builds) {
    final allItems = <int>{};

    for (var build in builds) {
      allItems
        ..addAll(build.build.startBuild)
        ..addAll(build.build.coreBuild)
        ..addAll(build.build.finalBuild)
        ..addAll(build.build.situationalItems);
    }

    final imagesMap = <int, LcuImage>{};
    for (var item in allItems) {
      final image = _itemsRepository.getImageForItem(item);
      if (image != null) imagesMap[item] = image;
    }

    return imagesMap;
  }

  Map<int, LcuImage> _getSummonerSpellImages(List<SenpaiBuildInfo> builds) {
    final allSummonerSpells = <int>{};

    for (var build in builds) {
      allSummonerSpells.addAll(build.build.spells);
    }

    return {for (var spell in allSummonerSpells) spell: _spellsRepository.getImageForSummonerSpell(spell)};
  }

  void _onTapAvailableBuildTabChampionPickEvent(
    TapAvailableBuildTabChampionPickEvent event,
    Emitter<ChampionPickState> emit,
  ) {
    if (this.state is! ActiveChampionPickState) return;
    final state = this.state as ActiveChampionPickState;
    if (state.selectedBuildIndex == event.pickedIndex) return;

    emit(state.copyWith(selectedBuildIndex: event.pickedIndex));
  }

  Future<void> _onTapImportBuildChampionPickEvent(
    TapImportBuildChampionPickEvent event,
    Emitter<ChampionPickState> emit,
  ) async {
    final state = this.state;
    if (state is! ActiveChampionPickState) return;
    if (state.builds.isEmpty) return;

    final build = state.builds[state.selectedBuildIndex].build;

    final page = RunePage(
      name: '[Sebby] ${state.pickedChampion.name}',
      primaryStyleId: build.runes.primaryPath,
      subStyleId: build.runes.subPath,
      current: true,
      selectedPerkIds: [
        ...build.runes.tree.primary,
        ...build.runes.tree.sub,
        ...build.runes.tree.stat,
      ],
    );

    _leagueClientEventRepository.setRunePage(page);

    final itemBuild = ItemBuild(
      title: '[Sebby] ${state.pickedChampion.name}',
      blocks: [
        Block(
          type: '[Sebby] Стартовые предметы',
          items: build.startBuild.map((e) => Item(count: 1, id: e.toString())).toList(),
        ),
        Block(
          type: '[Sebby] Основная сборка',
          items: build.coreBuild.map((e) => Item(count: 1, id: e.toString())).toList(),
        ),
        Block(
          type: '[Sebby] Финальная сборка',
          items: build.finalBuild.map((e) => Item(count: 1, id: e.toString())).toList(),
        ),
        Block(
          type: '[Sebby] Ситуативные предметы',
          items: build.situationalItems.map((e) => Item(count: 1, id: e.toString())).toList(),
        ),
      ],
    );

    _leagueClientEventRepository.setItemBuild(itemBuild);
  }

  @override
  Future<void> close() {
    _pickSessionSubscription?.cancel();
    return super.close();
  }
}
