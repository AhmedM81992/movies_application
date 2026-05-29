import 'package:equatable/equatable.dart';

class FavListModelEntity extends Equatable {
  final String? id;
  final String? name;
  final String? releaseDate;
  final String? producers;

  const FavListModelEntity({
    this.id = "",
    required this.name,
    required this.releaseDate,
    required this.producers,
  });

  @override
  List<Object?> get props => [id, name, releaseDate, producers];
}
