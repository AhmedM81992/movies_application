part of 'bookmark_bloc.dart';

abstract class BookmarkEvent extends Equatable {
  const BookmarkEvent();

  @override
  List<Object> get props => [];
}

class ListenFavoritesEvent extends BookmarkEvent {}

class FavoritesUpdatedEvent extends BookmarkEvent {
  final List<BookmarkMovieEntity> favorites;
  final bool hasError;
  final String? errorMessage;

  const FavoritesUpdatedEvent({
    required this.favorites,
    this.hasError = false,
    this.errorMessage,
  });

  @override
  List<Object> get props => [favorites, hasError, errorMessage ?? ''];
}

class AddFavoriteEvent extends BookmarkEvent {
  final BookmarkMovieEntity movie;

  const AddFavoriteEvent(this.movie);

  @override
  List<Object> get props => [movie];
}

class DeleteFavoriteEvent extends BookmarkEvent {
  final String firebaseId;

  const DeleteFavoriteEvent(this.firebaseId);

  @override
  List<Object> get props => [firebaseId];
}

class ToggleFavoriteEvent extends BookmarkEvent {
  final int movieId;
  final BookmarkMovieEntity movie;

  const ToggleFavoriteEvent({
    required this.movieId,
    required this.movie,
  });

  @override
  List<Object> get props => [movieId, movie];
}
