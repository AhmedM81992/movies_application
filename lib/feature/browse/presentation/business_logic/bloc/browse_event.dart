part of 'browse_bloc.dart';

abstract class BrowseEvent extends Equatable {
  const BrowseEvent();

  @override
  List<Object> get props => [];
}

class GetGenresEvent extends BrowseEvent {}

class GetMovieDiscoverEvent extends BrowseEvent {
  final int genreId;

  const GetMovieDiscoverEvent(this.genreId);

  @override
  List<Object> get props => [genreId];
}
