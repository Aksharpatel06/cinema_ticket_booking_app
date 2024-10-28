import 'dart:async';
import 'dart:developer';

import 'package:cinema_booking_app/view/modal/cinema_user_modal.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'cinema_booking_event.dart';

part 'cinema_booking_state.dart';

class CinemaBookingBloc extends Bloc<CinemaBookingEvent, CinemaBookingState> {
  CinemaBookingBloc()
      : super(CinemaBookingState(
          goldSeats: List.generate(
              55,
              (index) => CinemaUserModal(category: 'Gold', index: index, value: false)),
          platinumSeats: List.generate(
              11,
              (index) => CinemaUserModal(category: 'Platinum', index: index, value: false)),
          regularSeats: List.generate(
              33,
              (index) => CinemaUserModal(category: 'Regular', index: index, value: false)),
        )) {
    on<ToggleSeatSelection>(mapEventToState);
  }

  FutureOr<void> mapEventToState(
      ToggleSeatSelection event, Emitter<CinemaBookingState> emit) async {
    List<CinemaUserModal> updatedGoldSeats = state.goldSeats;
    List<CinemaUserModal> updatedPlatinumSeats = state.platinumSeats;
    List<CinemaUserModal> updatedRegularSeats = state.regularSeats;

    if (event.category == 'Gold') {
      updatedGoldSeats[event.seatIndex].value =
      !updatedGoldSeats[event.seatIndex].value;
    } else if (event.category == 'Regular') {
      updatedRegularSeats[event.seatIndex].value =
      !updatedRegularSeats[event.seatIndex].value;
    } else if (event.category == 'Platinum') {
      updatedPlatinumSeats[event.seatIndex].value =
      !updatedPlatinumSeats[event.seatIndex].value;
    }


    log(event.category);
    log(event.seatIndex.toString());
    emit(state.copyWith(
        goldSeats: updatedGoldSeats,
        platinumSeats: updatedPlatinumSeats,
        regularSeats: updatedRegularSeats));
  }
}
