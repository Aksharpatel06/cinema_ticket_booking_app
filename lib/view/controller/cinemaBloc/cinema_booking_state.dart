part of 'cinema_booking_bloc.dart';

class CinemaBookingState extends Equatable {
  final List<CinemaUserModal> goldSeats;
  final List<CinemaUserModal> regularSeats;
  final List<CinemaUserModal> platinumSeats;

  const CinemaBookingState(
      {required this.goldSeats,
      required this.regularSeats,
      required this.platinumSeats});

  CinemaBookingState copyWith({
    List<CinemaUserModal>? goldSeats,
    List<CinemaUserModal>? regularSeats,
    List<CinemaUserModal>? platinumSeats,
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
