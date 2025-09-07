part of 'filter_cubit.dart';

@immutable
sealed class FilterState {}

final class FilterInitial extends FilterState {}

final class FilterLoading extends FilterState {}

final class FilterLoaded extends FilterState {
  final List<MovieModel> movies;

  FilterLoaded(this.movies);
}

final class FilterError extends FilterState {
  final String errorMessage;

  FilterError(this.errorMessage);
}
