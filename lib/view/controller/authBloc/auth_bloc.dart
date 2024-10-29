import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cinema_booking_app/view/helper/authentication_services.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<SendOtpEvent>(sendOtpEvent);
    on<VerifyOtpEvent>(verifyOtpEvent);
    on<MobileNumberChangeEvent>(mobileNumberChangeEvent);
    on<CheckAuthenticationEvent>(checkAuthentication);
  }




  Future<void> sendOtpEvent(SendOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      String? id = await AuthenticationServices.authenticationServices
          .verifyToPhoneNumber(event.phoneNumber);

      if (id != null) {
        emit(AuthCodeSentState(id));
      } else {
        emit(AuthErrorState('Failed to send OTP'));
        emit(AuthInitialState());
      }
    } catch (e) {
      emit(AuthErrorState(e.toString()));
      emit(AuthInitialState());
    }
  }

  Future<void> verifyOtpEvent(
      VerifyOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      await AuthenticationServices.authenticationServices
          .verifyOtpToState(event.otp, event.verificationId);
      emit(AuthOtpVerifiedActionState());
      emit(AuthOtpVerifiedState());
    } catch (e) {
      emit(AuthErrorState(e.toString()));
      emit(AuthInitialState());
    }
  }

  FutureOr<void> mobileNumberChangeEvent(
      MobileNumberChangeEvent event, Emitter<AuthState> emit) {
    emit(AuthMobileNumberChangeActionState());
  }

  FutureOr<void> checkAuthentication(event, Emitter<AuthState> emit) {
    final currentUser = AuthenticationServices.authenticationServices.currentUser();
    if (currentUser != null) {
      emit(AuthOtpVerifiedState());
    }else{
      emit(AuthInitialState());
    }
  }
}
