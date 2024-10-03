
import 'dart:math';

import 'package:cinema_booking_app/view/controller/cubit/location_cubit.dart';

class Cinema {
  String cinema;
  String area;
  double km;
  double longitude;
  double latitude;
  List<ShowTime> data;


  Cinema({
    required this.cinema,
    required this.area,
    required this.km,
    required this.longitude,
    required this.latitude,
    required this.data,
  });

  factory Cinema.fromJson(Map json,double latitude,double longitude) {
    var list = json['data'] as List;
    List<ShowTime> showTimeList =
        list.map((i) => ShowTime.fromJson(i)).toList();
    double km = calculateDistance(
      latitude,
      longitude,
      json['latitude'],
      json['longitude'],
    );
    return Cinema(
      cinema: json['cinema'],
      area: json['area'],
      km: km??json['km'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      data: showTimeList,
    );
  }
}

class ShowTime {
  String time;
  int prize;

  ShowTime({required this.time, required this.prize});

  factory ShowTime.fromJson(Map<String, dynamic> json) {
    return ShowTime(
      time: json['time'],
      prize: json['prize'],
    );
  }
}

double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const R = 6371; // Radius of the Earth in km
  double latDistance = (lat2 - lat1) * pi / 180;
  double lonDistance = (lon2 - lon1) * pi / 180;

  double a = sin(latDistance / 2) * sin(latDistance / 2) +
      cos(lat1 * pi / 180) *
          cos(lat2 * pi / 180) *
          sin(lonDistance / 2) *
          sin(lonDistance / 2);

  double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  return R * c;
}
