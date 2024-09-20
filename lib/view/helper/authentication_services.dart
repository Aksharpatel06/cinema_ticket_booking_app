import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationServices {
  String _verificationId = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void verifyPhoneNumber() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: "+91 ",
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        // User signed in successfully
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
}
