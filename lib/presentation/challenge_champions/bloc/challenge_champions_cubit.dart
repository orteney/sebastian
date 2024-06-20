import 'package:bloc/bloc.dart';

import 'package:sebastian/data/models/champion.dart';
import 'package:sebastian/data/repositories/champion_repository.dart';

part 'challenge_champions_models.dart';

class ChallengeChampionsCubit extends Cubit<List<ChallengeChampionsModel>> {
  final List<int> availableChampions;
  final List<int> completeChampions;
  final ChampionRepository _championRepository;

  ChallengeChampionsCubit(
    this.availableChampions,
    this.completeChampions,
    this._championRepository,
  ) : super([]) {
    _loadChampions();
  }

  void _loadChampions() {
    Iterable<Champion> champions = _championRepository.champions;

    if (availableChampions.isNotEmpty) {
      champions = champions.where((element) => availableChampions.contains(element.id));
    }

    final models = champions
        .map(
          (e) => ChallengeChampionsModel(
            name: e.name,
            completed: completeChampions.contains(e.id),
          ),
        )
        .toList();

    emit(models);
  }
}
