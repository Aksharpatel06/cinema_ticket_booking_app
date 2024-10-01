import 'package:cinema_booking_app/utils/color.dart';
import 'package:cinema_booking_app/view/controller/authBloc/auth_bloc.dart';
import 'package:cinema_booking_app/view/helper/authentication_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart';
import 'package:pinput/pinput.dart';

import '../../../controller/cubit/location_cubit.dart';

List<Widget> actionWidget(
    {required BuildContext context,required AuthBloc bloc, LocationData? data}) => [
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
            BlocBuilder<LocationCubit, LocationState>(
              builder: (context, state) {
                if (state is LocationInitial) {
                  return const Center(child: Text('Initializing...'));
                } else if (state is LocationLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is LocationLoaded) {

                  return Center(
                    child:Text(
                      state.locationName,
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  );
                } else if (state is LocationError) {
                  return Center(
                    child: Text(
                      'Error: ${state.errorMessage}',
                      style: const TextStyle(fontSize: 18, color: Colors.red),
                    ),
                  );
                }
                return Container();
              },
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
  BlocConsumer<AuthBloc, AuthState>(
    listener: (context, state) {
      if (state is AuthOtpVerifiedActionState) {
        Navigator.pop(context);
      }
      if (state is AuthCodeSentState) {
        Navigator.pop(context);
        loginOtpToMobile(context, state, bloc);
      }
      if (state is AuthErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(state.error),
        ));
      }
      if(state is AuthMobileNumberChangeActionState)
        {
          Navigator.pop(context);
          loginToMobile(context, state, bloc);
        }
    },
    bloc: bloc,
    builder: (context, state) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 16.h),
        child: GestureDetector(
          onTap: () {
            if (state is AuthInitialState && AuthenticationServices.authenticationServices.currentUser()==null) {
              loginToMobile(context, state, bloc); // Trigger OTP input
            }
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
              AuthenticationServices.authenticationServices.currentUser()==null?'Log in':'Profile',
              style: TextStyle(
                color: primaryColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      );
    },
  )

];

void loginToMobile(BuildContext context, AuthState state, AuthBloc bloc) {
  TextEditingController txtPhoneNumber = TextEditingController();

  showModalBottomSheet(
    backgroundColor: backgroundColor,
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(24.r),
      ),
    ),
    builder: (context) {
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                  Column(
                    children: [
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
                        controller: txtPhoneNumber,
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
                      GestureDetector(
                        onTap: () {
                          bloc.add(SendOtpEvent(txtPhoneNumber.text));
                        },
                        child: Container(
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
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

void loginOtpToMobile(BuildContext context, AuthState state, AuthBloc bloc) {
  TextEditingController txtOtpNumber = TextEditingController();

  showModalBottomSheet(
    backgroundColor: backgroundColor,
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(24.r),
      ),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SizedBox(
          height: 300.h,
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
                SizedBox(height: 5.h),
                Column(
                  children: [
                    Text(
                      'Enter the password from the SMS',
                      style: TextStyle(
                        color: secondaryColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Pinput(
                      length: 6,
                      controller: txtOtpNumber,
                      showCursor: true,
                    ),
                    SizedBox(height: 10.h),
                    GestureDetector(
                      onTap: () {
                        if (state is AuthCodeSentState) {
                          bloc.add(VerifyOtpEvent(
                              state.verificationId, txtOtpNumber.text));
                        }
                      },
                      child: Container(
                        height: 56.h,
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          gradient: buttonColor,
                          shape: buttonRadius,
                          shadows: buttonShadow,
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    TextButton(
                      onPressed: () {
                        bloc.add(MobileNumberChangeEvent());
                      },
                      child: Text(
                        'Change number',
                        style: TextStyle(
                          color: secondaryColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Future<String> convertToName(double latitude,double longitude)
async {
  List<Placemark> placeMarks = await placemarkFromCoordinates(latitude, longitude);
  Placemark place = placeMarks[0];
  String placeName = "${place.locality}";
  return placeName;
}