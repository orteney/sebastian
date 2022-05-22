import 'package:champmastery/data/lcu.dart';
import 'package:champmastery/data/models/summoner.dart';

class SummonerRepository {
  final LCU lcu;

  SummonerRepository({
    required this.lcu,
  });

  Summoner? _cachedSummoner;

  Future<Summoner> getCurrentSummoner() async {
    if (_cachedSummoner == null) {
      final summoner = await lcu.getCurrentSummoner();
      final chestEligibility = await lcu.getChestEligibility();

      _cachedSummoner = summoner.copyWith(chestEligibility: chestEligibility);
    }

    return _cachedSummoner!;
  }
}
