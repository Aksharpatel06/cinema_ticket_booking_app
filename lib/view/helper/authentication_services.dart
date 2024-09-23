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
            log('Verification completed. Signing in...');
            await _auth.signInWithCredential(credential);
            log('Sign-in success!');
          } catch (e) {
            log('Error during sign-in: ${e.toString()}');
          }
        },

        // Handles the case where phone verification fails
        verificationFailed: (FirebaseAuthException e) {
          log('Verification failed: ${e.code} - ${e.message}');
          log('Verification failed: $phoneNumber - ${e.message}');
          if (e.code == 'invalid-phone-number') {
            log('The provided phone number is invalid.');
          } else if (e.code == 'quota-exceeded') {
            log('SMS quota exceeded. Try again later.');
          } else if (e.code == 'billing-not-enabled') {
            log('Billing is not enabled in your Firebase project.');
          } else {
            log('Unknown error: ${e.code}');
          }
        },

        // Called when the verification code is successfully sent
        codeSent: (String verificationId, int? resendToken) {
          verifyId = verificationId;
          log("Code sent. Verification ID: $verificationId");
        },

        // Called when the auto-retrieval has timed out
        codeAutoRetrievalTimeout: (String verificationId) {
          verifyId = verificationId;
          log("Auto-retrieval timeout. Verification ID: $verificationId");
        },
      );
      return verifyId;
    } catch (e) {
      log('Error occurred: ${e.toString()}');
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

