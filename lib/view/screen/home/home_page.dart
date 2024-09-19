import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        leading: Padding(
          padding: EdgeInsets.all(6.h),
          child: Image.asset(
            'asset/splash/splash_img.png',
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(14.h),
            child: Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: Color(0xff637394),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  'Nur-Sultan',
                  style: TextStyle(
                    color: Colors.white,
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
                  color: Color(0xff637394),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  'Eng',
                  style: TextStyle(
                    color: Colors.white,
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
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
