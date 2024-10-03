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
  double latitude = 0, longitude = 0;

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
        latitude = locationData.latitude!;
        longitude = locationData.longitude!;
        String placeName = await convertToName(latitude, longitude);

        emit(LocationLoaded(
          locationName: placeName,
        ));
      });

    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> loadCinemaApi() async {
    try {

      String api = await rootBundle.loadString('asset/json/cinema_data.json');
      List data = jsonDecode(api);
      List<Cinema> cinemaList = data
          .map(
            (e) => Cinema.fromJson(e, latitude, longitude),
          )
          .toList();
      cinemaList.sort((a, b) => a.km.compareTo(b.km));
      log(cinemaList.length.toString());

      emit(CinemaLoadedSuccess(cinemaList: cinemaList));
    } catch (e) {
      log(e.toString());
      emit(LocationError('Failed to load movies: $e'));
    }
  }
}
