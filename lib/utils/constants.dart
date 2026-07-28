import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static String apiKey = dotenv.env['API_KEY'] ?? '';
  static const baseUrl = 'https://api.rawg.io/api/games';
}