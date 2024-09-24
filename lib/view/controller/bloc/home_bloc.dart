import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cinema_booking_app/view/helper/api_services.dart';
import 'package:cinema_booking_app/view/modal/movie_modal.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialFetchEvent>(homeInitialFetchEvent);
    // on<HomeAddEvent>(homeAddEvent);
  }

  Future<void> homeInitialFetchEvent(
      HomeInitialFetchEvent event, Emitter<HomeState> emit) async {
    try {
      emit(HomeFetchingLoadingState());
      List<MovieModal> jsonList = await ApiServices.apiServices.getApiData();
      emit(HomeFetchingSuccessfulState(movies: jsonList));
    } catch (e) {
      emit(HomeFetchingErrorState(error: e.toString()));
    }
  }
}
