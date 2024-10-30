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
      emit(PaymentCompleted());
    }else{
      emit(PaymentInitial());
    }
  }

  void sendOtp(String phoneNumber) async {
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
      emit(PaymentCompleted());
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
