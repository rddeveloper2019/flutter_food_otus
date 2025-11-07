class RecipeStepLink {
  final int id;
  final int number;
  final int recipeId;
  final int stepId;

  static const asset = 'assets/fake/recipe_step_links.json';

  RecipeStepLink({
    required this.id,
    required this.number,
    required this.recipeId,
    required this.stepId,
  });

  factory RecipeStepLink.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as int;
    final number = json['number'] as int;
    final recipeId = json['recipe']['id'] as int;
    final stepId = json['step']['id'] as int;

    return RecipeStepLink(
      id: id,
      number: number,
      recipeId: recipeId,
      stepId: stepId,
    );
  }

  @override
  String toString() {
    return "RecipeStepLink id: $id";
  }
}
