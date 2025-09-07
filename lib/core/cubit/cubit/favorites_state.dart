part of 'favorites_cubit.dart';

@immutable
sealed class FavoritesState {}

final class FavoritesInitial extends FavoritesState {}

final class FavoritesLoading extends FavoritesState {}

final class FavoritesLoaded extends FavoritesState {
  final List<Map<String, dynamic>> favorites;

  FavoritesLoaded(this.favorites);
}

final class FavoritesError extends FavoritesState {
  final String errorMessage;

  FavoritesError(this.errorMessage);
}
