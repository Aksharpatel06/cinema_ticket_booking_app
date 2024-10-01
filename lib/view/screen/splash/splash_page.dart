import 'dart:async';
import 'dart:developer';

import 'package:cinema_booking_app/view/screen/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(seconds: 2),
      () async {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ));
        LocationData locationData = await getCurrentLocation();
      },
    );
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
Future<LocationData> getCurrentLocation()
async {
  // bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  // if(!serviceEnabled)
  // {
  //   Future.error('Location services are disabled.');
  // }
  //
  // LocationPermission permission = await Geolocator.checkPermission();
  // if(permission==LocationPermission.denied)
  // {
  //   permission = await Geolocator.requestPermission();
  //   if(permission==LocationPermission.denied)
  //   {
  //     Future.error('Location permissions are denied.');
  //   }
  // }
  //
  // if(permission == LocationPermission.deniedForever)
  // {
  //   Future.error('Location permissions are permanently');
  // }

  var location =Location();
  var serviceEnabled = await location.serviceEnabled();
  if(!serviceEnabled)
    {
      serviceEnabled = await location.requestService();
      if(!serviceEnabled)
        {
          log('message');

        }
    }

  var permissions = await location.hasPermission();
  if(permissions == PermissionStatus.denied)
    {
      permissions = await location.requestPermission();
      if(permissions != PermissionStatus.granted)
        {
          log('message');
        }
    }

  return await location.getLocation();
}
