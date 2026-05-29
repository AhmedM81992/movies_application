// ignore_for_file: body_might_complete_normally_nullable

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/core/network/dio_helper.dart';
import 'package:movies_app/feature/home/data/models/details_model/details_model_response_model.dart';
import 'package:movies_app/feature/home/data/models/popular_model/popular_model_response_model.dart';
import 'package:movies_app/feature/search/data/models/search_model/search_model_response_model.dart';
import 'package:movies_app/feature/home/data/models/similar_to_model/similar_to_model_response_model.dart';
import 'package:movies_app/feature/home/data/models/top_rated_model/top_rated_model_response_model.dart';
import 'package:movies_app/feature/home/data/models/trailer_model/trailer_model_response_model.dart';
import 'package:movies_app/feature/home/data/models/upcoming_model/upcoming_model_response_model.dart';
import 'package:movies_app/core/components/constants.dart';
import 'package:movies_app/core/network/remote/end_points.dart';

import 'package:movies_app/feature/browse/data/models/movie_discover_model/movie_discover_model_response_model.dart';
import 'package:movies_app/feature/browse/data/models/movies_list_model/movies_list_model_response_model.dart';

class ApiManager {
  // static Future<PopularModel?> getPopular() async {
  //   try {
  //     Uri url = Uri.https(
  //         Constants.baseUrl, EndPoints.popular, {"apiKey": Constants.apiKey});

  //     http.Response response = await http
  //         .get(url, headers: {"Authorization": AppStrings.headerApiKey!});

  //     Map<String, dynamic> json =
  //         jsonDecode(response.body); //return json type to map.

  //     return PopularModel.fromJson(json);
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  // static Future<UpcomingModel?> getUpComing() async {
  //   try {
  //     Uri url = Uri.https(
  //         Constants.baseUrl, EndPoints.upComing, {"apiKey": Constants.apiKey});
  //     http.Response response = await http
  //         .get(url, headers: {"Authorization": AppStrings.headerApiKey!});
  //     http.get(url);
  //     Map<String, dynamic> json = jsonDecode(response.body);
  //     return UpcomingModel.fromJson(json);
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  // static Future<TopRatedModel?> getTopRated() async {
  //   try {
  //     Uri url = Uri.https(
  //         Constants.baseUrl, EndPoints.topRated, {"apiKey": Constants.apiKey});
  //     http.Response response = await http
  //         .get(url, headers: {"Authorization": AppStrings.headerApiKey!});
  //     http.get(url);
  //     Map<String, dynamic> json = jsonDecode(response.body);
  //     return TopRatedModel.fromJson(json);
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  // static Future<DetailsModel?> getDetails(String id) async {
  //   try {
  //     Uri url = Uri.https(Constants.baseUrl, EndPoints.details + id);
  //     http.Response response = await http
  //         .get(url, headers: {"Authorization": AppStrings.headerApiKey!});
  //     Map<String, dynamic> json = jsonDecode(response.body);
  //     return DetailsModel.fromJson(json);
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  // static Future<SimilarToModel?> getSimilar(String id) async {
  //   try {
  //     Uri url = Uri.https(
  //         Constants.baseUrl, EndPoints.details + id + EndPoints.similar);
  //     http.Response response = await http
  //         .get(url, headers: {"Authorization": AppStrings.headerApiKey!});
  //     Map<String, dynamic> json = jsonDecode(response.body);
  //     return SimilarToModel.fromJson(json);
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  // static Future<SearchModel?> getSearch(String search) async {
  //   try {
  //     Uri url =
  //         Uri.https(Constants.baseUrl, EndPoints.search, {"query": search});

  //     http.Response response = await http
  //         .get(url, headers: {"Authorization": AppStrings.headerApiKey!});
  //     Map<String, dynamic> json = jsonDecode(response.body);
  //     //debugPrint(url.toString());
  //     return SearchModel.fromJson(json);
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  // static Future<TrailerModel?> getTrailer(String id) async {
  //   try {
  //     Uri url = Uri.https(
  //         Constants.baseUrl, EndPoints.details + id + EndPoints.video);
  //     http.Response response = await http
  //         .get(url, headers: {"Authorization": AppStrings.headerApiKey!});
  //     Map<String, dynamic> json = jsonDecode(response.body);
  //     debugPrint(url.toString());
  //     return TrailerModel.fromJson(json);
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  // static Future<MoviesListModel?> getMoviesList() async {
  //   try {
  //     Uri url = Uri.https(Constants.baseUrl, EndPoints.moviesList,
  //         {"apiKey": Constants.apiKey});
  //     http.Response response = await http
  //         .get(url, headers: {"Authorization": AppStrings.headerApiKey!});
  //     var responseBody = jsonDecode(response.body);
  //     debugPrint(responseBody.toString());
  //     return MoviesListModel.fromJson(responseBody);
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  // static Future<MovieDiscoverModel?> getMovieDiscover(String category,
  //     {int page = 1}) async {
  //   try {
  //     // Uri url = Uri.https(Constants.BASE_URL, EndPoints.movieDiscover,
  //     //     {"apiKey": Constants.API_KEY});
  //     http.Response response = await http.get(
  //         Uri.parse(
  //             "${Constants.baseUrl}${EndPoints.movieDiscover}?page=$page&with_genres=$category"),
  //         headers: {"Authorization": AppStrings.headerApiKey!});
  //     var responseBody = jsonDecode(response.body);
  //     debugPrint(responseBody.toString());
  //     return MovieDiscoverModel.fromJson(responseBody);
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  static Future<SearchModel?> getSearch(String search) async {
    try {
      final response = await DioHelper.getData(
        url: EndPoints.search,
        query: {"query": search},
      );
      return SearchModel.fromJson(response.data);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<SimilarToModel?> getSimilar(String id) async {
    try {
      final response = await DioHelper.getData(
        url: "${EndPoints.details}$id${EndPoints.similar}",
      );
      return SimilarToModel.fromJson(response.data);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<DetailsModel?> getDetails(String id) async {
    //movie details page
    try {
      final response = await DioHelper.getData(
        url: "${EndPoints.details}$id",
      );

      return DetailsModel.fromJson(response.data);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<TopRatedModel?> getTopRated() async {
    try {
      final response = await DioHelper.getData(
        url: EndPoints.topRated,
        query: {"apiKey": Constants.apiKey},
      );

      return TopRatedModel.fromJson(response.data);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<UpcomingModel?> getUpComing() async {
    try {
      final response = await DioHelper.getData(
        url: EndPoints.upComing,
        query: {"apiKey": Constants.apiKey},
      );

      return UpcomingModel.fromJson(response.data);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<PopularModel?> getPopular() async {
    //first item on home screen
    try {
      final response = await DioHelper.getData(
        url: EndPoints.popular,
        query: {"apiKey": Constants.apiKey},
      );
      return PopularModel.fromJson(response.data);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<TrailerModel?> getTrailer(String id) async {
    try {
      Response response = await DioHelper.getData(
        url: "${EndPoints.details}$id${EndPoints.video}",
      );

      debugPrint(response.realUri.toString());

      return TrailerModel.fromJson(response.data);
    } catch (e) {
      debugPrint("Error fetching trailer: $e");
      return null;
    }
  }

  static Future<MoviesListModel?> getMoviesList() async {
    try {
      Response response = await DioHelper.getData(
        url: EndPoints.moviesList,
        query: {"apiKey": Constants.apiKey},
      );

      debugPrint(response.data.toString());

      return MoviesListModel.fromJson(response.data);
    } catch (e) {
      debugPrint("Error fetching movies list: $e");
      return null;
    }
  }

  static Future<MovieDiscoverModel?> getMovieDiscover(String category,
      {int page = 1}) async {
    try {
      final response = await DioHelper.getData(
        url: EndPoints.movieDiscover,
        query: {"page": page, "with_genres": category},
      );
      debugPrint(response.realUri.toString()); // Logs the full request URL
      return MovieDiscoverModel.fromJson(response.data);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
