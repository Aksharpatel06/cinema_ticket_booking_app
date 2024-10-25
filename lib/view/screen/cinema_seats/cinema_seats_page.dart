import 'dart:developer';
import 'package:cinema_booking_app/view/controller/cinemaBloc/cinema_booking_bloc.dart';
import 'package:cinema_booking_app/view/modal/cinema_modal.dart';
import 'package:cinema_booking_app/view/modal/movie_modal.dart';
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
      required this.index});

  final Cinema cinema;
  final MovieModal movieModal;
  final int index;

  @override
  Widget build(BuildContext context) {
    CinemaBookingBloc cinemaBookingBloc = CinemaBookingBloc();
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
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: secondaryColor,
                      ),
                      Text(
                        '  April 14',
                        style: TextStyle(fontSize: 16, color: primaryColor),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomPaint(
            painter: CurvePainter(),
            child: Container(
              height: 100,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: BlocBuilder<CinemaBookingBloc, CinemaBookingState>(
                    bloc: cinemaBookingBloc,
                    builder: (context, state) {
                      return Column(
                        children: [
                          CategoryRow(
                              category: 'Regular',
                              rowCount: 3,
                              context: context,
                              list: state.regularSeats,
                              cinema: cinemaBookingBloc),
                          CategoryRow(
                              category: 'Gold',
                              rowCount: 5,
                              context: context,
                              list: state.goldSeats,
                              cinema: cinemaBookingBloc),
                          CategoryRow(
                              category: 'Platinum',
                              rowCount: 1,
                              context: context,
                              list: state.platinumSeats,
                              cinema: cinemaBookingBloc,
                              fullRow: true),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<CinemaBookingBloc, CinemaBookingState>(
              bloc: cinemaBookingBloc,
              builder: (context, state) {
                int totalSeats =
                    state.regularSeats.where((seat) => seat).length +
                        state.goldSeats.where((seat) => seat).length +
                        state.platinumSeats.where((seat) => seat).length;
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {},
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
                          'Buy $totalSeats tickets • \$ ${calculateTotalPrice(state)}',
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  int calculateTotalPrice(CinemaBookingState state) {
    int total = 0;

    for (int i = 0; i < state.regularSeats.length; i++) {
      if (state.regularSeats[i]) total += 10;
    }

    for (int i = 0; i < state.goldSeats.length; i++) {
      if (state.goldSeats[i]) total += 15;
    }

    for (int i = 0; i < state.platinumSeats.length; i++) {
      if (state.platinumSeats[i]) total += 20;
    }

    return total;
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

