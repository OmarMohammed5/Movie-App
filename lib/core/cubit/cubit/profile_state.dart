part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final String name;
  final String email;

  ProfileLoaded({required this.name, required this.email});
}

final class ProfileError extends ProfileState {
  final String errorMessage;
  ProfileError(this.errorMessage);
}
