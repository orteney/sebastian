import 'package:shared_preferences/shared_preferences.dart';

import 'package:sebastian/data/lcu/lcu.dart';
import 'package:sebastian/data/lcu/models/challenge.dart';

class ChallengesRepository {
  final LCU _lcu;
  final SharedPreferences _sharedPreferences;

  ChallengesRepository(
    this._lcu,
    this._sharedPreferences,
  ) {
    _loadFavorites();
  }

  final _cache = <int, Challenge>{};
  final _favoriteChallenges = <int>{};

  Future<List<Challenge>> getChallenges({bool cached = true}) async {
    if (_cache.isNotEmpty && cached) return _cache.values.toList(growable: false);

    final response = await _lcu.service.getChallenges();
    for (var challenge in response.values) {
      if (_favoriteChallenges.contains(challenge.id)) {
        _cache[challenge.id] = challenge.copyWith(isFavorite: true);
      } else {
        _cache[challenge.id] = challenge;
      }
    }

    return _cache.values.toList(growable: false);
  }

  void toggleFavorite(int challengeId) {
    final challenge = _cache[challengeId];
    if (challenge == null) return;

    if (_favoriteChallenges.contains(challengeId)) {
      _favoriteChallenges.remove(challengeId);
      _cache[challengeId] = challenge.copyWith(isFavorite: false);
      _saveFavorites();
    } else {
      _favoriteChallenges.add(challengeId);
      _cache[challengeId] = challenge.copyWith(isFavorite: true);
      _saveFavorites();
    }
  }

  void _saveFavorites() {
    _sharedPreferences.setStringList('favorited_challenges', _favoriteChallenges.map((e) => e.toString()).toList());
  }

  void _loadFavorites() {
    final favoriteIds = _sharedPreferences.getStringList('favorited_challenges') ?? [];
    for (var challengeId in favoriteIds) {
      final parsedId = int.tryParse(challengeId);
      if (parsedId != null) {
        _favoriteChallenges.add(parsedId);
      }
    }
  }
}
