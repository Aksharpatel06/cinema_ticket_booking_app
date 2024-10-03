part of 'location_cubit.dart';

@immutable
sealed class LocationState extends Equatable {}

final class LocationInitial extends LocationState {
  @override
  List<Object> get props => [];
}

class LocationLoaded extends LocationState {
  final String locationName;
  final List<Cinema>? cinemaList;

  LocationLoaded({required this.locationName, this.cinemaList});

  @override
  List<Object?> get props => [locationName, cinemaList];
}

class CinemaLoadedSuccess extends LocationState {
  final List<Cinema> cinemaList;

  CinemaLoadedSuccess({required this.cinemaList});

  @override
  List<Object?> get props => [cinemaList];
}

class LocationError extends LocationState {
  final String errorMessage;

  LocationError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
