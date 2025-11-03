class RecipeIngredientsLink {
  final int id;
  final int count;
  final int ingredientId;
  final int recipeId;

  static const asset = 'assets/fake/recipe_ingredients_link.json';
  RecipeIngredientsLink({
    required this.id,
    required this.count,
    required this.ingredientId,
    required this.recipeId,
  });

  factory RecipeIngredientsLink.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as int;
    final count = json['count'] as int;
    final recipeId = json['recipe']['id'] as int;
    final ingredientId = json['ingredient']['id'] as int;

    return RecipeIngredientsLink(
      id: id,
      count: count,
      recipeId: recipeId,
      ingredientId: ingredientId,
    );
  }

  @override
  String toString() {
    return "RecipeIngredientsLink id: $id";
  }
}
