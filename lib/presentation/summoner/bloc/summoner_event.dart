part of 'summoner_bloc.dart';

abstract class SummonerEvent {}

class UpdatedSummonerEvent extends SummonerEvent {
  final Summoner summoner;

  UpdatedSummonerEvent({required this.summoner});
}
