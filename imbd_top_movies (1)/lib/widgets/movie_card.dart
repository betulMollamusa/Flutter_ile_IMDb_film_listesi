import 'package:flutter/material.dart';
import '../models/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const MovieCard({
    super.key,
    required this.movie,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        title: Text(movie.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text(
            "IMDb: ${movie.rating} | ${movie.year} | Yönetmen: ${movie.director}"),
        trailing: IconButton(
          icon: Icon(isFavorite ? Icons.star : Icons.star_border,
              color: isFavorite ? Colors.amber : Colors.grey),
          onPressed: onFavoriteToggle,
        ),
      ),
    );
  }
}
