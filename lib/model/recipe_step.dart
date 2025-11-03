class RecipeStep {
  final int id;
  final String name;
  final int duration;

  static const asset = 'assets/fake/recipe_steps.json';

  RecipeStep({required this.id, required this.name, required this.duration});

  factory RecipeStep.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as int;
    final name = json['name'] as String;
    final duration = json['duration'] as int;

    return RecipeStep(id: id, name: name, duration: duration);
  }

  @override
  String toString() {
    return "$name - $duration секунд";
  }
}
