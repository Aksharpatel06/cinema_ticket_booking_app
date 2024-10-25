import 'package:cinema_booking_app/view/screen/cinema_seats/componects/person_seat.dart';
import 'package:flutter/material.dart';

import '../../../../utils/color.dart';
import '../../../controller/cinemaBloc/cinema_booking_bloc.dart';

class CategoryRow extends StatelessWidget {
  const CategoryRow({
    super.key,
    required this.category,
    required this.cinema,
    required this.list,
    required this.context,
    required this.rowCount,
    this.fullRow = false,
  });

  final String category;
  final int rowCount;
  final BuildContext context;
  final List<bool> list;
  final CinemaBookingBloc cinema;
  final bool fullRow;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '$category Seats (\$${category == 'Regular' ? 10 : category == 'Gold' ? 15 : 20})',
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
