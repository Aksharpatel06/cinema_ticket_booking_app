part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

sealed class AuthActionState extends AuthState{}


final class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthMobileVerifiedActionState extends AuthActionState {}

class AuthCodeSentState extends AuthState {
  final String verificationId;

  AuthCodeSentState(this.verificationId);
}

class AuthOtpVerifiedActionState extends AuthActionState {}

class AuthMobileNumberChangeActionState extends AuthActionState {}

class AuthErrorState extends AuthState {
  final String error;

  AuthErrorState(this.error);
}


class AuthOtpVerifiedState extends AuthActionState {}