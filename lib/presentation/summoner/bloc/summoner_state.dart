part of 'summoner_bloc.dart';

class SummonerState {
  final Summoner? summoner;

  SummonerState({
    required this.summoner,
  });

  SummonerState copyWith({
    Summoner? summoner,
  }) {
    return SummonerState(
      summoner: summoner ?? this.summoner,
    );
  }

  @override
  String toString() => 'SummonerState(summoner: $summoner)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SummonerState && other.summoner == summoner;
  }

  @override
  int get hashCode => summoner.hashCode;
}
