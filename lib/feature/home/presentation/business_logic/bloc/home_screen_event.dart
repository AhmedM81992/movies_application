part of 'home_screen_bloc.dart';

abstract class HomeScreenEvent extends Equatable {
  const HomeScreenEvent();

  @override
  List<Object> get props => [];
}

class GetHomePopularEvent extends HomeScreenEvent {}

class GetHomeUpcomingEvent extends HomeScreenEvent {}

class GetHomeTopRatedEvent extends HomeScreenEvent {}

class GetHomeDetailsEvent extends HomeScreenEvent {
  final int movieId;

  const GetHomeDetailsEvent(this.movieId);

  @override
  List<Object> get props => [movieId];
}
