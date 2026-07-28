import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/game_models.dart';
import '../utils/constants.dart';

class ApiService {

  Future<List<GameModel>> fetchGames({String? query}) async {

    // Si hay query, lo añadimos a la URL
    final searchQuery = (query != null && query.isNotEmpty) ? '&search=$query' : '';

    final url =
        '${Constants.baseUrl}?platforms=9&ordering=-rating&page_size=40&key=${Constants.apiKey}$searchQuery';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);
      final List results = data['results'];
      // Convertimos de Map a GameModel
      return results.map((game) => GameModel.fromJson(game)).toList();

    } else {

      throw Exception('Error al cargar juegos');
    }
  }
}