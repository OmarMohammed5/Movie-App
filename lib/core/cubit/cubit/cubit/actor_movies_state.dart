part of 'actor_movies_cubit.dart';

@immutable
sealed class ActorMoviesState {}

final class ActorMoviesInitial extends ActorMoviesState {}

final class ActorMoviesLoading extends ActorMoviesState {}

final class ActorMoviesLoaded extends ActorMoviesState {
  final List<ActorMovieModel> movies;

  ActorMoviesLoaded(this.movies);
}

final class ActorMoviesError extends ActorMoviesState {
  final String errorMessage;

  ActorMoviesError(this.errorMessage);
}
