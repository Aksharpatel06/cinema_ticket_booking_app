import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';


class AuthenticationServices {
  static AuthenticationServices authenticationServices = AuthenticationServices._();

  AuthenticationServices._();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? verifyId;

  Future<String?> verifyToPhoneNumber(String phoneNumber) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: "+91 $phoneNumber",
        verificationCompleted: (PhoneAuthCredential credential) async {
          try {
            log('success');
            await _auth.signInWithCredential(credential);
          } catch (e) {
            log(e.toString());
          }
        },
        verificationFailed: (FirebaseAuthException e) {
        },
        codeSent: (String verificationId, int? resendToken) {
          verifyId = verificationId;
          log("Code sent. Verification ID: $verificationId");
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verifyId = verificationId;
          log("Auto-retrieval timeout. Verification ID: $verificationId");
        },
      );
      return verifyId;
    } catch (e) {
      log(e.toString());
      rethrow;
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

