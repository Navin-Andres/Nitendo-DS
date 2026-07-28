import 'package:flutter/material.dart';

import '../services/api_service.dart';
import '../widgtes/game_card.dart';
import 'game_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  String? selectedGenre;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        title: Row(
          children: [
            Image.asset(
              'assets/palanca-de-mando.png',
              height: 30,
            ),
            const SizedBox(width: 8),
            const Text('R4 ROMs Library'),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: GameSearchDelegate(apiService: apiService),
              );
            },
          ),
        ],
      ),

      body: FutureBuilder(

        future: apiService.fetchGames(),

        builder: (context, snapshot) {

          if (snapshot.connectionState ==
              ConnectionState.waiting) {

            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {

            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }

          final games = snapshot.data!;

          // Obtener géneros únicos
          final genres = <String>{};
          for (var game in games) {
            genres.addAll(game.genres);
          }

          // Filtrar juegos por género seleccionado
          final filteredGames = selectedGenre == null
              ? games
              : games.where((game) => game.genres.contains(selectedGenre)).toList();

          return Column(
            children: [
              // Botones de géneros
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      FilterChip(
                        label: const Text('Todos'),
                        selected: selectedGenre == null,
                        backgroundColor: Colors.grey.shade200,
                        selectedColor: Colors.red,
                        labelStyle: TextStyle(
                          color: selectedGenre == null ? Colors.white : Colors.black,
                        ),
                        onSelected: (_) {
                          setState(() {
                            selectedGenre = null;
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      ...genres.map((genre) {
                        final isSelected = selectedGenre == genre;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: FilterChip(
                            label: Text(genre),
                            selected: isSelected,
                            backgroundColor: Colors.grey.shade200,
                            selectedColor: Colors.red,
                            labelStyle: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                            onSelected: (_) {
                              setState(() {
                                selectedGenre = isSelected ? null : genre;
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
              // Lista de juegos
              Expanded(
                child: ListView.builder(
                  itemCount: filteredGames.length,
                  itemBuilder: (context, index) {
                    final game = filteredGames[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: GameCard(
                        title: game.name,
                        image: game.image,
                        rating: game.rating,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GameDetailScreen(game: game),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class GameSearchDelegate extends SearchDelegate {
  final ApiService apiService;

  GameSearchDelegate({required this.apiService});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '', // Limpia el texto de búsqueda
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null), // Cierra el buscador
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    if (query.isEmpty) {
      return const Center(child: Text('Busca tu juego favorito'));
    }

    return FutureBuilder(
      future: apiService.fetchGames(query: query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No se encontraron juegos'));
        }

        final games = snapshot.data!;
        return ListView.builder(
          itemCount: games.length,
          itemBuilder: (context, index) {
            final game = games[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: GameCard(
                title: game.name,
                image: game.image,
                rating: game.rating,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GameDetailScreen(game: game),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}