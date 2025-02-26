import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static const String baseUrl = "api.themoviedb.org";
  static String? apiKey = dotenv.env['HTTP_API_KEY_BROWSER'];
  static const String imageBaseUrl = "https://image.tmdb.org/t/p/w500";
}
