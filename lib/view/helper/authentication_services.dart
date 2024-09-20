import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationServices {
  static AuthenticationServices authenticationServices =
      AuthenticationServices._();

  AuthenticationServices._();

  String _verificationId = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void verifyPhoneNumber(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: "+91 $phoneNumber",
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        // Handle error
      },
      codeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  void verifyOtpToState(String otp,String verificationId) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: otp,
    );
    await _auth.signInWithCredential(credential);
  }
}
