part of 'cinema_booking_bloc.dart';

class CinemaBookingState extends Equatable {
  final List<bool> goldSeats;
  final List<bool> regularSeats;
  final List<bool> platinumSeats;

  const CinemaBookingState(
      {required this.goldSeats,
      required this.regularSeats,
      required this.platinumSeats});

  CinemaBookingState copyWith({
    List<bool>? goldSeats,
    List<bool>? regularSeats,
    List<bool>? platinumSeats,
  }) {
    return CinemaBookingState(
      goldSeats: goldSeats ?? this.goldSeats,
      platinumSeats: platinumSeats ?? this.platinumSeats,
      regularSeats: regularSeats ?? this.regularSeats,
    );
  }

  @override
  List<Object?> get props => [
        goldSeats,
        platinumSeats,
        regularSeats,
      ];
}
