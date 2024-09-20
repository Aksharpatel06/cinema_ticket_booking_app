import 'package:cinema_booking_app/view/screen/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final width =MediaQuery.sizeOf(context).width;
    final heigth = MediaQuery.sizeOf(context).height;
    return ScreenUtilInit(
      designSize: Size(
          width, heigth),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashPage(),
        theme: ThemeData(fontFamily: 'Nunito'),
      ),
    );
  }
}
