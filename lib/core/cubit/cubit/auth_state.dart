part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthLoaded extends AuthState {
  final String uid;
  final String email;
  final String name;

  AuthLoaded({required this.uid, required this.email, required this.name});
}

final class AuthLoggedOut extends AuthState {}

final class AuthError extends AuthState {
  final String errorMessage;

  AuthError(this.errorMessage);
}
