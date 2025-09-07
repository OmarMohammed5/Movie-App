part of 'movie_trailer_cubit.dart';

@immutable
sealed class MovieTrailerState {}

final class MovieTrailerInitial extends MovieTrailerState {}

final class MovieTrailerLoading extends MovieTrailerState {}

final class MovieTrailerLoaded extends MovieTrailerState {
  final List<MovieTrailer> videos;

  MovieTrailerLoaded(this.videos);
}

final class MovieTrailerError extends MovieTrailerState {
  final String errorMessage;

  MovieTrailerError(this.errorMessage);
}
