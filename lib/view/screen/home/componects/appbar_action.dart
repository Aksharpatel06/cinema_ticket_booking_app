import 'package:cinema_booking_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

List<Widget> actionWidget(BuildContext context) => [
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
            loginToMobile(context);
          },
          child: Container(
            width: 70.w,
            alignment: Alignment.center,
            decoration: ShapeDecoration(
              gradient: buttonColor,
              shape: buttonRadius,
              shadows: buttonShadow,
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

void loginToMobile(BuildContext context)
{
  showModalBottomSheet(
    backgroundColor: backgroundColor,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(24.r),),),
    builder: (context) {
      return Padding(
        padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SizedBox(
          height: 235.h,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Text(
                  'Login',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  'Access to purchased tickets',
                  style: TextStyle(
                    color: secondaryColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                TextField(
                  style: const TextStyle(
                    color: primaryColor,
                  ),
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: secondaryColor, width: 0.8),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    hintText: 'Phone Number',
                    hintStyle: const TextStyle(
                      color: secondaryColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  height: 56.h,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    gradient: buttonColor,
                    shape: buttonRadius,
                    shadows: buttonShadow,
                  ),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}