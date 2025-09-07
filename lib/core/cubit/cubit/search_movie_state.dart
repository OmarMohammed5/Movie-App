part of 'search_movie_cubit.dart';

@immutable
sealed class SearchMovieState {}

final class SearchMovieInitial extends SearchMovieState {}

final class SearchMovieLoading extends SearchMovieState {}

final class SearchMovieLoaded extends SearchMovieState {
  final List<MovieModel> movies;

  SearchMovieLoaded(this.movies);
}

final class SearchMovieEmpty extends SearchMovieState {}

final class SearchMovieError extends SearchMovieState {
  final String errorMessage;

  SearchMovieError(this.errorMessage);
}
