class MovieModel {
  final int id;
  final String title;
  final String poster;
  final double voteAverage;
  final String? releaseDate;
  final String overview;

  MovieModel({
    required this.id,
    required this.title,
    required this.poster,
    required this.voteAverage,
    required this.releaseDate,
    required this.overview,
  });

  factory MovieModel.from(Map<String, dynamic> jsonData) {
    return MovieModel(
      id: jsonData['id'],
      title: jsonData['title'],
      poster: "https://image.tmdb.org/t/p/w500${jsonData['poster_path']}",
      voteAverage: (jsonData['vote_average'] as num).toDouble(),
      releaseDate: jsonData['release_date'],
      overview: jsonData['overview'],
    );
  }

  String get year {
    if (releaseDate == null || releaseDate!.isEmpty) return "-";
    final parts = releaseDate!.split("-");
    return parts.isNotEmpty ? parts.first : "-";
  }
}
