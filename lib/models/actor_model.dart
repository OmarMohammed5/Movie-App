class ActorModel {
  final int id;
  final String? image;
  final String name;
  final String knownForDepartment;
  final String birthday;
  final String? deathday;
  final String? placeOfBirth;
  final String biography;

  ActorModel({
    required this.id,
    required this.image,
    required this.name,
    required this.knownForDepartment,
    required this.birthday,
    required this.deathday,
    required this.placeOfBirth,
    required this.biography,
  });

  factory ActorModel.from(Map<String, dynamic> jsonData) {
    return ActorModel(
      id: jsonData['id'],
      image: jsonData['profile_path'] != null
          ? "https://image.tmdb.org/t/p/w500${jsonData['profile_path']}"
          : null,
      name: jsonData['name'] ?? "",
      knownForDepartment: jsonData['known_for_department'] ?? "",
      birthday: jsonData['birthday'],
      deathday: jsonData['deathday'] ?? "Alife",
      placeOfBirth: jsonData['place_of_birth'],
      biography: jsonData['biography'] ?? "",
    );
  }
}
