//ERCİYES ÜNİVERİSTESİ
//MÜHENDİSLİK FAKÜLTESİ
//BİLGİSAYASAR MÜHERNDİSLİĞİ
//Dr. Öğr. Üyesi FEHİM KÖYLÜ - Mobile Application Development dersi kapsamında geliştirilen proje ödevi



import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/movie_list_screen.dart';
import 'screens/favorites_screen.dart';
import 'models/movie.dart';
import 'widgets/ad_banner.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Set<String> favorites = {};
  List<Movie> allMovies = [];

  @override
  void initState() {
    super.initState();
    loadMovies();
  }

  Future<void> loadMovies() async {
    final data = await rootBundle.loadString('assets/movies.json');
    final List decoded = json.decode(data);
    setState(() {
      allMovies = decoded.map((json) => Movie.fromJson(json)).toList();
    });
  }

  void toggleFavorite(String title) {
    setState(() {
      favorites.contains(title)
          ? favorites.remove(title)
          : favorites.add(title);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMDb Top Movies',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text("IMDb Top 250"),
            actions: [
              IconButton(
                icon: const Icon(Icons.star),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavoritesScreen(
                        favorites: favorites,
                        allMovies: allMovies,
                        onFavoriteToggle: toggleFavorite,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          body: MovieListScreen(
            favorites: favorites,
            onFavoriteToggle: toggleFavorite,
          ),
        ),
      ),
    );
  }
}
