

import 'package:cinema_booking_app/view/modal/cinema_user_modal.dart';
import 'package:flutter/material.dart';

import '../../../../utils/color.dart';
import '../../../controller/cinemaBloc/cinema_booking_bloc.dart';

class CategorySeat extends StatelessWidget {
  const CategorySeat({
    super.key,
    required this.seatNum,
    required this.category,
    required this.list,
    required this.cinema,
    required this.context,
  });

  final int seatNum;
  final String category;
  final List<CinemaUserModal> list;
  final CinemaBookingBloc cinema;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    bool isSelected = list[seatNum].value;
    Color seatColor = isSelected ? appBarColor : Colors.grey.shade300;

    return GestureDetector(
      onTap: () {
        if(list[seatNum].category==category && list[seatNum].index==seatNum && list[seatNum].user==null)
          {
            cinema.add(ToggleSeatSelection(seatNum, category));
          }
      },

      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
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
}