import 'dart:developer';

import 'package:cinema_booking_app/view/helper/authentication_services.dart';
import 'package:cinema_booking_app/view/modal/cinema_user_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreServices {
  static FireStoreServices fireStoreServices = FireStoreServices._();

  FireStoreServices._();

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  void ticketBooking(String code,String code2, CinemaUserModal cinema) {
    try{
      CollectionReference collectionReference =
      firebaseFirestore.collection('cinema');
      collectionReference.doc(code)
          .collection('seats').doc(code2)
          .set(cinema.toMap());
    }catch(e)
    {
      log(e.toString());
    }
  }

  void userTicketBooking(CinemaUserModal cinema) {
    firebaseFirestore
        .collection('user')
        .doc(AuthenticationServices.authenticationServices
            .currentUser()!
            .phoneNumber)
        .collection('user booking')
        .add(cinema.toMap());
  }
}
