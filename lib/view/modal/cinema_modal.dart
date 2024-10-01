class Cinema {
  String cinema;
  String area;
  String km;
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

  factory Cinema.fromJson(Map json) {
    var list = json['data'] as List;
    List<ShowTime> showTimeList = list.map((i) => ShowTime.fromJson(i)).toList();

    return Cinema(
      cinema: json['cinema'],
      area: json['area'],
      km: json['km'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      data: showTimeList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cinema': cinema,
      'area': area,
      'km': km,
      'longitude': longitude,
      'latitude': latitude,
      'data': data.map((i) => i.toJson()).toList(),
    };
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

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'prize': prize,
    };
  }
}
