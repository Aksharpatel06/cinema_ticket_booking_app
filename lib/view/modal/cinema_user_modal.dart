class CinemaUserModal {
  String? user;
  String category;
  int index;
  bool value;
  int amount;
  String? area,movie,time,date,cinema;

  CinemaUserModal(
      {required this.amount,this.user,
      required this.category,
        this.cinema,
      required this.index,
      required this.value,this.time,this.area,this.date,this.movie});

  factory CinemaUserModal.fromJson(Map json) {
    return CinemaUserModal(
        user: json['user']??'',
        category: json['category'],
        index: json['index'],
        amount: json['amount'],
        area: json['area'],
        cinema: json['cinema'],
        date: json['date'],
        movie: json['movie'],
        time: json['time'],
        value: json['is_booking']);
  }

  Map<String, dynamic> toMap() {
    return {
      'user': user,
      'category': category,
      'index': index,
      'amount':amount,
      'cinema':cinema,
      'is_booking': value,
      'area':area,
      'date':date,
      'movie':movie,
      'time':time,
    };
  }
}


