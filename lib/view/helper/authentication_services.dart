import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../controller/authBloc/auth_bloc.dart';

class AuthenticationServices {
  static AuthenticationServices authenticationServices = AuthenticationServices._();

  AuthenticationServices._();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> verifyPhoneNumber(String phoneNumber, Emitter<AuthState> emit) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: "+91 $phoneNumber",
        verificationCompleted: (PhoneAuthCredential credential) async {
          try {
            await _auth.signInWithCredential(credential);
            log('success');
            emit(AuthOtpVerifiedActionState());
          } catch (e) {
            log(e.toString());
            emit(AuthErrorState(e.toString()));
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          emit(AuthErrorState(e.message ?? "Verification failed"));
        },
        codeSent: (String verificationId, int? resendToken) {
          emit(AuthCodeSentState(verificationId));
          log("Code sent. Verification ID: $verificationId");
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          emit(AuthCodeSentState(verificationId));
          log("Auto-retrieval timeout. Verification ID: $verificationId");
        },
      );
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  Future<void> verifyOtpToState(String otp, String verificationId) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );
      await _auth.signInWithCredential(credential);
    } catch (e) {
      throw FirebaseAuthException(
        message: e.toString(),
        code: 'OTP_Verification_Failed',
      );
    }
  }

  User? currentUser() {
    return _auth.currentUser;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}

