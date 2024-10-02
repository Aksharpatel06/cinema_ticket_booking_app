import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cinema_booking_app/view/screen/home/componects/appbar_action.dart';
import 'package:location/location.dart';

import 'package:meta/meta.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final Location location = Location();

  LocationCubit() : super(LocationInitial());

  Future<void> initializeLocation() async {
    bool serviceEnabled;
    log('message');

    // Check if location services are enabled
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        emit(LocationError("Location services are disabled."));
        return;
      }
    }

    // Check if the app has location permission
    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        emit(LocationError("Location permission denied."));
        return;
      }
    }
    log('true');

    try {
      location.onLocationChanged.listen((locationData) async {
        double latitude = locationData.latitude!;
        double longitude = locationData.longitude!;
        String placeName = await convertToName(latitude, longitude);
        log('message');

        emit(LocationLoaded(locationData, placeName));
      });
    } catch (e) {
      log(e.toString());
    }
  }
}
