import 'package:sebastian/data/repositories/items_repository.dart';
import 'package:sebastian/data/repositories/perks_repository.dart';
import 'package:sebastian/data/repositories/spells_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sebastian/data/lcu/lcu.dart';
import 'package:sebastian/data/lcu/lcu_path_storage.dart';
import 'package:sebastian/data/repositories/champion_repository.dart';
import 'package:sebastian/data/repositories/league_client_event_repository.dart';
import 'package:sebastian/data/repositories/summoner_repository.dart';
import 'package:sebastian/data/senpai/senpai_data_source.dart';

GetIt getIt = GetIt.instance;

Future<void> initDi() async {
  getIt.registerSingleton<SharedPreferences>(await SharedPreferences.getInstance());

  getIt.registerFactory<LcuPathStorage>(() => LcuPathStorage(getIt()));

  getIt.registerLazySingleton<LCU>(() => LCU(getIt()));

  getIt.registerLazySingleton<SummonerRepository>(() => SummonerRepository(lcu: getIt()));
  getIt.registerLazySingleton<ChampionRepository>(() => ChampionRepository(lcu: getIt()));
  getIt.registerLazySingleton<PerksRepository>(() => PerksRepository(getIt()));
  getIt.registerLazySingleton<ItemsRepository>(() => ItemsRepository(getIt()));
  getIt.registerLazySingleton<SpellsRepository>(() => SpellsRepository(getIt()));
  getIt.registerLazySingleton<LeagueClientEventRepository>(() => LeagueClientEventRepository(getIt()));

  getIt.registerFactory(() => SenpaiDataSource());
}
