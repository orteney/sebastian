import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
import 'package:sebastian/domain/core/role.dart';
import 'package:sebastian/presentation/champion_pick/bloc/champion_pick_models.dart';
import 'package:sebastian/presentation/core/bloc/bloc_mixins.dart';

part 'champion_pick_event.dart';
part 'champion_pick_state.dart';

class ChampionPickBloc extends Bloc<ChampionPickEvent, ChampionPickState> with ErrorStream, StreamSubscriptions {
  final int _summonerId;
  final LeagueClientEventRepository _leagueClientEventRepository;

  final ChampionRepository _championRepository;
  final PerksRepository _perksRepository;
  final ItemsRepository _itemsRepository;
  final SpellsRepository _spellsRepository;
  final BuildRepository _buildRepository;

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
    on<GameEndEventChampionPickEvent>(_onGameEndEventChampionPickEvent);

    _leagueClientEventRepository
        .observePickSession()
        .listen((event) => add(PickSessionUpdatedChampionPickEvent(pickSession: event)))
        .addTo(subscriptions);

    _leagueClientEventRepository
        .observeGameEndEvent()
        .listen((event) => add(GameEndEventChampionPickEvent()))
        .addTo(subscriptions);
  }

  Future<void> _onPickSessionUpdatedChampionPickEvent(
    PickSessionUpdatedChampionPickEvent event,
    Emitter<ChampionPickState> emit,
  ) async {
    if (event.pickSession == null) {
      if (this.state is NoPickedChampionPickState) {
        return emit(NoActiveChampionPickState());
      }

      // Continue display current build until current game ends
      return;
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
    Role? previousRole;
    if (state is ActiveChampionPickState) {
      if (championId == state.pickedChampion.id) {
        //We are looking on same pick
        return;
      }

      previousRole = state.role;
    }

    final champion = _championRepository.getChampion(championId);
    if (champion == null) return;

    Builds builds;
    if (pickSession.benchEnabled) {
      //Aram flow
      builds = await _buildRepository.getAramBuilds(champion.id);
    } else {
      builds = await _buildRepository.getBuilds(
        champion.id,
        role: previousRole ?? myPick?.assignedPosition?.role,
      );
    }

    emit(ActiveChampionPickState(
      pickedChampion: champion,
      splashImage: _championRepository.getSplashImage(champion.id),
      role: builds.role,
      builds: builds.builds,
      selectedBuildIndex: 0,
      selectedPerkStyle: PerkStyle.fromId(builds.builds[0].runes.primaryPath),
      runesImages: _getPerksImages(builds.builds),
      itemImages: _getItemImages(builds.builds),
      summonerSpellImages: _getSummonerSpellImages(builds.builds),
    ));
  }

  Future<void> _onSelectRoleChampionPickEvent(
    SelectRoleChampionPickEvent event,
    Emitter<ChampionPickState> emit,
  ) async {
    if (this.state is! ActiveChampionPickState) return;

    final state = this.state as ActiveChampionPickState;

    if (state.role == event.pickedRole) return;

    final builds = await _buildRepository.getBuilds(
      state.pickedChampion.id,
      role: event.pickedRole,
    );

    emit(state.copyWith(
      role: builds.role,
      builds: builds.builds,
      selectedBuildIndex: 0,
      selectedPerkStyle: PerkStyle.fromId(builds.builds[0].runes.primaryPath),
      runesImages: _getPerksImages(builds.builds),
      itemImages: _getItemImages(builds.builds),
      summonerSpellImages: _getSummonerSpellImages(builds.builds),
    ));
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
    _leagueClientEventRepository.setItemBuild(name, build.itemBuild, event.appLocalizations);
  }

  void _onGameEndEventChampionPickEvent(
    GameEndEventChampionPickEvent event,
    Emitter<ChampionPickState> emit,
  ) {
    if (state is ActiveChampionPickState) {
      emit(NoActiveChampionPickState());
    }
  }
}
