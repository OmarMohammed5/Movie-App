class ActorMovieModel {
  final int id;
  final String? poster;
  final String title;
  final String? date;
  final String? character;

  ActorMovieModel({
    required this.id,
    required this.poster,
    required this.title,
    required this.date,
    this.character,
  });

  factory ActorMovieModel.from(Map<String, dynamic> jsonData) {
    return ActorMovieModel(
      id: jsonData['id'],
      poster: jsonData['poster_path'],
      title: jsonData['title'],
      date: jsonData['release_date'],
      character: jsonData['character'] ?? "_",
    );
  }

  String get year {
    if (date == null || date!.isEmpty) return "-";
    final parts = date!.split("-");
    return parts.isNotEmpty ? parts.first : "-";
  }

  String get posterUrl =>
      poster != null ? "https://image.tmdb.org/t/p/w500$poster" : "";
}
