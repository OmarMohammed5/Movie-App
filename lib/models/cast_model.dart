class CastModel {
  final int id;
  final String name;
  final String character;
  final String? profilePath;
  final String originalName;

  CastModel({
    required this.originalName,
    required this.id,
    required this.name,
    required this.character,
    this.profilePath,
  });

  factory CastModel.from(Map<String, dynamic> jsonData) {
    return CastModel(
      id: jsonData['id'],
      name: jsonData['name'] ?? "Unknown",
      character: jsonData['character'] ?? "_",
      profilePath: jsonData['profile_path'] != null
          ? "https://image.tmdb.org/t/p/w500${jsonData['profile_path']}"
          : null,
      originalName: jsonData['original_name'],
    );
  }
}
