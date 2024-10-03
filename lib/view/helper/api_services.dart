import 'dart:convert';

import 'package:cinema_booking_app/view/modal/movie_modal.dart';
import 'package:flutter/services.dart';

class ApiServices{
  static ApiServices apiServices = ApiServices._();
  ApiServices._();

  Future<List<MovieModal>> getApiData()
  async {
    String api = await rootBundle.loadString('asset/json/movie_data.json');
    final List data = jsonDecode(api);
    return data.map((e) => MovieModal(e),).toList();
  }



}