import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:sebastian/data/lcu/pick_session.dart';
import 'package:sebastian/data/models/champion.dart';
import 'package:sebastian/data/models/lcu_image.dart';
import 'package:sebastian/data/repositories/build_repository.dart';
import 'package:sebastian/data/repositories/champion_repository.dart';
import 'package:sebastian/data/repositories/items_repository.dart';
import 'package:sebastian/data/repositories/league_client_event_repository.dart';
import 'package:sebastian/data/repositories/perks_repository.dart';
import 'package:sebastian/data/repositories/spells_repository.dart';
import 'package:sebastian/domain/builds/build_info.dart';
import 'package:sebastian/presentation/champion_pick/bloc/champion_pick_models.dart';
import 'package:sebastian/presentation/core/bloc/bloc_mixins.dart';

part 'champion_pick_event.dart';
part 'champion_pick_state.dart';

class ChampionPickBloc extends Bloc<ChampionPickEvent, ChampionPickState> with ErrorStream {
  final int _summonerId;
  final LeagueClientEventRepository _leagueClientEventRepository;

  final ChampionRepository _championRepository;
  final PerksRepository _perksRepository;
  final ItemsRepository _itemsRepository;
  final SpellsRepository _spellsRepository;
  final BuildRepository _buildRepository;

  StreamSubscription? _pickSessionSubscription;

  ChampionPickBloc(
    this._summonerId,
    this._championRepository,
    this._perksRepository,
    this._itemsRepository,
    this._spellsRepository,
    this._leagueClientEventRepository,
    this._buildRepository,
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

    final championId = ((myPick?.championId ?? 0) > 0) ? myPick?.championId : myPick?.championPickIntent;
    if (championId == null || championId <= 0) {
      return emit(NoPickedChampionPickState());
    }

    final state = this.state;
    if (state is ActiveChampionPickState && championId == state.pickedChampion.id) {
      //We are looking on same pick
      return;
    }

    final champion = _championRepository.getChampion(championId);

    List<BuildInfo>? builds;
    Role role;

    if (pickSession.benchEnabled || pickSession.isCustomGame) {
      //Aram flow
      builds = await _buildRepository.getAramBuilds(champion.id);
      role = Role.aram;
    } else {
      Role? assignedRole = Role.fromPosition(myPick!.assignedPosition);
      builds = await _buildRepository.getBuilds(champion.id, roleId: assignedRole?.roleId);
      role = Role.fromId(builds.first.roleId);
    }

    emit(ActiveChampionPickState(
      pickedChampion: champion,
      splashImage: _championRepository.getSplashImage(champion.id),
      role: role,
      builds: builds,
      selectedBuildIndex: 0,
      selectedPerkStyle: PerkStyle.fromId(builds[0].runes.primaryPath),
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
      final builds = await _buildRepository.getBuilds(
        state.pickedChampion.id,
        roleId: event.pickedRole.roleId,
      );

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

  Map<int, LcuImage> _getPerksImages(List<BuildInfo> builds) {
    final allPerks = <int>{};

    for (var build in builds) {
      allPerks
        ..addAll(build.runes.primary)
        ..addAll(build.runes.sub)
        ..addAll(build.runes.stat);
    }

    return {for (var perk in allPerks) perk: _perksRepository.getImageForPerk(perk)};
  }

  Map<int, LcuImage> _getItemImages(List<BuildInfo> builds) {
    final allItems = <int>{};

    for (var build in builds) {
      allItems
        ..addAll(build.itemBuild.startBuild)
        ..addAll(build.itemBuild.coreBuild)
        ..addAll(build.itemBuild.finalBuild)
        ..addAll(build.itemBuild.situationalItems);
    }

    final imagesMap = <int, LcuImage>{};
    for (var item in allItems) {
      final image = _itemsRepository.getImageForItem(item);
      if (image != null) imagesMap[item] = image;
    }

    return imagesMap;
  }

  Map<int, LcuImage> _getSummonerSpellImages(List<BuildInfo> builds) {
    final allSummonerSpells = <int>{};

    for (var build in builds) {
      allSummonerSpells.addAll(build.summonerSpells);
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

    emit(state.copyWith(
      selectedBuildIndex: event.pickedIndex,
      selectedPerkStyle: PerkStyle.fromId(state.builds[event.pickedIndex].runes.primaryPath),
    ));
  }

  Future<void> _onTapImportBuildChampionPickEvent(
    TapImportBuildChampionPickEvent event,
    Emitter<ChampionPickState> emit,
  ) async {
    final state = this.state;
    if (state is! ActiveChampionPickState) return;
    if (state.builds.isEmpty) return;

    final build = state.builds[state.selectedBuildIndex];

    final name = '[Sebby] ${state.pickedChampion.name}';
    _leagueClientEventRepository.setRunePage(name, build.runes);
    _leagueClientEventRepository.setItemBuild(name, build.itemBuild);
  }

  @override
  Future<void> close() {
    _pickSessionSubscription?.cancel();
    return super.close();
  }
}
