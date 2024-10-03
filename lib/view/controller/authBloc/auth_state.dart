part of 'auth_bloc.dart';

@immutable
sealed class AuthState extends Equatable {}

sealed class AuthActionState extends AuthState{
  @override
  List<Object> get props => [];
}


final class AuthInitialState extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoadingState extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthMobileVerifiedActionState extends AuthActionState {
}

class AuthCodeSentState extends AuthState {
  final String verificationId;

  AuthCodeSentState(this.verificationId);
  @override
  List<Object> get props => [verificationId];
}

class AuthOtpVerifiedActionState extends AuthActionState {}

class AuthMobileNumberChangeActionState extends AuthActionState {}

class AuthErrorState extends AuthState {
  final String error;

  AuthErrorState(this.error);
  @override
  List<Object> get props => [error];
}


class AuthOtpVerifiedState extends AuthActionState {}