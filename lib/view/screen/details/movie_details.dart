import 'package:cinema_booking_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controller/movie_bloc/home_bloc.dart';
import 'about/about_page.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({
    super.key,
    required this.homeBloc,
  });

  final HomeBloc homeBloc;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {},
      bloc: homeBloc,
      builder: (context, state) {
        if (state is HomeAdditionSuccessState) {
          return DefaultTabController(
            length: 2,
            animationDuration: const Duration(milliseconds: 700),
            initialIndex: 0,
            child: Scaffold(
              backgroundColor: backgroundColor,
              appBar: AppBar(
                backgroundColor: appBarColor,
                leading: const BackButton(
                  color: secondaryColor,
                ),
                centerTitle: true,
                title: Text(
                  state.movieModal.movieName,
                  style: const TextStyle(color: primaryColor),
                ),
                bottom: const TabBar(
                  indicatorColor: Color(0xFFFC6C19),
                  labelColor: Color(0xFFFC6C19),
                  labelStyle: TextStyle(
                    shadows: buttonShadow,
                  ),
                  indicatorWeight: 3,
                  unselectedLabelColor: secondaryColor,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: [
                    Tab(
                      text: 'About',
                    ),
                    Tab(
                      text: 'Sessions',
                    ),
                  ],
                ),
              ),
              body: SafeArea(
                child: TabBarView(
                  children: [
                    AboutPage(
                      modal: state.movieModal,
                    ),
                    Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 70.h,
                          decoration: const BoxDecoration(
                            color: appBarColor,
                            gradient: LinearGradient(
                              begin: Alignment(0.00, -1.00),
                              end: Alignment(0, 1),
                              colors: [Color(0x001E283D), Color(0xFF1E283D)],
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width:
                                    MediaQuery.sizeOf(context).width / 3 ,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Spacer(),
                                    Icon(
                                      Icons.calendar_month,
                                      color: secondaryColor,
                                      size: 25.h,
                                    ),
                                    const Spacer(),
                                    Text(
                                      'Oct, ${DateTime.now().day}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w700,
                                        height: 0.09,
                                      ),
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.sizeOf(context).width / 3 ,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Spacer(),
                                    Icon(
                                      Icons.access_time_outlined,
                                      color: secondaryColor,
                                      size: 25.h,
                                    ),
                                    const Spacer(),
                                    Text(
                                      'Time ↑',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w700,
                                        height: 0.09,
                                      ),
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.sizeOf(context).width / 3 ,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 35.h,
                                      child: FittedBox(
                                        fit: BoxFit.fill,
                                        child: Switch(
                                          value: false,
                                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          onChanged: (value) {},
                                          inactiveThumbColor: secondaryColor,
                                          activeColor: primaryColor,
                                          activeTrackColor: const Color(0xffFC6D19),
                                          inactiveTrackColor: const Color(0xff253554),
                                          trackOutlineWidth:
                                              const WidgetStatePropertyAll(0),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    Text(
                                      'By cinema',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w700,
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
                        Container(
                          padding: EdgeInsets.all(2),
                          color: Color(0xff253554),
                          child: Row(
                            children: [
                              Spacer(flex: 1,),
                              Text(
                                'Time',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: secondaryColor,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Spacer(flex: 2,),
                              Text(
                                'Prize',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: secondaryColor,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Spacer(flex: 5,),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 20.h,vertical: 10.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Cinema',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: primaryColor,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.location_pin,color: secondaryColor,),
                                          Text(
                                            '3 Km',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: secondaryColor,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Text(
                                    'Area',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: secondaryColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: secondaryColor,
                              thickness: 0.5,
                            ),
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 20.h,vertical: 10.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    '14:00',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  VerticalDivider(
                                    color: secondaryColor,
                                    thickness: 0.5,
                                  ),
                                  Text(
                                    '\$ 500',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: secondaryColor,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),

                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }
        return const Scaffold();
      },
    );
  }
}
