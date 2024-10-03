part of 'location_cubit.dart';

@immutable
sealed class LocationState extends Equatable {}

final class LocationInitial extends LocationState {
  @override
  List<Object> get props => [];
}

class LocationLoaded extends LocationState {
  final LocationData locationData;
  final String locationName;
  final List<Cinema>? cinemaList;

  LocationLoaded(
      {required this.locationData,
      required this.locationName,
      this.cinemaList});

  @override
  List<Object?> get props => [locationData,locationName,cinemaList];
}

class LocationError extends LocationState {
  final String errorMessage;

  LocationError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
