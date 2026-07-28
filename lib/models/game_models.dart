class GameModel {
  final String name;
  final String image;
  final double rating;
  final String released;
  final List<String> genres;

  GameModel({
    required this.name,
    required this.image,
    required this.rating,
    required this.released,
    required this.genres,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) {
    var genresList = (json['genres'] as List?)
            ?.map((genre) => genre['name'].toString())
            .toList() ??
        [];

    return GameModel(
      name: json['name'] ?? '',
      image: json['background_image'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      released: json['released'] ?? 'N/A',
      genres: List<String>.from(genresList),
    );
  }
}