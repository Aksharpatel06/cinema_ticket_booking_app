part of 'cinema_booking_bloc.dart';


// Define the event base class
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

