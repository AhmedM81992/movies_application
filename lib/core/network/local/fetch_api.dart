import 'package:flutter/material.dart';
import 'package:movies_app/feature/home/data/models/details_model/details_model_response_model.dart';
import 'package:movies_app/feature/home/data/models/popular_model/popular_model_response_model.dart';
import 'package:movies_app/feature/home/data/models/top_rated_model/top_rated_model_response_model.dart';
import 'package:movies_app/feature/home/data/models/upcoming_model/upcoming_model_response_model.dart';
import 'package:movies_app/core/network/local/top_rated_local_database.dart';
import 'package:movies_app/core/network/local/upcoming_local_database.dart';
import 'dart:convert';

import '../remote/api_manager.dart';
import 'details_local_database.dart';
import 'popular_local_database.dart'; // Import your local database handling class

class FetchAPI {
  static Future<PopularModel?> getPopular() async {
    try {
      String? cachedData = await PopularLocalDatabase.getData();

      if (cachedData != null) {
        return PopularModel.fromJson(jsonDecode(cachedData)); // FIXED
      }

      final result = await ApiManager.getPopular();

      if (result != null) {
        await PopularLocalDatabase.saveData(
            jsonEncode(result.toJson())); // Cache it
      }

      return result;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  static Future<UpcomingModel?> getUpcoming() async {
    try {
      String? cachedData = await UpComingLocalDatabase.getData();

      if (cachedData != null) {
        return UpcomingModel.fromJson(jsonDecode(cachedData));
      }

      final result = await ApiManager.getUpComing();

      if (result != null) {
        await UpComingLocalDatabase.saveData(jsonEncode(result.toJson()));
      }

      return result;
    } catch (e) {
      debugPrint("Error while fetching upcoming movies: $e");
      return null;
    }
  }

  static Future<TopRatedModel?> getToprated() async {
    try {
      // Check if data is available in local database
      String? cachedData = await TopRatedLocalDatabase.getData();
      if (cachedData != null) {
        return TopRatedModel.fromJson(jsonDecode(cachedData));
      }

      // Fetch from API if no valid cached data
      final result = await ApiManager.getTopRated();

      if (result != null) {
        await TopRatedLocalDatabase.saveData(jsonEncode(result.toJson()));
      }

      return result;
    } catch (e) {
      debugPrint("Error while fetching top-rated movies: $e");
      return null;
    }
  }

  static Future<DetailsModel?> getdetails(String id) async {
    try {
      debugPrint("🔎 Checking cache for ID: $id");
      String? cachedData = await DetailsLocalDatabase.getData(id);

      if (cachedData != null) {
        debugPrint("🟢 Returning cached data for ID: $id");
        return DetailsModel.fromJson(jsonDecode(cachedData));
      }

      debugPrint("🌐 Fetching data from API for ID: $id");
      final result = await ApiManager.getDetails(id);

      if (result != null) {
        await DetailsLocalDatabase.saveData(id, jsonEncode(result.toJson()));
        debugPrint("✅ API data saved for ID: $id");
      }

      return result;
    } catch (e) {
      debugPrint("❌ Error while fetching details: $e");
      return null;
    }
  }
}
