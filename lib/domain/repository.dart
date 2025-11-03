import 'package:flutter_food_otus/model/Ingredient.dart';
import 'package:flutter_food_otus/model/recipe.dart';
import 'package:flutter_food_otus/model/recipe_step.dart';

abstract class Repository {
  Future<List<Recipe>> fetchRecipes();
  Future<Recipe?> fetchRecipe(int id);
  Future<List<Ingredient>> fetchIngredientsById(int id);
  Future<List<RecipeStep>> fetchRecipeStepsById(int id);
}
