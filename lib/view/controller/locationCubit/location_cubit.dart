import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cinema_booking_app/view/modal/cinema_modal.dart';
import 'package:cinema_booking_app/view/screen/home/componects/appbar_action.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';

import 'package:meta/meta.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final Location location = Location();
  int count =0;

  List<Cinema> cinemaList =[];

  LocationCubit() : super(LocationInitial());

  Future<void> initializeLocation() async {
    bool serviceEnabled;

    try {
      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          emit(LocationError("Location services are disabled."));
          return;
        }
      }

      PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          emit(LocationError("Location permission denied."));
          return;
        }
      }


      location.onLocationChanged.listen((locationData) async {
        double latitude = locationData.latitude!;
        double longitude = locationData.longitude!;
        String placeName = await convertToName(latitude, longitude);

        emit(LocationLoaded(
          locationName: placeName,
        ));

        if(count==0)
          {
            loadCinemaApi(latitude, longitude);
            count++;
          }
      });


    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> loadCinemaApi(double latitude,double longitude) async {
    try {

      String api = await rootBundle.loadString('asset/json/cinema_data.json');
      List data = jsonDecode(api);
      cinemaList = data
          .map(
            (e) => Cinema.fromJson(e, latitude, longitude),
          )
          .toList();

      for(Cinema i in cinemaList)
        {
          log(i.km.toString());
        }
      cinemaList.sort((a, b) => a.km.compareTo(b.km));
      for(Cinema i in cinemaList)
      {
        log(i.km.toString());
      }
      log(cinemaList.length.toString());
    } catch (e) {
      log(e.toString());
      emit(LocationError('Failed to load movies: $e'));
    }
  }
}
