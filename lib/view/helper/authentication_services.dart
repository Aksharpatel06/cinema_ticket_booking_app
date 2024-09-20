import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationServices {
  static AuthenticationServices authenticationServices = AuthenticationServices._();

  AuthenticationServices._();

  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<String?> verifyPhoneNumber(String phoneNumber) async {
    String? verification;

    await _auth.verifyPhoneNumber(
      phoneNumber: "+91 $phoneNumber",
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        // Handle error
        throw e; // Throw the error to handle it in the BLoC
      },
      codeSent: (String verificationId, int? resendToken) {
        verification = verificationId; // Store verificationId
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        verification = verificationId; // Handle timeout by storing the verificationId
      },
    );

    return verification;
  }

  Future<void> verifyOtpToState(String otp,String verificationId) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId, // Use stored verificationId
      smsCode: otp,
    );
    await _auth.signInWithCredential(credential); // Sign in user
  }
}
