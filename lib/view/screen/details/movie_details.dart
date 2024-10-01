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
                                    Spacer(),
                                    Icon(
                                      Icons.calendar_month,
                                      color: secondaryColor,
                                      size: 25.h,
                                    ),
                                    Spacer(),
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
                                    Spacer(),
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
                                    Spacer(),
                                    Icon(
                                      Icons.add,
                                      color: secondaryColor,
                                      size: 25.h,
                                    ),
                                    Spacer(),
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
                                    Spacer(),
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
