part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitialState extends HomeState {}

class HomeFetchingLoadingState extends HomeState {}

class HomeFetchingErrorState extends HomeState {
  final String error;

  HomeFetchingErrorState({
    required this.error,
  });
}

class HomeFetchingSuccessfulState extends HomeState {
  final List<MovieModal> movies;

  HomeFetchingSuccessfulState({
    required this.movies,
  });
}

class HomeAdditionSuccessState extends HomeActionState {}

class HomeAdditionErrorState extends HomeActionState {}

class HomeDetailsPageState extends HomeState {
  final MovieModal movieModal;

  HomeDetailsPageState({
    required this.movieModal,
  });
}
