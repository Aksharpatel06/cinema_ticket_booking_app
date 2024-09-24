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
            SizedBox(
              height: 500,
              child: BlocConsumer<HomeBloc, HomeState>(
                listenWhen: (previous, current) => current is HomeActionState,
                buildWhen: (previous, current) => current is! HomeActionState,
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is HomeFetchingLoadingState) {
                    return ListView.builder(
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
                                transform: GradientRotation(0.1), // Rotate the gradient slightly
                              ),
                            )

                        );
                      },
                    );
                  }
                  if (state is HomeFetchingSuccessfulState) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.movies.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              width: 163.w,
                              height: 230.h,
                              decoration: ShapeDecoration(
                                image: const DecorationImage(
                                  image: NetworkImage(
                                      "https://via.placeholder.com/163x230"),
                                  fit: BoxFit.fill,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                shadows: const [
                                  BoxShadow(
                                    color: Color(0x3F06080C),
                                    blurRadius: 40,
                                    offset: Offset(0, 16),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 40,
                              child: Column(
                                children: [
                                  Text(
                                    state.movies[index].movieName,
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    state.movies[index].type,
                                    style: TextStyle(
                                      color: secondaryColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    );
                  }
                  return  SizedBox(
                    child: Center(
                      child: Text(state.toString()),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
