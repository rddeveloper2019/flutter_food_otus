import 'package:flutter_food_otus/model/recipe.dart';
import 'package:flutter_food_otus/domain/repository.dart';

class RecipesController {
  final Repository _repository;

  RecipesController({required Repository repository})
    : _repository = repository;

  Future<List<Recipe>> getRecipes() {
    return _repository.fetchRecipes();
  }
}
