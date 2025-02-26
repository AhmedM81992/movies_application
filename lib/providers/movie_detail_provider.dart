import 'package:flutter/material.dart';
import 'package:movies_app/models/DetailsModel.dart';

import '../core/network/local/fetch_api.dart';

// Define a class to hold the state
class MovieDetailsProvider extends ChangeNotifier {
  String? _movieId;
  DetailsModel? _movieDetail;

  // Getter for movieId
  String? get movieId => _movieId;

  // Setter for movieId
  void setMovieId(String? id) {
    _movieId = id;
    // Fetch details when movieId changes
    _fetchMovieDetails();
  }

  // Getter for movieDetail
  DetailsModel? get movieDetail => _movieDetail;

  void setMovieDetail(DetailsModel movieDetail) {
    _movieDetail = movieDetail;
    notifyListeners();
  }

  // Fetch movie details from API
  Future<void> _fetchMovieDetails() async {
    if (_movieId != null) {
      // Fetch movie details based on movieId
      final details = await FetchAPI.getdetails(_movieId!);
      if (details != null) {
        _movieDetail = details;
        notifyListeners();
      }
    }
  }
}
