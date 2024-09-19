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
        leading: Padding(
          padding: EdgeInsets.all(6.h),
          child: Image.asset(
            'asset/splash/splash_img.png',
          ),
        ),
        actions: actionWidget,
      ),
    );
  }
}
