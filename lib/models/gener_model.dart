class GenerModel {
  final int id;
  final String name;

  GenerModel({required this.id, required this.name});

  factory GenerModel.from(Map<String, dynamic> jsonData) {
    return GenerModel(id: jsonData['id'], name: jsonData['name']);
  }
}
