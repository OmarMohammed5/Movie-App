part of 'cast_cubit.dart';

@immutable
sealed class CastState {}

final class CastInitial extends CastState {}

final class CastLoading extends CastState {}

final class CastLoaded extends CastState {
  final List<CastModel> castModel;

  CastLoaded(this.castModel);
}

final class CastError extends CastState {
  final String errorMessage;

  CastError(this.errorMessage);
}
