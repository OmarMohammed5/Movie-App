part of 'geners_cubit.dart';

@immutable
sealed class GenersState {}

final class GenersInitial extends GenersState {}

final class GenersLoading extends GenersState {}

final class GenersLoaded extends GenersState {
  final List<GenerModel> geners;
  final int selectedIndex;

  GenersLoaded(this.geners, this.selectedIndex);
}

final class GenersError extends GenersState {
  final String errorMessage;

  GenersError(this.errorMessage);
}
