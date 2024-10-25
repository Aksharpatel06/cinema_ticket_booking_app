class CinemaUserModal {
  String user;
  String category;
  int index;

  CinemaUserModal(
      {required this.user, required this.category, required this.index});

  factory CinemaUserModal.fromJson(Map json) {
    return CinemaUserModal(
        user: json['user'], category: json['category'], index: json['index']);
  }

  Map<String,dynamic> toMap()
  {
    return {
     'user':user,
     'category':category,
     'index':index,
    };
  }
}
