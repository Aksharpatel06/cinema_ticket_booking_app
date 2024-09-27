part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialFetchEvent extends HomeEvent{}

class HomeToMovieDetailsEvent extends HomeEvent{
  final MovieModal movieModal;

  HomeToMovieDetailsEvent({required this.movieModal});
}


