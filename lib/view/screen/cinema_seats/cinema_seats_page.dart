import 'package:cinema_booking_app/view/controller/cinemaBloc/cinema_booking_bloc.dart';
import 'package:cinema_booking_app/view/helper/firestore_services.dart';
import 'package:cinema_booking_app/view/modal/cinema_modal.dart';
import 'package:cinema_booking_app/view/modal/cinema_user_modal.dart';
import 'package:cinema_booking_app/view/modal/movie_modal.dart';
import 'package:cinema_booking_app/view/screen/payment/payment_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/color.dart';
import 'componects/category_row_details.dart';

class CinemaSeatsPage extends StatelessWidget {
  const CinemaSeatsPage(
      {super.key,
      required this.cinema,
      required this.movieModal,
      required this.prize,
      required this.index,
      required this.dateTime});

  final Cinema cinema;
  final MovieModal movieModal;
  final int index;
  final DateTime dateTime;
  final Prize prize;

  @override
  Widget build(BuildContext context) {
    CinemaBookingBloc cinemaBookingBloc = CinemaBookingBloc();
    String code =
        '${movieModal.movieName}${cinema.cinema}${dateTime.day}${dateTime.month}${cinema.data[index].time}';
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        toolbarHeight: 80,
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 50),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 45.h,
                  width: 160.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: secondaryColor, width: 0.8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.calendar_month,
                        color: secondaryColor,
                      ),
                      Text(
                        '${intToMonthString(dateTime.month)}, ${dateTime.day}',
                        style:
                            const TextStyle(fontSize: 16, color: primaryColor),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 45.h,
                  width: 160.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: secondaryColor, width: 0.8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.access_time_filled,
                        color: secondaryColor,
                      ),
                      Text(
                        cinema.data[index].time,
                        style:
                            const TextStyle(fontSize: 16, color: primaryColor),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        leading: const BackButton(
          color: secondaryColor,
        ),
        title: Column(
          children: [
            Text(
              movieModal.movieName,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
            ),
            Text(
              movieModal.type,
              style: const TextStyle(
                  color: secondaryColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 16),
            ),
          ],
        ),
        backgroundColor: appBarColor,
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FireStoreServices.fireStoreServices.seatsDataGet(code),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }

          List<CinemaUserModal> cinemaSeatsList = snapshot.data!.docs
              .map(
                (e) => CinemaUserModal.fromJson(e.data() as Map),
              )
              .toList();

          return BlocBuilder<CinemaBookingBloc, CinemaBookingState>(
            bloc: cinemaBookingBloc,
            builder: (context, state) {
              int totalSeats = state.totalSeats.length;

              for (int i = 0; i < cinemaSeatsList.length; i++) {
                if (cinemaSeatsList[i].category == 'Gold') {
                  state.goldSeats[cinemaSeatsList[i].index] =
                      cinemaSeatsList[i];
                } else if (cinemaSeatsList[i].category == 'Regular') {
                  state.regularSeats[cinemaSeatsList[i].index] =
                      cinemaSeatsList[i];
                } else if (cinemaSeatsList[i].category == 'Platinum') {
                  state.platinumSeats[cinemaSeatsList[i].index] =
                      cinemaSeatsList[i];
                }
              }

              List<List<CinemaUserModal>> data = listConvert(state);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomPaint(
                    painter: CurvePainter(),
                    child: Container(
                      height: 100,
                      width: 700,
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              CategoryRow(
                                  category: 'Regular',
                                  prize: prize,
                                  rowCount: 3,
                                  context: context,
                                  list: state.regularSeats,
                                  cinema: cinemaBookingBloc),
                              CategoryRow(
                                  category: 'Gold',
                                  prize: prize,
                                  rowCount: 5,
                                  context: context,
                                  list: state.goldSeats,
                                  cinema: cinemaBookingBloc),
                              CategoryRow(
                                  category: 'Platinum',
                                  prize: prize,
                                  rowCount: 1,
                                  context: context,
                                  list: state.platinumSeats,
                                  cinema: cinemaBookingBloc,
                                  fullRow: true),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaymentScreen(
                                    cinema: cinema,
                                    dataList: state.totalSeats,
                                    total: calculateTotalPrice(state, prize),
                                    movieModal: movieModal,
                                    index: index,
                                    cinemaTiming: cinema.data[index].time,
                                    dateTime: dateTime),
                              ));
                        },
                        child: Container(
                          width: double.infinity,
                          height: 88.h,
                          padding: EdgeInsets.all(16.h),
                          color: const Color(0xB21E283D),
                          child: Container(
                            width: 343.h,
                            height: 56.h,
                            alignment: Alignment.center,
                            decoration: ShapeDecoration(
                                gradient: buttonColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.r)),
                                shadows: buttonShadow),
                            child: Text(
                              'Buy $totalSeats tickets • \$ ${calculateTotalPrice(state, prize)}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  String intToMonthString(int month) {
    const monthNames = [
      "Jan",
      "Feb",
      "March",
      "April",
      "May",
      "June",
      "July",
      "Aug",
      "Sept",
      "Oct",
      "Nov",
      "Dec"
    ];

    // Adjust for zero-based index
    if (month < 1 || month > 12) {
      return "Invalid month";
    }
    return monthNames[month - 1];
  }

  int calculateTotalPrice(CinemaBookingState state, Prize prize) {
    int total = 0;

    for(int i=0;i<state.totalSeats.length;i++)
      {
        if (state.totalSeats[i].category == 'Gold') {
          total+=prize.platinum;
        } else if (state.totalSeats[i].category == 'Regular') {
          total+=prize.silver;
        } else if (state.totalSeats[i].category == 'Platinum') {
          total+=prize.gold;
        }
      }


    return total;
  }

  List<List<CinemaUserModal>> listConvert(CinemaBookingState state) {
    List<CinemaUserModal> userBookingRegularModal = [];
    List<CinemaUserModal> userBookingGoldModal = [];
    List<CinemaUserModal> userBookingPlatinumModal = [];
    for (int i = 0; i < state.regularSeats.length; i++) {
      if (state.regularSeats[i].value) {
        CinemaUserModal cinemaUserModal = CinemaUserModal(
            category: 'Regular', index: i, value: true, amount: prize.silver);
        userBookingRegularModal.add(cinemaUserModal);
      }
    }
    for (int i = 0; i < state.goldSeats.length; i++) {
      if (state.goldSeats[i].value) {
        CinemaUserModal cinemaUserModal = CinemaUserModal(
            category: 'Gold', index: i, value: true, amount: prize.platinum);
        userBookingGoldModal.add(cinemaUserModal);
      }
    }

    for (int i = 0; i < state.platinumSeats.length; i++) {
      if (state.platinumSeats[i].value) {
        CinemaUserModal cinemaUserModal = CinemaUserModal(
            category: 'Platinum', index: i, value: true, amount: prize.gold);
        userBookingPlatinumModal.add(cinemaUserModal);
      }
    }
    List<List<CinemaUserModal>> data = [
      userBookingRegularModal,
      userBookingGoldModal,
      userBookingPlatinumModal,
    ];

    return data;
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();

    paint.color = const Color(0xffe1e1e1);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 3;

    var startPoint = Offset(0, size.height / 2);
    var controlPoint1 = Offset(size.width / 4, size.height / 5);
    var controlPoint2 = Offset(3 * size.width / 4, size.height / 5);
    var endPoint = Offset(size.width, size.height / 2);

    var path = Path();
    path.moveTo(startPoint.dx, startPoint.dy);
    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
        controlPoint2.dy, endPoint.dx, endPoint.dy);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
