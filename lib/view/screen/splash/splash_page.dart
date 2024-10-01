import 'dart:async';
import 'package:cinema_booking_app/view/screen/home/home_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('asset/img/splash/Background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Hero(
            tag: 'splash',
            child: Image.asset(
              'asset/img/splash/splash_img.png',
            ),
          ),
        ),
      ),
    );
  }
}
