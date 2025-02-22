class FavListModel {
  String? id;
  String? name;
  String? releaseDate;
  String? producers;

  FavListModel({
    this.id = "",
    required this.name,
    required this.releaseDate,
    required this.producers,
  });

  FavListModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          name: json['name'],
          releaseDate: json['releaseDate'],
          producers: json['producers'],
        );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "releaseDate": releaseDate,
      "producers": producers,
    };
  }
}
