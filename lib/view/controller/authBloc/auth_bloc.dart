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

  Future<void> sendOtpEvent(SendOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      String? id = await AuthenticationServices.authenticationServices
          .verifyToPhoneNumber(event.phoneNumber);

      if (id != null) {
        log('OTP sent to ${event.phoneNumber} with id: $id');
        emit(AuthCodeSentState(id));
      } else {
        emit(AuthErrorState('Failed to send OTP'));
      }
    } catch (e) {
      emit(AuthErrorState(e.toString()));
      log('Error sending OTP: $e');
    }
  }

  Future<void> verifyOtpEvent(VerifyOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      await AuthenticationServices.authenticationServices
          .verifyOtpToState(event.otp, event.verificationId);
      emit(AuthOtpVerifiedActionState());
      log('OTP verified successfully');
    } catch (e) {
      emit(AuthErrorState(e.toString()));
      log('Error verifying OTP: $e');
    }
  }
}

