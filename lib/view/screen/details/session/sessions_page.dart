import 'package:cinema_booking_app/view/modal/movie_modal.dart';
import 'package:cinema_booking_app/view/screen/cinema_seats/cinema_seats_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/color.dart';
import '../../../controller/datePickerCubit/date_picker_cubit.dart';
import '../../../controller/locationCubit/location_cubit.dart';


class SessionsPage extends StatelessWidget {
  const SessionsPage({
    super.key,
    required this.movieModal,
  });

  final MovieModal movieModal;

  @override
  Widget build(BuildContext context) {
    final LocationCubit locationCubit = context.read<LocationCubit>();
    final DatePickerCubit datePickerCubit = context.read<DatePickerCubit>();
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 70.h,
          decoration: const BoxDecoration(
            color: appBarColor,
            gradient: LinearGradient(
              begin: Alignment(0.00, -1.00),
              end: Alignment(0, 1),
              colors: [Color(0x001E283D), Color(0xFF1E283D)],
            ),
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    barrierColor: secondaryColor,
                    lastDate: DateTime(2024, DateTime.november, 15),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: appBarColor, // Header background color
                            onPrimary: primaryColor,
                            onSurface: backgroundColor,
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              foregroundColor: secondaryColor, // Button text color
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (pickedDate != null) {
                    datePickerCubit.pickDate(pickedDate);
                  }
                },
                child: SizedBox(
                  width: MediaQuery
                      .sizeOf(context)
                      .width / 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Icon(
                        Icons.calendar_month,
                        color: secondaryColor,
                        size: 25.h,
                      ),
                      const Spacer(),
                      BlocBuilder<DatePickerCubit, DateTime>(
                        bloc: datePickerCubit,
                        builder: (context, state) {
                          String intToMonthString(int month) {
                            const monthNames = [
                              "Jan", "Feb", "March", "April", "May", "June",
                              "July", "Aug", "Sept", "Oct", "Nov", "Dec"
                            ];

                            // Adjust for zero-based index
                            if (month < 1 || month > 12) {
                              return "Invalid month";
                            }
                            return monthNames[month - 1];
                          }

                          return Text(
                            '${intToMonthString(state.month)}, ${state.day}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              height: 0.09,
                            ),
                          );
                        },
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery
                    .sizeOf(context)
                    .width / 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Icon(
                      Icons.access_time_outlined,
                      color: secondaryColor,
                      size: 25.h,
                    ),
                    const Spacer(),
                    Text(
                      'Time ↑',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        height: 0.09,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery
                    .sizeOf(context)
                    .width / 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 35.h,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Switch(
                          value: false,
                          materialTapTargetSize:
                          MaterialTapTargetSize.shrinkWrap,
                          onChanged: (value) {},
                          inactiveThumbColor: secondaryColor,
                          activeColor: primaryColor,
                          activeTrackColor: const Color(0xffFC6D19),
                          inactiveTrackColor: const Color(0xff253554),
                          trackOutlineWidth: const WidgetStatePropertyAll(0),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'By cinema',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        height: 0.09,
                      ),
                    ),
                    SizedBox(height: 5.h),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(2),
          color: const Color(0xff253554),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Time',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: secondaryColor,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                width: 20.h,
              ),
              Text(
                'Silver',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: secondaryColor,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                'Gold',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: secondaryColor,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                'Platinum',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: secondaryColor,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: BlocBuilder<LocationCubit, LocationState>(
            builder: (context, state) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: locationCubit.cinemaList.length,
                itemBuilder: (context, index) =>
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 20.h, right: 20.h, top: 12.h, bottom: 7.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text(
                                    locationCubit.cinemaList[index].cinema,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_pin,
                                        color: secondaryColor,
                                      ),
                                      Text(
                                        '${locationCubit.cinemaList[index].km
                                            .toStringAsFixed(1)} Km',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: secondaryColor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Text(
                                locationCubit.cinemaList[index].area,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: secondaryColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          color: secondaryColor,
                          thickness: 0.5,
                        ),
                        Column(
                            children: List.generate(
                              locationCubit.cinemaList[index].data.length,
                                  (index2) =>
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CinemaSeatsPage(
                                                  cinema: locationCubit
                                                      .cinemaList[index],
                                                  movieModal: movieModal,
                                                  index: index2,
                                                  dateTime: datePickerCubit
                                                      .state,
                                                  prize: locationCubit
                                                      .cinemaList[index]
                                                      .data[index2].prize,
                                                ),
                                          ));
                                    },
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 50,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.h,
                                                vertical: 10.h),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  width: 70.w,
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    locationCubit
                                                        .cinemaList[index]
                                                        .data[index2].time,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: primaryColor,
                                                      fontSize: 16.sp,
                                                      fontWeight: FontWeight
                                                          .w500,
                                                    ),
                                                  ),
                                                ),
                                                const VerticalDivider(
                                                  color: secondaryColor,
                                                  thickness: 0.5,
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  '₹ ${locationCubit
                                                      .cinemaList[index]
                                                      .data[index2].prize
                                                      .silver}',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: secondaryColor,
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  '₹ ${locationCubit
                                                      .cinemaList[index]
                                                      .data[index2].prize
                                                      .platinum}',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: secondaryColor,
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 30.h),
                                                  child: Text(
                                                    '₹ ${locationCubit
                                                        .cinemaList[index]
                                                        .data[index2].prize
                                                        .gold}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: secondaryColor,
                                                      fontSize: 14.sp,
                                                      fontWeight: FontWeight
                                                          .w700,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const Divider(
                                          color: secondaryColor,
                                          thickness: 0.5,
                                        ),
                                      ],
                                    ),
                                  ),
                            ))
                      ],
                    ),
              );
            },
          ),
        )
      ],
    );
  }
}
