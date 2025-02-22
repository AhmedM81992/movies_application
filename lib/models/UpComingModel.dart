import 'ResultsModel.dart';

class UpcomingModel {
  UpcomingModel({
    this.dates,
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  Dates? dates;
  int? page;
  List<Results>? results;
  int? totalPages;
  int? totalResults;

  factory UpcomingModel.fromJson(
      Map<String, dynamic> json) {
    return UpcomingModel(
      dates: json['dates'] != null
          ? Dates.fromJson(json['dates'])
          : null,
      page: json['page'],
      results: json['results'] != null
          ? List<Results>.from(json['results']
              .map((x) => Results.fromJson(x)))
          : null,
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['dates'] = dates != null ? dates!.toJson() : null;
    data['page'] = page;
    data['total_pages'] = totalPages;
    data['total_results'] = totalResults;
    if (results != null) {
      data['results'] =
          results!.map((x) => x.toJson()).toList();
    }
    return data;
  }
}

class Dates {
  Dates({
    this.maximum,
    this.minimum,
  });

  String? maximum;
  String? minimum;

  factory Dates.fromJson(Map<String, dynamic> json) {
    return Dates(
      maximum: json['maximum'],
      minimum: json['minimum'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['maximum'] = maximum;
    data['minimum'] = minimum;
    return data;
  }
}
