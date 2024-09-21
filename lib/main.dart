import 'package:cinema_booking_app/view/controller/authBloc/auth_bloc.dart';
import 'package:cinema_booking_app/view/screen/splash/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: ScreenUtilInit(
        designSize: Size(width, heigth),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'Nunito'),
          home: const SplashPage(),
        ),
      ),
    );
  }
}
