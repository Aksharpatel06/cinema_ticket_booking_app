import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'cinema_booking_event.dart';

part 'cinema_booking_state.dart';

class CinemaBookingBloc extends Bloc<CinemaBookingEvent, CinemaBookingState> {
  CinemaBookingBloc()
      : super(CinemaBookingState(
          goldSeats: List.generate(55, (index) => false),
          platinumSeats: List.generate(11, (index) => false),
          regularSeats: List.generate(33, (index) => false),
        )) {
    on<ToggleSeatSelection>(mapEventToState);
  }

  FutureOr<void> mapEventToState (
      ToggleSeatSelection event, Emitter<CinemaBookingState> emit) async {
    print('hello');
    final updatedGoldSeats = List<bool>.from(state.goldSeats);
    final updatedPlatinumSeats = List<bool>.from(state.platinumSeats);
    final updatedRegularSeats = List<bool>.from(state.regularSeats);
    if (event.category == 'Gold') {
      updatedGoldSeats[event.seatIndex] = !updatedGoldSeats[event.seatIndex];
    } else if (event.category == 'Regular') {
      updatedRegularSeats[event.seatIndex] = !updatedRegularSeats[event.seatIndex];
    } else if (event.category == 'Platinum') {
      updatedPlatinumSeats[event.seatIndex] = !updatedPlatinumSeats[event.seatIndex];
    }

    log('message');
    emit(state.copyWith(
        goldSeats: updatedGoldSeats,
        platinumSeats: updatedPlatinumSeats,
        regularSeats: updatedRegularSeats));
    log('success');
  }

}
