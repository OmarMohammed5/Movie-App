part of 'movie_cubit.dart';

@immutable
sealed class MovieState {}

final class MovieInitial extends MovieState {}

final class MovieLoading extends MovieState {}

final class MovieLoaded extends MovieState {
  final List<MovieModel> movies;

  MovieLoaded(this.movies);
}

final class MovieError extends MovieState {
  final String errorMessage;

  MovieError(this.errorMessage);
}
