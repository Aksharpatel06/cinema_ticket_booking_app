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
      String? id = await AuthenticationServices.authenticationServices
          .verifyPhoneNumber(
          event.phoneNumber);
      emit(AuthCodeSentState(id!)); // Emit verificationId after it's sent
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  Future<void> verifyOtpEvent(
      VerifyOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      await AuthenticationServices.authenticationServices
          .verifyOtpToState(event.otp, event.verificationId);
      emit(AuthVerifiedState()); // Emit verified state when OTP is verified
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }
}
