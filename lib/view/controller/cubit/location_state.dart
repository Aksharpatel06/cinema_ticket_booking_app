part of 'location_cubit.dart';

@immutable
sealed class LocationState {}

final class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final LocationData locationData;
  final String locationName;

   LocationLoaded(this.locationData,this.locationName);

  List<Object> get props => [locationData];
}

class LocationError extends LocationState {
  final String errorMessage;

   LocationError(this.errorMessage);

  List<Object> get props => [errorMessage];
}