import 'package:sebastian/data/lcu/lcu.dart';
import 'package:sebastian/data/models/summoner.dart';
import 'package:rxdart/subjects.dart';

class SummonerRepository {
  final LCU lcu;

  SummonerRepository({
    required this.lcu,
  });

  final _summonerSubject = BehaviorSubject<Summoner>();

  Future<Summoner> getCurrentSummoner() async {
    final dto = await lcu.service.getCurrentSummoner();
    final chestEligibility = await lcu.service.getChestEligibility();

    final updatedSummoner = Summoner(
      accountId: dto.accountId,
      displayName: dto.displayName,
      summonerId: dto.summonerId,
      summonerLevel: dto.summonerLevel,
      xpSinceLastLevel: dto.xpSinceLastLevel,
      xpUntilNextLevel: dto.xpUntilNextLevel,
      chestEligibility: chestEligibility,
    );

    _summonerSubject.add(updatedSummoner);

    return updatedSummoner;
  }

  Stream<Summoner> stream() => _summonerSubject.stream;

  Summoner? load() => _summonerSubject.valueOrNull;
}
