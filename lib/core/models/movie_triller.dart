class MovieTrailer {
  final String key;
  final String site;
  final String type;

  MovieTrailer({required this.key, required this.site, required this.type});

  factory MovieTrailer.from(Map<String, dynamic> jsonData) {
    return MovieTrailer(
      key: jsonData['key'],
      site: jsonData['site'],
      type: jsonData['type'],
    );
  }
}
