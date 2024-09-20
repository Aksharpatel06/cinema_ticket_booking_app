part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}


final class AuthInitialSate extends AuthState {}

class AuthLoadingState extends AuthState {}


class AuthCodeSentState extends AuthState {
  final String verificationId;

  AuthCodeSentState(this.verificationId);
}

class AuthVerifiedState extends AuthState {}

class AuthErrorState extends AuthState {
  final String error;

  AuthErrorState(this.error);
}
