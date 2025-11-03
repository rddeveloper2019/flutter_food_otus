class Recipe {
  final int id;
  final String name;
  final int duration;
  final String photo;

  static const asset = 'assets/fake/recipes.json';

  Recipe({
    required this.id,
    required this.name,
    required this.duration,
    required this.photo,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as int;
    final name = json['name'] as String;
    final duration = json['duration'] as int;
    final photo = json['photo'] as String;

    return Recipe(id: id, name: name, duration: duration, photo: photo);
  }

  @override
  String toString() {
    return name;
  }
}
