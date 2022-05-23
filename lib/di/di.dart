import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:champmastery/data/lcu.dart';
import 'package:champmastery/data/lcu_store.dart';
import 'package:champmastery/data/repositories/champion_repository.dart';
import 'package:champmastery/data/repositories/league_client_event_repository.dart';
import 'package:champmastery/data/repositories/summoner_repository.dart';

GetIt getIt = GetIt.instance;

Future<void> initDi() async {
  getIt.registerSingleton<SharedPreferences>(await SharedPreferences.getInstance());

  getIt.registerFactory<LcuStore>(() => LcuStore(getIt()));

  getIt.registerLazySingleton<LCU>(() => LCU(getIt()));
  getIt.registerLazySingleton<SummonerRepository>(() => SummonerRepository(lcu: getIt()));
  getIt.registerLazySingleton<ChampionRepository>(() => ChampionRepository(lcu: getIt()));
  getIt.registerLazySingleton<LeagueClientEventRepository>(() => LeagueClientEventRepository(getIt()));
}
