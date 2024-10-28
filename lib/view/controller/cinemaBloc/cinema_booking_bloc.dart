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
                (index) => CinemaUserModal(
                    category: 'Gold', index: index, value: false)),
            platinumSeats: List.generate(
                11,
                (index) => CinemaUserModal(
                    category: 'Platinum', index: index, value: false)),
            regularSeats: List.generate(
                33,
                (index) => CinemaUserModal(
                    category: 'Regular', index: index, value: false)),
            totalSeats: [])) {
    on<ToggleSeatSelection>(mapEventToState);
  }

  FutureOr<void> mapEventToState(
      ToggleSeatSelection event, Emitter<CinemaBookingState> emit) async {
    final updatedGoldSeats = List<CinemaUserModal>.from(state.goldSeats);
    final updatedRegularSeats = List<CinemaUserModal>.from(state.regularSeats);
    final updatedTotalSeats = List<CinemaUserModal>.from(state.totalSeats);
    final updatedPlatinumSeats =
        List<CinemaUserModal>.from(state.platinumSeats);

    switch (event.category) {
      case 'Gold':
        if (event.seatIndex < updatedGoldSeats.length) {
          updatedGoldSeats[event.seatIndex] = updatedGoldSeats[event.seatIndex]
              .copyWith(value: !updatedGoldSeats[event.seatIndex].value);
        }
        break;
      case 'Regular':
        if (event.seatIndex < updatedRegularSeats.length) {
          updatedRegularSeats[event.seatIndex] =
              updatedRegularSeats[event.seatIndex]
                  .copyWith(value: !updatedRegularSeats[event.seatIndex].value);
        }
        break;
      case 'Platinum':
        if (event.seatIndex < updatedPlatinumSeats.length) {
          updatedPlatinumSeats[event.seatIndex] =
              updatedPlatinumSeats[event.seatIndex].copyWith(
                  value: !updatedPlatinumSeats[event.seatIndex].value);
        }
        break;
      default:
        log("Unknown category: ${event.category}");
    }
    bool seatExists = false;

    for (int i = 0; i < updatedTotalSeats.length; i++) {
      if (updatedTotalSeats[i].category == event.category &&
          updatedTotalSeats[i].index == event.seatIndex) {

        seatExists = true;
        break;
      }
    }

    if (seatExists) {
      updatedTotalSeats.removeWhere((seat) => seat.category == event.category && seat.index == event.seatIndex);
    } else {
      updatedTotalSeats.add(CinemaUserModal(
          category: event.category, index: event.seatIndex, value: true));
    }


    log(event.category);
    log(event.seatIndex.toString());
    emit(state.copyWith(
        goldSeats: updatedGoldSeats,
        platinumSeats: updatedPlatinumSeats,
        regularSeats: updatedRegularSeats,
        totalSeats: updatedTotalSeats));
  }
}
