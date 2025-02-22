import 'package:http/http.dart' as http;
import 'package:movies_app/models/DetailsModel.dart';
import 'package:movies_app/models/PopularModel.dart';
import 'package:movies_app/models/TopRatedModel.dart';
import 'package:movies_app/models/UpComingModel.dart';
import 'package:movies_app/shared/components/constants.dart';
import 'package:movies_app/shared/networks/local/top_rated_local_database.dart';
import 'package:movies_app/shared/networks/local/upcoming_local_database.dart';
import 'package:movies_app/shared/networks/remote/end_points.dart';
import 'package:movies_app/shared/styles/app_strings.dart';
import 'dart:convert';

import 'details_local_database.dart';
import 'popular_local_database.dart'; // Import your local database handling class

class FetchAPI {
  static Future<PopularModel?> getPopular() async {
    try {
      // Attempt to retrieve data from local database
      String? cachedData = await PopularLocalDatabase.getData();

      // If cached data is available and not expired, return it
      if (cachedData != null) {
        return PopularModel.fromJson(jsonDecode(cachedData));
      }

      // If cached data is expired or not available, make API call
      Uri url = Uri.https(
          Constants.BASE_URL, EndPoints.popular, {"apiKey": Constants.API_KEY});

      http.Response response = await http.get(
        url,
        headers: {"Authorization": AppStrings.headerApiKey!},
      );

      // Parse API response
      Map<String, dynamic> json = jsonDecode(response.body);

      // Save fetched data to local database
      await PopularLocalDatabase.saveData(response.body);

      // Return parsed data
      return PopularModel.fromJson(json);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<UpcomingModel?> getUpcoming() async {
    try {
      // Check if data is available in local database
      String? cachedData = await UpComingLocalDatabase.getData();
      if (cachedData != null) {
        // If data is available and not expired, return it
        return UpcomingModel.fromJson(jsonDecode(cachedData));
      }

      // If data is not available in local database or expired, fetch it from the API
      Uri url = Uri.https(Constants.BASE_URL, EndPoints.upComing,
          {"apiKey": Constants.API_KEY});
      http.Response response = await http.get(
        url,
        headers: {"Authorization": AppStrings.headerApiKey!},
      );

      if (response.statusCode == 200) {
        // Save fetched data to local database for caching
        await UpComingLocalDatabase.saveData(response.body);

        // Return the fetched data
        return UpcomingModel.fromJson(jsonDecode(response.body));
      } else {
        print(
            "Failed to fetch upcoming movies. Status code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error while fetching upcoming movies: $e");
      return null;
    }
  }

  static Future<TopRatedModel?> getToprated() async {
    try {
      // Initialize the local database if not already initialized
      await TopRatedLocalDatabase.initDatabase(); // Await the initialization

      // Check if data is available in local database
      String? cachedData = await TopRatedLocalDatabase.getData();
      if (cachedData != null) {
        // If data is available and not expired, return it
        return TopRatedModel.fromJson(jsonDecode(cachedData));
      }

      // If data is not available in local database or expired, fetch it from the API
      Uri url = Uri.https(Constants.BASE_URL, EndPoints.topRated,
          {"apiKey": Constants.API_KEY});
      http.Response response = await http
          .get(url, headers: {"Authorization": AppStrings.headerApiKey!});

      if (response.statusCode == 200) {
        // Save fetched data to local database for caching
        await TopRatedLocalDatabase.saveData(response.body);

        // Return the fetched data
        return TopRatedModel.fromJson(jsonDecode(response.body));
      } else {
        print(
            "Failed to fetch top-rated movies. Status code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error while fetching top-rated movies: $e");
      return null;
    }
  }

  static Future<DetailsModel?> getdetails(String id) async {
    try {
      await DetailsLocalDatabase.initDatabase();
      String? cachedData = await DetailsLocalDatabase.getData();

      if (cachedData != null) {
        return DetailsModel.fromJson(jsonDecode(cachedData));
      }

      Uri url = Uri.https(Constants.BASE_URL, EndPoints.details + id);
      http.Response response = await http.get(
        url,
        headers: {"Authorization": AppStrings.headerApiKey!},
      );

      if (response.statusCode == 200) {
        await DetailsLocalDatabase.saveData(response.body);
        return DetailsModel.fromJson(jsonDecode(response.body));
      } else {
        print("Failed to fetch details. Status code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error while fetching details: $e");
      return null;
    }
  }
}
