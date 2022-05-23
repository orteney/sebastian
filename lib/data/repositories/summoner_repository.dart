import 'package:champmastery/data/lcu.dart';
import 'package:champmastery/data/models/summoner.dart';
import 'package:rxdart/subjects.dart';

class SummonerRepository {
  final LCU lcu;

  SummonerRepository({
    required this.lcu,
  });

  final _summonerSubject = BehaviorSubject<Summoner>();

  Future<Summoner> getCurrentSummoner() async {
    final summoner = await lcu.getCurrentSummoner();
    final chestEligibility = await lcu.getChestEligibility();

    final updatedSummoner = summoner.copyWith(chestEligibility: chestEligibility);

    _summonerSubject.add(updatedSummoner);

    return updatedSummoner;
  }

  Stream<Summoner> stream() => _summonerSubject.stream;

  Summoner? load() => _summonerSubject.valueOrNull;
}
