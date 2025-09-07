part of 'similar_movies_cubit.dart';

@immutable
sealed class SimilarMoviesState {}

final class SimilarMoviesInitial extends SimilarMoviesState {}

final class SimilarMoviesLoading extends SimilarMoviesState {}

final class SimilarMoviesLoaded extends SimilarMoviesState {
  final List<MovieModel> similarMovies;

  SimilarMoviesLoaded(this.similarMovies);
}

final class SimilarMoviesError extends SimilarMoviesState {
  final String errorMessage;

  SimilarMoviesError(this.errorMessage);
}
