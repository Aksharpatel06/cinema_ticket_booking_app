import 'package:cinema_booking_app/view/controller/authBloc/auth_bloc.dart';
import 'package:cinema_booking_app/view/controller/cinemaBloc/cinema_booking_bloc.dart';
import 'package:cinema_booking_app/view/controller/locationCubit/location_cubit.dart';
import 'package:cinema_booking_app/view/controller/movieBloc/home_bloc.dart';
import 'package:cinema_booking_app/view/screen/cinema_seats/cinema_seats_page.dart';
import 'package:cinema_booking_app/view/screen/splash/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'view/controller/tabCubit/tab_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final heigth = MediaQuery.sizeOf(context).height;
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocationCubit>(
          create: (context) => LocationCubit()..initializeLocation(),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(),
        ),
        BlocProvider<TabCubit>(
          create: (context) => TabCubit(),
        ),
        BlocProvider<CinemaBookingBloc>(
          create: (context) => CinemaBookingBloc(),
        )
      ],
      child: ScreenUtilInit(
        designSize: Size(width, heigth),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'Nunito'),
          home: CinemaSeatsPage(),
        ),
      ),
    );
  }
}
