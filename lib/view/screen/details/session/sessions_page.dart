import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/color.dart';
import '../../../controller/cubit/location_cubit.dart';

class SessionsPage extends StatelessWidget {
  const SessionsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
              SizedBox(
                width: MediaQuery.sizeOf(context).width / 3,
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
                    Text(
                      'Oct, ${DateTime.now().day}',
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
                width: MediaQuery.sizeOf(context).width / 3,
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
                width: MediaQuery.sizeOf(context).width / 3,
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
          padding: EdgeInsets.all(2),
          color: Color(0xff253554),
          child: Row(
            children: [
              Spacer(
                flex: 1,
              ),
              Text(
                'Time',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: secondaryColor,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Spacer(
                flex: 2,
              ),
              Text(
                'Prize',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: secondaryColor,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Spacer(
                flex: 5,
              ),
            ],
          ),
        ),
        BlocConsumer<LocationCubit, LocationState>(
          listener: (context, state) {},
          builder: (context, state) {
            log(state.toString());
            if (state is CinemaLoadedSuccess) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.cinemaList.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.h, vertical: 12.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                state.cinemaList[index].cinema,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_pin,
                                    color: secondaryColor,
                                  ),
                                  Text(
                                    '${state.cinemaList[index].km} Km',
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
                            state.cinemaList[index].area,
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
                    Divider(
                      color: secondaryColor,
                      thickness: 0.5,
                    ),
                    SizedBox(
                      height: 60,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.h, vertical: 10.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              state.cinemaList[index].data[0].time,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            VerticalDivider(
                              color: secondaryColor,
                              thickness: 0.5,
                            ),
                            Spacer(),
                            Text(
                              '\$ ${state.cinemaList[index].data[0].prize}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: secondaryColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Spacer(),
                            Spacer(),
                            Spacer(),
                            Spacer(),
                            Spacer(),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      color: secondaryColor,
                      thickness: 0.5,
                    ),
                  ],
                ),
              );
            }
            if (state is LocationError) {
              return Center(
                child: Text(
                  'Error: ${state.errorMessage}',
                  style: const TextStyle(fontSize: 18, color: Colors.red),
                ),
              );
            }
            return Container();
          },
        )
      ],
    );
  }
}
