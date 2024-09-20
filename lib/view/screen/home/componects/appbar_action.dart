import 'package:cinema_booking_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

BuildContext? buildContext;
List<Widget> actionWidget = [
  Padding(
    padding: EdgeInsets.all(14.h),
    child: Row(
      children: [
        const Icon(
          Icons.location_on,
          color: secondaryColor,
        ),
        SizedBox(
          width: 5.w,
        ),
        Text(
          'Nur-Sultan',
          style: TextStyle(
            color: primaryColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  ),
  Padding(
    padding: EdgeInsets.all(8.h),
    child: Row(
      children: [
        const Icon(
          Icons.language,
          color: secondaryColor,
        ),
        SizedBox(
          width: 10.w,
        ),
        Text(
          'Eng',
          style: TextStyle(
            color: primaryColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  ),
  Padding(
    padding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 16.h),
    child: GestureDetector(
      onTap: () {
        showModalBottomSheet(
          backgroundColor: backgroundColor,
          context: buildContext!,
          shape: RoundedRectangleBorder(borderRadius:BorderRadius.only(topLeft: Radius.circular(16.r),topRight: Radius.circular(16.r))),
          builder: (context) {
            return BottomSheet(onClosing: () {

            }, builder: (context){
              return SizedBox(
                height: 226.h,
              );
            },);
          },
        );
      },
      child: Container(
        width: 70.w,
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          gradient: buttonColor,
          shape: buttonRadius,
          shadows :buttonShadow,
        ),
        child: Text(
          'Log in',
          style: TextStyle(
            color: primaryColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ),
  ),
];
