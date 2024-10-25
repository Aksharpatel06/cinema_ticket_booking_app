import 'dart:developer';
import 'package:cinema_booking_app/view/controller/cinemaBloc/cinema_booking_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/color.dart';

class CinemaSeatsPage extends StatelessWidget {
  const CinemaSeatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    CinemaBookingBloc cinemaBookingBloc = CinemaBookingBloc();
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        toolbarHeight: 80,
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, 50),
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
                      Icon(
                        Icons.access_time_filled,
                        color: secondaryColor,
                      ),
                      Text(
                        '  15:10',
                        style: TextStyle(fontSize: 16, color: primaryColor),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        leading: BackButton(
          color: secondaryColor,
        ),
        title: Column(
          children: [
            Text(
              'Cinema Ticket',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
            ),
            Text(
              'Cinema',
              style: TextStyle(
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
                  child: BlocConsumer<CinemaBookingBloc, CinemaBookingState>(
                    bloc: cinemaBookingBloc,
                    listener: (context, state) {},
                    builder: (context, state) {
                      return Column(
                        children: [
                          buildCategoryRow('Regular', 3, context,
                              state.regularSeats, cinemaBookingBloc),
                          buildCategoryRow('Gold', 5, context, state.goldSeats,
                              cinemaBookingBloc),
                          buildCategoryRow('Platinum', 1, context,
                              state.platinumSeats, cinemaBookingBloc,
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
                return FloatingActionButton.extended(
                  onPressed: () {

                  },
                  label: Text(
                      "Buy $totalSeats tickets in \$${calculateTotalPrice(state)}"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategoryRow(String category, int rowCount, BuildContext context,
      List<bool> list, CinemaBookingBloc cinema,
      {bool fullRow = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '$category Seats (\$${category == 'Regular' ? 10 : category == 'Gold' ? 15 : 20})',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: 8),
        Column(
            children: List.generate(rowCount, (rowIndex) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: fullRow
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceAround,
              children: fullRow
                  ? List.generate(11, (seatIndex) {
                      return buildSeat(
                          seatIndex, category, list, cinema, context);
                    })
                  : [
                      ...List.generate(3, (seatIndex) {
                        int index = rowIndex * 11 + seatIndex;
                        return buildSeat(
                            index, category, list, cinema, context);
                      }),
                      SizedBox(width: 30),
                      ...List.generate(5, (seatIndex) {
                        int index = rowIndex * 11 + seatIndex + 3;
                        return buildSeat(
                            index, category, list, cinema, context);
                      }),
                      SizedBox(width: 30),
                      ...List.generate(3, (seatIndex) {
                        int index = rowIndex * 11 + seatIndex + 8;
                        return buildSeat(
                            index, category, list, cinema, context);
                      }),
                    ],
            ),
          );
        })),
      ],
    );
  }

  Widget buildSeat(int seatNum, String category, List<bool> list,
      CinemaBookingBloc cinema, BuildContext context) {
    bool isSelected = list[seatNum];
    Color seatColor = isSelected ? appBarColor : Colors.grey.shade300;

    return GestureDetector(
      onTap: () {
        log(seatNum.toString());
        cinema.add(ToggleSeatSelection(seatNum, category));
        log(seatNum.toString());
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: seatColor,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.black26, width: 1),
        ),
        child: Icon(
          Icons.chair,
          color: isSelected ? Colors.white : Colors.black54,
          size: 20,
        ),
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
