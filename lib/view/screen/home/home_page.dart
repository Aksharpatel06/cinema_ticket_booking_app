import 'package:cinema_booking_app/utils/color.dart';
import 'package:cinema_booking_app/view/controller/authBloc/auth_bloc.dart';
import 'package:cinema_booking_app/view/controller/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'componects/appbar_action.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeBloc.add(HomeInitialFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    AuthBloc authBloc = AuthBloc();
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 1,
        toolbarHeight: 75,
        leadingWidth: 60,
        leading: Padding(
          padding: EdgeInsets.only(left: 12.h, top: 8.h, bottom: 8.h),
          child: Image.asset(
            'asset/splash/splash_img.png',
          ),
        ),
        actions: actionWidget(context, authBloc),
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
                    color: primaryColor,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Icon(
                  Icons.search_rounded,
                  size: 28.h,
                  color: secondaryColor,
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 16.h),
                child: BlocConsumer<HomeBloc, HomeState>(
                  bloc: homeBloc,
                  listenWhen: (previous, current) => current is HomeActionState,
                  buildWhen: (previous, current) => current is! HomeActionState,
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is HomeFetchingLoadingState) {
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                              width: 163,
                              height: 230,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.blue, Colors.purple],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  transform: GradientRotation(
                                      0.1), // Rotate the gradient slightly
                                ),
                              ));
                        },
                      );
                    }
                    if (state is HomeFetchingSuccessfulState) {
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 290,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 20),
                        shrinkWrap: true,
                        itemCount: state.movies.length,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 163.w,
                                height: 230.h,
                                padding: EdgeInsets.all(8.h),
                                alignment: Alignment.topRight,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.r)),
                                  shadows: const [
                                    BoxShadow(
                                      color: Color(0x3F06080C),
                                      blurRadius: 40,
                                      offset: Offset(0, 16),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                                child: Container(
                                  width: 45.w,
                                  height: 30.h,
                                  alignment: Alignment.center,
                                  decoration: ShapeDecoration(
                                    gradient: buttonColor,
                                    shape: buttonRadius,
                                    shadows: buttonShadow,
                                  ),
                                  child: Text(
                                    state.movies[index].imdb.toString(),
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Text(
                                state.movies[index].movieName,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                state.movies[index].type,
                                style: TextStyle(
                                  color: secondaryColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          );
                        },
                      );
                    }
                    return SizedBox(
                      child: Center(
                        child: Text(state.toString()),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
