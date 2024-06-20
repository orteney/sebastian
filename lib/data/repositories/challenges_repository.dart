import 'package:sebastian/data/lcu/lcu.dart';
import 'package:sebastian/data/lcu/models/challenge.dart';

class ChallengesRepository {
  final LCU _lcu;

  ChallengesRepository(
    this._lcu,
  );

  List<Challenge>? _cache;

  Future<List<Challenge>> getChallenges({bool cached = true}) async {
    if (_cache != null && cached) return _cache!;

    final response = await _lcu.service.getChallenges();
    _cache = response.values.toList();
    return _cache!;
  }
}
