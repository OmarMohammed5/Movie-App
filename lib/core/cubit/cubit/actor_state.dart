part of 'actor_cubit.dart';

@immutable
sealed class ActorState {}

final class ActorInitial extends ActorState {}

final class ActorLoading extends ActorState {}

final class ActorLoaded extends ActorState {
  final ActorModel actors;

  ActorLoaded(this.actors);
}

final class ActorError extends ActorState {
  final String errorMessage;

  ActorError(this.errorMessage);
}
