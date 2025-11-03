import 'package:flutter_food_otus/model/Ingredient.dart' show Ingredient;
import 'package:flutter_food_otus/model/recipe.dart';
import 'package:flutter_food_otus/domain/repository.dart';
import 'package:flutter_food_otus/model/recipe_step.dart';

class RecipesController {
  final Repository _repository;

  RecipesController({required Repository repository})
    : _repository = repository;

  Future<List<Recipe>> getRecipes() {
    return _repository.fetchRecipes();
  }

  Future<Recipe?> getRecipe(int recipeId) {
    return _repository.fetchRecipe(recipeId);
  }

  Future<List<RecipeStep>> getRecipeSteps(int recipeId) {
    return _repository.fetchRecipeStepsById(recipeId);
  }

  Future<List<Ingredient>> getRecipeIngredients(int recipeId) {
    return _repository.fetchIngredientsById(recipeId);
  }
}
