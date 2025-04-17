class Movie {
  final String title;
  final String year;
  final String rating;
  final String director;

  Movie(
      {required this.title,
      required this.year,
      required this.rating,
      required this.director});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['Movie'],
      year: json['Released_year'].toString(),
      rating: json['Rating'].toString(),
      director: json['Director'],
    );
  }
}
