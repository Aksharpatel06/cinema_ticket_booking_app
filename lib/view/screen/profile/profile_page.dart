import 'package:cinema_booking_app/utils/color.dart';
import 'package:cinema_booking_app/view/helper/authentication_services.dart';
import 'package:cinema_booking_app/view/helper/firestore_services.dart';
import 'package:cinema_booking_app/view/screen/home/home_page.dart';
import 'package:flutter/material.dart';

import '../../modal/cinema_user_modal.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        leading: BackButton(
          color: secondaryColor,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ));
          },
        ),
        title: Text(
          'Profile',
          style: TextStyle(color: secondaryColor),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                AuthenticationServices.authenticationServices.signOut();
              },
              icon: Icon(
                Icons.logout,
                color: secondaryColor,
              ))
        ],
      ),
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          _buildSavedCardsSection(),
          _buildPaymentsHistorySection(),
        ],
      ),
    );
  }
}

Widget _buildSavedCardsSection() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Saved cards',
          style: TextStyle(
            color: secondaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 12),
        _buildAddCardButton(),
      ],
    ),
  );
}

Widget _buildCardItem(String cardNumber, String expiryDate) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: Color(0xFF1E283D),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Container(
          width: 40,
          height: 40,
          child: FlutterLogo(),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            cardNumber,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
        Text(
          expiryDate,
          style: TextStyle(
            color: Color(0xFF637393),
            fontSize: 14,
          ),
        ),
      ],
    ),
  );
}

Widget _buildAddCardButton() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      border: Border.all(color: Color(0x196D9DFF)),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Center(
      child: Text(
        'Add new card',
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}

Widget _buildPaymentsHistorySection() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payments history',
          style: TextStyle(
            color: Color(0xFF637393),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 12),
        StreamBuilder(
          stream: FireStoreServices.fireStoreServices.userGetTicketBooking(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData) {
              return const Center(child: Text('No payment history', style: TextStyle(color: Colors.white)));
            }
            if (snapshot.hasError) {
              return const Center(child: Text('Error', style: TextStyle(color: Colors.white)));
            }
            List<CinemaUserModal> cinemaSeatsList = snapshot.data!.docs
                .map(
                  (e) => CinemaUserModal.fromJson(e.data() as Map),
            )
                .toList();

            return ListView.builder(itemBuilder: (context, index) {
              return _buildPaymentHistoryItem(
                cinemaSeatsList[index].movie!,
                '${cinemaSeatsList[index].date}, ${cinemaSeatsList[index].time}',
                '${cinemaSeatsList[index].cinema}',
                '${cinemaSeatsList[index].imgPath}',
              );
            },);
          },)

      ],
    ),
  );
}

Widget _buildPaymentHistoryItem(String title, String date, String location,
    String imageUrl) {
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Color(0xFF1E283D),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Container(
          width: 56,
          height: 88,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4),
              Text(
                date,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 4),
              Text(
                location,
                style: TextStyle(
                  color: Color(0xFF637393),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
