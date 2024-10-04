part of 'home_bloc.dart';

@immutable
sealed class HomeState extends Equatable{}

abstract class HomeActionState extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeInitialState extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeFetchingLoadingState extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeFetchingErrorState extends HomeState {
  final String error;

  HomeFetchingErrorState({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}

class HomeFetchingSuccessfulState extends HomeState {
  final List<MovieModal> movies;

  HomeFetchingSuccessfulState({
    required this.movies,
  });
  @override
  List<Object> get props => [movies];
}
class HomeAdditionSuccessState extends HomeActionState {
  final MovieModal movieModal;

  HomeAdditionSuccessState({
    required this.movieModal,
  });
  @override
  List<Object> get props => [movieModal];
}
