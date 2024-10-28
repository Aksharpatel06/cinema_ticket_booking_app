import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../helper/authentication_services.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());

  String verificationCode = '';

  void checkAuthentication() {
    final currentUser = AuthenticationServices.authenticationServices.currentUser();
    if (currentUser != null) {
      emit(PaymentCompleted()); // Directly go to PaymentCompleted if user is logged in
    }
  }

  void sendOtp(String phoneNumber) async {
    // emit(PaymentProcessing());
    try {
      verificationCode = await AuthenticationServices.authenticationServices
              .verifyToPhoneNumber(phoneNumber) ??
          '';
      if (verificationCode != '') {
        emit(PaymentOtpSent());
      }
    } catch (error) {
      emit(PaymentError("Failed to send OTP"));
    }
  }

  void verifyOtp(String otp) {
    try {
      AuthenticationServices.authenticationServices
          .verifyOtpToState(otp, verificationCode);
      emit(PaymentOtpVerified());
    } catch (e) {
      emit(PaymentError("Invalid OTP"));
      emit(PaymentOtpVerified());
    }
  }

  void changeNumber()
  {
    emit(PaymentInitial());
  }
}
