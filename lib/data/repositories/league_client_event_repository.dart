import 'dart:async';

import 'package:rxdart/rxdart.dart';

import 'package:sebastian/data/lcu/lcu.dart';
import 'package:sebastian/data/lcu/models/item_build.dart' as lcu;
import 'package:sebastian/data/lcu/models/lcu_error.dart';
import 'package:sebastian/data/lcu/models/ready_check_event.dart';
import 'package:sebastian/data/lcu/models/rune_page.dart';
import 'package:sebastian/data/lcu/pick_session.dart';
import 'package:sebastian/domain/builds/build_info.dart';

class LeagueClientEventRepository {
  final LCU _lcu;

  LeagueClientEventRepository(this._lcu);

  final _pickSessionSubject = BehaviorSubject<PickSession?>.seeded(null);
  final _endGameSubject = PublishSubject<bool>();
  final _readyCheckSubject = PublishSubject<ReadyCheckEvent>();

  StreamSubscription? _pickSessionSubcription;
  StreamSubscription? _endGameSubscription;
  StreamSubscription? _readyCheckSubscription;

  Stream<PickSession?> observePickSession() {
    _pickSessionSubcription ??= _lcu
        .subscribeToChampSelectEvent()
        .map(_parsePickSessionEvent)
        .listen((event) => _pickSessionSubject.add(event));

    return _pickSessionSubject.stream;
  }

  PickSession? _parsePickSessionEvent(dynamic eventMessage) {
    if (eventMessage == null) return null;

    if (eventMessage['eventType'] == 'Delete') return null;

    final data = eventMessage['data'];
    if (data == null) return null;

    return PickSession.fromJson(data);
  }

  Stream<dynamic> observeGameEndEvent() {
    _endGameSubscription ??= _lcu.subscribeToEndOfGameEvent().listen((event) {
      if (event['data'] == 'PreEndOfGame') {
        _endGameSubject.add(true);
      }
    });

    return _endGameSubject.stream;
  }

  Stream<ReadyCheckEvent> observeReadyCheckEvent() {
    _readyCheckSubscription ??= _lcu.subscribeToReadyCheckEvent().listen((event) {
      if (event['eventType'] != 'Update') return;

      final readyCheckEvent = ReadyCheckEvent.fromJson(event['data']);
      _readyCheckSubject.add(readyCheckEvent);
    });

    return _readyCheckSubject.stream;
  }

  Future<void> setRunePage(String pageName, Runes runes) async {
    final page = RunePage(
      name: pageName,
      primaryStyleId: runes.primaryPath,
      subStyleId: runes.subPath,
      current: true,
      selectedPerkIds: [
        ...runes.primary,
        ...runes.sub,
        ...runes.stat,
      ],
    );

    try {
      final currentPage = await _lcu.service.getCurrentRunePage();
      if ((currentPage['name'] as String).startsWith('[Sebby]')) {
        await _lcu.service.deleteRunePage(currentPage['id']);
      }
      await _lcu.service.postRunePage(page);
    } on LcuError catch (error) {
      if (error.message == 'Max pages reached') {
        final currentPage = await _lcu.service.getCurrentRunePage();
        await _lcu.service.deleteRunePage(currentPage['id']);
        await _lcu.service.postRunePage(page);
      } else {
        rethrow;
      }
    }
  }

  Future<void> setItemBuild(String buildName, ItemBuild build) async {
    final lcuBuild = lcu.ItemBuild(
      title: buildName,
      blocks: [
        lcu.Block(
          type: '[Sebby] Стартовые предметы',
          items: build.startBuild.map((e) => lcu.Item(count: 1, id: e.toString())).toList(),
        ),
        lcu.Block(
          type: '[Sebby] Основная сборка',
          items: build.coreBuild.map((e) => lcu.Item(count: 1, id: e.toString())).toList(),
        ),
        lcu.Block(
          type: '[Sebby] Финальная сборка',
          items: build.finalBuild.map((e) => lcu.Item(count: 1, id: e.toString())).toList(),
        ),
        lcu.Block(
          type: '[Sebby] Ситуативные предметы',
          items: build.situationalItems.map((e) => lcu.Item(count: 1, id: e.toString())).toList(),
        ),
      ],
    );

    _clearUpgradableItems(lcuBuild);
    await _lcu.saveBuildFile(lcuBuild);
  }

  /// Some items in builds appears in their final form which cannot be bought from the store
  /// so we shound replace them with
  void _clearUpgradableItems(lcu.ItemBuild build) {
    for (var block in build.blocks) {
      for (var i = 0; i < block.items.length; i++) {
        final dowgradeItemId = _downgradeItemsMap[block.items[i].id];
        if (dowgradeItemId != null) {
          block.items[i] = block.items[i].copyWith(id: dowgradeItemId);
        }
      }
    }
  }

  static const _downgradeItemsMap = {
    '3040': '3003', // Seraph's Embrace        -> Achangel's Staff
    '3042': '3004', // Muramana                -> Manamune
    '3121': '3042', // Fimbulwinter            -> Winter's Approach
    '3851': '3850', // Frostfang               -> Spellthief's Edge
    '3853': '3850', // Shard of True Ice       -> Spellthief's Edge
    '3855': '3854', // Runesteel Spaulders     -> Steel Shoulderguards
    '3857': '3854', // Pauldrons of Whiterock  -> Steel Shoulderguards
    '3859': '3858', // Targon's Buckler        -> Relic Shield
    '3860': '3858', // Bulwark of the Mountain -> Relic Shield
    '3863': '3862', // Harrowing Crescent      -> Spectral Sickle
    '3864': '3862', // Black Mist Scythe       -> Spectral Sickle
  };
}
