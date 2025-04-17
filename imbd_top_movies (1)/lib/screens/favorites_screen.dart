import 'package:flutter/material.dart';
import '../models/movie.dart';

class FavoritesScreen extends StatelessWidget {
  final Set<String> favorites;
  final List<Movie> allMovies;
  final Function(String) onFavoriteToggle;

  FavoritesScreen({
    required this.favorites,
    required this.allMovies,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    final favoriteMovies =
        allMovies.where((movie) => favorites.contains(movie.title)).toList();

    return Scaffold(
      appBar: AppBar(title: Text("Favori Filmler")),
      body: favoriteMovies.isEmpty
          ? Center(child: Text("Henüz favori film eklenmemiş"))
          : ListView.builder(
              itemCount: favoriteMovies.length,
              itemBuilder: (context, index) {
                final movie = favoriteMovies[index];
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(12),
                    title: Text(movie.title,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    subtitle: Text(
                        "IMDb: ${movie.rating} | ${movie.year} | Yönetmen: ${movie.director}"),
                    trailing: IconButton(
                      icon: Icon(Icons.star, color: Colors.amber),
                      onPressed: () => onFavoriteToggle(movie.title),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
