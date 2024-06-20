part of 'challenges_bloc.dart';

@immutable
sealed class ChallengesState {}

class LoadingChallengesState extends ChallengesState {}

class LoadedChallengesState extends ChallengesState with EquatableMixin {
  final List<Challenge> challenges;

  LoadedChallengesState({
    required this.challenges,
  });

  LoadedChallengesState copyWith({
    List<Challenge>? challenges,
  }) {
    return LoadedChallengesState(
      challenges: challenges ?? this.challenges,
    );
  }

  @override
  List<Object> get props => [challenges];
}
