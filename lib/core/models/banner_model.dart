class BannerModel {
  final String banner;
  final String title;

  BannerModel({required this.title, required this.banner});

  factory BannerModel.from(Map<String, dynamic> jsonData) {
    return BannerModel(
      banner: jsonData['backdrop_path'] != null
          ? "https://image.tmdb.org/t/p/w500${jsonData['backdrop_path']}"
          : "",
      title: jsonData['title'] ?? "",
    );
  }
}
