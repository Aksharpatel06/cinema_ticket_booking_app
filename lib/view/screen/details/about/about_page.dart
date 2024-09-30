import 'package:cinema_booking_app/view/modal/movie_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/color.dart';
import 'componects/movie_trailer.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({
    super.key,
    required this.modal,
  });

  final MovieModal modal;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              MovieTrailer(videoUrl: Uri.parse(modal.video),),
              Container(
                width: double.infinity,
                height: 70.h,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.00, -1.00),
                    end: Alignment(0, 1),
                    colors: [Color(0x001E283D), Color(0xFF1E283D)],
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / 2 - 8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            modal.imdb.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            'IMDB',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: secondaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              height: 0.09,
                            ),
                          ),
                          SizedBox(height: 5.h),
                        ],
                      ),
                    ),
                    const VerticalDivider(
                      color: Color(0x196D9DFF),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / 2 - 8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            modal.kino.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            'Kinopoisk',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: secondaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
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
              Padding(
                padding: EdgeInsets.all(16.h),
                child: Column(
                  children: [
                    Text(
                      modal.description,
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: Row(
                        children: [
                          Text(
                            'Certificate',
                            style: TextStyle(
                              color: secondaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            width: 20.h,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.h, vertical: 4.h),
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 1, color: Color(0x196D9DFF)),
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            ),
                            child: Text(
                              modal.certificate,
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: Row(
                        children: [
                          Text(
                            'Runtime',
                            style: TextStyle(
                              color: secondaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            width: 35.h,
                          ),
                          Text(
                            modal.runtime,
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: Row(
                        children: [
                          Text(
                            'Release',
                            style: TextStyle(
                              color: secondaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            width: 38.h,
                          ),
                          Text(
                            modal.release.toString(),
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: Row(
                        children: [
                          Text(
                            'Genre',
                            style: TextStyle(
                              color: secondaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            width: 52.h,
                          ),
                          Text(
                            modal.genre,
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: Row(
                        children: [
                          Text(
                            'Director',
                            style: TextStyle(
                              color: secondaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            width: 37.h,
                          ),
                          Text(
                            modal.director,
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 88.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cast',
                            style: TextStyle(
                              color: secondaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            width: 62.h,
                          ),
                          SizedBox(
                            width: 235.h,
                            child: Text(
                              modal.cast,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            height: 88.h,
            padding: EdgeInsets.all(16.h),
            color: const Color(0xB21E283D),
            child: Container(
              width: 343.h,
              height: 56.h,
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                  gradient: buttonColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r)),
                  shadows: buttonShadow),
              child: const Text(
                'Select session',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
