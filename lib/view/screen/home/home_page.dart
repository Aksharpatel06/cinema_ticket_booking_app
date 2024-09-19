import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'componects/appbar_action.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1a2232),
      appBar: AppBar(
        backgroundColor: const Color(0xff1d273a),
        elevation: 1,
        toolbarHeight: 75,
        leadingWidth: 60,
        leading: Padding(
          padding: EdgeInsets.only(left: 12.h,top: 8.h,bottom: 8.h),
          child: Image.asset(
            'asset/splash/splash_img.png',
          ),
        ),
        actions: actionWidget,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Now in cinemas',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Icon(
                  Icons.search_rounded,
                  size: 28.h,
                  color: Color(0xff637394),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
