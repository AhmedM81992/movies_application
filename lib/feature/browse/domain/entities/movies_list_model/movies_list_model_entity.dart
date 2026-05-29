import 'package:equatable/equatable.dart';

class MoviesListModelEntity extends Equatable {
  final List<GenresEntity>? genres;

  const MoviesListModelEntity({
    this.genres,
  });

  @override
  List<Object?> get props => [genres];
}

class GenresEntity extends Equatable {
  final int? id;
  final String? name;

  const GenresEntity({
    this.id,
    this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
