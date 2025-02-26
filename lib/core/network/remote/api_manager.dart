// ignore_for_file: body_might_complete_normally_nullable

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/core/network/remote/dio_helper.dart';
import 'package:movies_app/models/DetailsModel.dart';
import 'package:movies_app/models/PopularModel.dart';
import 'package:movies_app/models/SearchModel.dart';
import 'package:movies_app/models/SimilarToModel.dart';
import 'package:movies_app/models/TopRatedModel.dart';
import 'package:movies_app/models/TrailerModel.dart';
import 'package:movies_app/models/UpComingModel.dart';
import 'package:movies_app/core/components/constants.dart';
import 'package:movies_app/core/network/remote/end_points.dart';
import 'package:movies_app/core/utils/app_strings.dart';

import '../../../models/MovieDiscoverModel.dart';
import '../../../models/MoviesListModel.dart';

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
