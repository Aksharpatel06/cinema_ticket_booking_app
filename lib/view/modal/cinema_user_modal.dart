class CinemaUserModal {
  String? user;
  String category;
  int index;
  bool value;
  int? amount;
  String? area,movie,time,date,cinema,imgPath;

  CinemaUserModal(
      {this.amount,this.user,
      required this.category,
        this.cinema,
      required this.index,
      required this.value,this.time,this.area,this.date,this.movie,this.imgPath});

  factory CinemaUserModal.fromJson(Map json) {
    return CinemaUserModal(
        user: json['user'],
        imgPath: json['image'],
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

  CinemaUserModal copyWith({
    String? category,
    int? index,
    bool? value,
  }) {
    return CinemaUserModal(
      category: category ?? this.category,
      index: index ?? this.index,
      value: value ?? this.value,
    );
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
      'image':imgPath,
      'time':time,
    };
  }
}


