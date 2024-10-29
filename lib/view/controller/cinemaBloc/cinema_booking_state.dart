part of 'cinema_booking_bloc.dart';

class CinemaBookingState extends Equatable {
  final List<CinemaUserModal> goldSeats;
  final List<CinemaUserModal> regularSeats;
  final List<CinemaUserModal> platinumSeats;
  final List<CinemaUserModal> totalSeats;

  const CinemaBookingState(
      {required this.goldSeats,
      required this.totalSeats,
      required this.regularSeats,
      required this.platinumSeats});

  CinemaBookingState copyWith({
    List<CinemaUserModal>? goldSeats,
    List<CinemaUserModal>? regularSeats,
    List<CinemaUserModal>? platinumSeats,
    List<CinemaUserModal>? totalSeats,
  }) {
    return CinemaBookingState(
      goldSeats: goldSeats ?? this.goldSeats,
      platinumSeats: platinumSeats ?? this.platinumSeats,
      regularSeats: regularSeats ?? this.regularSeats,
      totalSeats: totalSeats ?? this.totalSeats,
    );
  }

  @override
  List<Object?> get props => [
        goldSeats,
        platinumSeats,
        regularSeats,
        totalSeats,
      ];
}
