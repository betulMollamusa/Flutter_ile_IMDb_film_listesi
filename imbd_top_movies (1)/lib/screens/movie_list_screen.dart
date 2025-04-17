import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/movie.dart';
import '../widgets/movie_card.dart';
import '../widgets/ad_banner.dart';

class MovieListScreen extends StatefulWidget {
  final Set<String> favorites;
  final Function(String) onFavoriteToggle;

  const MovieListScreen(
      {required this.favorites, required this.onFavoriteToggle});

  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  List<Movie> movies = [];

  @override
  void initState() {
    super.initState();
    loadMovies();
  }

  Future<void> loadMovies() async {
    final data = await rootBundle.loadString('assets/movies.json');
    final List decoded = json.decode(data);
    setState(() {
      movies = decoded.map((json) => Movie.fromJson(json)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount:
          movies.length + (movies.length ~/ 5), // Her 5 öğe için reklam ekle
      itemBuilder: (context, index) {
        if ((index + 1) % 6 == 0)
          return const AdBanner(); // Her 5. öğe için reklam

        final realIndex = index - (index ~/ 6);
        final movie = movies[realIndex];
        final isFav = widget.favorites.contains(movie.title);
        return MovieCard(
          movie: movie,
          isFavorite: isFav,
          onFavoriteToggle: () => widget.onFavoriteToggle(movie.title),
        );
      },
    );
  }
}
