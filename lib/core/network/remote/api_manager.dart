// ignore_for_file: body_might_complete_normally_nullable

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/core/network/remote/dio_helper.dart';
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
  static Future<SearchModel?> getSearch(String search) async {
    try {
      final response = await DioHelper.dio.get(
        EndPoints.search,
        queryParameters: {"query": search},
      );
      return SearchModel.fromJson(response.data);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<SimilarToModel?> getSimilar(String id) async {
    try {
      final response = await DioHelper.dio.get(
        "${EndPoints.details}$id${EndPoints.similar}",
      );
      return SimilarToModel.fromJson(response.data);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<DetailsModel?> getDetails(String id) async {
    try {
      final response = await DioHelper.dio.get(
        "${EndPoints.details}$id",
      );
      return DetailsModel.fromJson(response.data);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<TopRatedModel?> getTopRated() async {
    try {
      final response = await DioHelper.dio.get(
        EndPoints.topRated,
        queryParameters: {"apiKey": Constants.apiKey},
      );
      return TopRatedModel.fromJson(response.data);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<UpcomingModel?> getUpComing() async {
    try {
      final response = await DioHelper.dio.get(
        EndPoints.upComing,
        queryParameters: {"apiKey": Constants.apiKey},
      );
      return UpcomingModel.fromJson(response.data);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<PopularModel?> getPopular() async {
    try {
      final response = await DioHelper.dio.get(
        EndPoints.popular,
        queryParameters: {"apiKey": Constants.apiKey},
      );
      return PopularModel.fromJson(response.data);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<TrailerModel?> getTrailer(String id) async {
    try {
      Response response = await DioHelper.dio.get(
        "${EndPoints.details}$id${EndPoints.video}",
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
      Response response = await DioHelper.dio.get(
        EndPoints.moviesList,
        queryParameters: {"apiKey": Constants.apiKey},
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
      final response = await DioHelper.dio.get(
        EndPoints.movieDiscover,
        queryParameters: {"page": page, "with_genres": category},
      );
      debugPrint(response.realUri.toString());
      return MovieDiscoverModel.fromJson(response.data);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
