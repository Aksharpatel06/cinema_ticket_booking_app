import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cinema_booking_app/view/helper/api_services.dart';
import 'package:cinema_booking_app/view/modal/movie_modal.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<HomeInitialFetchEvent>(homeInitialFetchEvent);
    on<HomeToMovieDetailsEvent>(homeToMovieDetailsEvent);
  }
  List<MovieModal> jsonList=[];
  Future<void> homeInitialFetchEvent(
      HomeInitialFetchEvent event, Emitter<HomeState> emit) async {
    try {
      emit(HomeFetchingLoadingState());
      jsonList = await ApiServices.apiServices.getApiData();
      emit(HomeFetchingSuccessfulState(movies: jsonList));
      log(jsonList[0].type);
    } catch (e) {
      log(e.toString());
      emit(HomeFetchingErrorState(error: e.toString()));
    }
  }

  FutureOr<void> homeToMovieDetailsEvent(
      HomeToMovieDetailsEvent event, Emitter<HomeState> emit) {
    emit(HomeAdditionSuccessState(movieModal: event.movieModal));

  }
}
