import 'package:flutter_food_otus/model/recipe.dart';

abstract class Repository {
  Future<List<Recipe>> fetchRecipes();
}
