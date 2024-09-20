import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const appBarColor = Color(0xff1d273a);
const backgroundColor =  Color(0xff1a2232);


// text and icon color
const primaryColor = Colors.white;
const secondaryColor =  Color(0xff637394);

// button color
const buttonColor =LinearGradient(
  begin: Alignment(0.00, -1.00),
  end: Alignment(0, 1),
  colors: [Color(0xFFFF8036), Color(0xFFFC6C19)],
);
const buttonShadow = [
  BoxShadow(
    color: Color(0x3FFF8036),
    blurRadius: 16,
    offset: Offset(0, 4),
    spreadRadius: 0,
  )
];
var buttonRadius = RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r));