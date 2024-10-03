
import 'dart:math';


class Cinema {
  String cinema;
  String area;
  double km;
  double longitude;
  double latitude;
  List<ShowTime> data=[];


  Cinema({
    required this.cinema,
    required this.area,
    required this.km,
    required this.longitude,
    required this.latitude,
    required this.data,
  });

  factory Cinema.fromJson(Map json,double latitude,double longitude) {
    List<ShowTime> showTimeDetails = (json['TimeAndPrize'] as List).map((e) => ShowTime.fromJson(e),).toList();
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
      data: showTimeDetails,
    );
  }
}

class ShowTime {
  String time;
  int prize;

  ShowTime({required this.time, required this.prize});

  factory ShowTime.fromJson(Map json) {
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
