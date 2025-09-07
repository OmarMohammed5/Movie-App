part of 'top_movies_cubit.dart';

@immutable
sealed class TopMoviesState {}

final class TopMoviesInitial extends TopMoviesState {}

final class TopMoviesLoadging extends TopMoviesState {}

final class TopMoviesLoaded extends TopMoviesState {
  final List<MovieModel> movies;

  TopMoviesLoaded(this.movies);
}

final class TopMoviesError extends TopMoviesState {
  final String errorMessage;

  TopMoviesError(this.errorMessage);
}
