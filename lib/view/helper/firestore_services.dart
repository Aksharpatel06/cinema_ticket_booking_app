import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreServices{
  static FireStoreServices fireStoreServices = FireStoreServices._();
  FireStoreServices._();

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  void ticketBooking()
  {
    // firebaseFirestore.collection('')
  }
}