import 'package:cinema_booking_app/view/modal/cinema_user_modal.dart';
import 'package:cinema_booking_app/view/screen/cinema_seats/componects/person_seat.dart';
import 'package:flutter/material.dart';

import '../../../../utils/color.dart';
import '../../../controller/cinemaBloc/cinema_booking_bloc.dart';
import '../../../modal/cinema_modal.dart';

class CategoryRow extends StatelessWidget {
  const CategoryRow({
    super.key,
    required this.category,
    required this.cinema,
    required this.list,
    required this.context,
    required this.rowCount,
    required this.prize,
    this.fullRow = false,
  });

  final String category;
  final int rowCount;
  final BuildContext context;
  final List<CinemaUserModal> list;
  final CinemaBookingBloc cinema;
  final bool fullRow;
  final Prize prize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '$category Seats (₹${category == 'Regular' ? prize.silver : category == 'Gold' ? prize.platinum : prize.gold})',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        const SizedBox(height: 8),
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
                    return CategorySeat(
                        seatNum: seatIndex,
                        category: category,
                        list: list,
                        cinema: cinema,
                        context: context);
                  })
                      : [
                    ...List.generate(3, (seatIndex) {
                      int index = rowIndex * 11 + seatIndex;
                      return CategorySeat(
                          seatNum: index,
                          category: category,
                          list: list,
                          cinema: cinema,
                          context: context);
                    }),
                    const SizedBox(width: 30),
                    ...List.generate(5, (seatIndex) {
                      int index = rowIndex * 11 + seatIndex + 3;
                      return CategorySeat(
                          seatNum: index,
                          category: category,
                          list: list,
                          cinema: cinema,
                          context: context);
                    }),
                    const SizedBox(width: 30),
                    ...List.generate(3, (seatIndex) {
                      int index = rowIndex * 11 + seatIndex + 8;
                      return CategorySeat(
                          seatNum: index,
                          category: category,
                          list: list,
                          cinema: cinema,
                          context: context);
                    }),
                  ],
                ),
              );
            })),
      ],
    );
  }
}
