import 'package:cinema_booking_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

List<Widget> actionWidget =[
  Padding(
    padding: EdgeInsets.all(14.h),
    child: Row(
      children: [
         const Icon(
          Icons.location_on,
          color:secondaryColor,
        ),
        SizedBox(
          width: 10.w,
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
    padding: EdgeInsets.all(14.h),
    child: Container(
      width: 70.w,
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        gradient: const LinearGradient(
          begin: Alignment(0.00, -1.00),
          end: Alignment(0, 1),
          colors: [Color(0xFFFF8036), Color(0xFFFC6C19)],
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)),
        shadows: const [
          BoxShadow(
            color: Color(0x3FFF8036),
            blurRadius: 16,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
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
];