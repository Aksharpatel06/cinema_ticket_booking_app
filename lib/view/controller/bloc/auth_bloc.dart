import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cinema_booking_app/view/helper/authentication_services.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialSate()) {
    on<SendOtpEvent>(sendOtpEvent);
    on<VerifyOtpEvent>(verifyOtpEvent);
  }

  Future<void> sendOtpEvent(SendOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      await Future.delayed(const Duration(seconds: 2));
      AuthenticationServices.authenticationServices
          .verifyPhoneNumber(event.phoneNumber);
      emit(AuthVerifiedState());
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  Future<void> verifyOtpEvent(
      VerifyOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      await Future.delayed(const Duration(seconds: 2));
      AuthenticationServices.authenticationServices.verifyOtpToState(event.otp, event.verificationId);
      emit(AuthCodeSentState(event.verificationId));
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }
}
