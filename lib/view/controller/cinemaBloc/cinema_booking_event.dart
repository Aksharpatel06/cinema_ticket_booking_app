part of 'cinema_booking_bloc.dart';


abstract class CinemaBookingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ToggleSeatSelection extends CinemaBookingEvent {
  final int seatIndex;
  final String category;

  ToggleSeatSelection(this.seatIndex,this.category);
  @override
  List<Object?> get props => [seatIndex,category];
}

