import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cinema_booking_app/view/helper/authentication_services.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<SendOtpEvent>(sendOtpEvent);
    on<VerifyOtpEvent>(verifyOtpEvent);
  }

  // Event to handle OTP sending
  Future<void> sendOtpEvent(SendOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());  // Emit loading state before sending OTP
    try {
      await AuthenticationServices.authenticationServices
          .verifyPhoneNumber(event.phoneNumber, emit);
      log('OTP sent to ${event.phoneNumber}');
      emit(AuthMobileVerifiedActionState());
    } catch (e) {
      emit(AuthErrorState(e.toString()));  // Emit error state in case of failure
      log('Error sending OTP: $e');
    }
  }

  // Event to handle OTP verification
  Future<void> verifyOtpEvent(VerifyOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());  // Emit loading state before verifying OTP
    try {
      await AuthenticationServices.authenticationServices
          .verifyOtpToState(event.otp, event.verificationId);
      emit(AuthOtpVerifiedActionState());
      log('OTP verified successfully');
    } catch (e) {
      emit(AuthErrorState(e.toString()));  // Emit error state in case of failure
      log('Error verifying OTP: $e');
    }
  }
}
