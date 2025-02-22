import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static const String BASE_URL = "api.themoviedb.org";
  static String? API_KEY = dotenv.env['HTTP_API_KEY_BROWSER'];
  static const String IMAGE_BASE_URL = "https://image.tmdb.org/t/p/w500";
}
