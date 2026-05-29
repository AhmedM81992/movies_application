import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:movies_app/core/utils/load_status.dart';
import 'package:movies_app/feature/bookmarks/domain/entities/bookmark_movie/bookmark_movie_entity.dart';

@immutable
class BookmarkState extends Equatable {
  final List<BookmarkMovieEntity> favorites;
  final LoadStatus status;
  final String? error;
  final Set<int> favoriteIds;

  const BookmarkState({
    this.favorites = const [],
    this.status = LoadStatus.initial,
    this.error,
    this.favoriteIds = const <int>{},
  });

  BookmarkState copyWith({
    List<BookmarkMovieEntity>? favorites,
    LoadStatus? status,
    Object? error = _sentinel,
    Set<int>? favoriteIds,
  }) {
    return BookmarkState(
      favorites: favorites ?? this.favorites,
      status: status ?? this.status,
      error: error is String ? error as String? : this.error,
      favoriteIds: favorites != null
          ? favorites.map((e) => e.id).whereType<int>().toSet()
          : (favoriteIds ?? this.favoriteIds),
    );
  }

  @override
  List<Object?> get props => [favorites, status, error, favoriteIds];
}

const Object _sentinel = Object();
