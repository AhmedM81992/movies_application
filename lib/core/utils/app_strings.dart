import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppStrings {
  static String? headerApiKey = dotenv.env['MOVIE_HEADER_API_KEY'];
}
