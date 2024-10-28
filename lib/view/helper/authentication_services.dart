import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';


class AuthenticationServices {
  static AuthenticationServices authenticationServices = AuthenticationServices._();

  AuthenticationServices._();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? verifyId;

  Future<String?> verifyToPhoneNumber(String phoneNumber) async {
    try {
      log('Starting phone number verification for +91 $phoneNumber');

      await _auth.verifyPhoneNumber(
        phoneNumber: "+91 $phoneNumber",
        verificationCompleted: (PhoneAuthCredential credential) async {
          try {
            log('Verification completed for +91 $phoneNumber. Signing in...');
            await _auth.signInWithCredential(credential);
            log('Sign-in successful for +91 $phoneNumber');
          } catch (e) {
            log('Error during sign-in for +91 $phoneNumber: ${e.toString()}');
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          log('Verification failed for +91 $phoneNumber: ${e.code} - ${e.message}');

          // Handle specific error cases
          if (e.code == 'invalid-phone-number') {
            log('Invalid phone number: +91 $phoneNumber');
          } else if (e.code == 'quota-exceeded') {
            log('SMS quota exceeded for +91 $phoneNumber.');
          } else if (e.code == 'billing-not-enabled') {
            log('Billing is not enabled in the Firebase project.');
          } else {
            log('Unknown error during verification: ${e.code}');
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          verifyId = verificationId;
          log('Code sent to +91 $phoneNumber. Verification ID: $verificationId');
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verifyId = verificationId;
          log('Auto-retrieval timed out for +91 $phoneNumber. Verification ID: $verificationId');
        },
      );

      return verifyId;
    } catch (e) {
      log('Error occurred during phone verification: ${e.toString()}');
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
      currentUser();

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

  void signOut()  {
     _auth.signOut();
  }
}

