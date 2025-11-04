// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';

import 'package:flutter_food_otus/domain/repository.dart';
import 'package:flutter_food_otus/model/Ingredient.dart';
import 'package:flutter_food_otus/model/measure_unit.dart';
import 'package:flutter_food_otus/model/recipe.dart';
import 'package:flutter_food_otus/model/recipe_ingredients_link.dart';
import 'package:flutter_food_otus/model/recipe_step_link.dart';
import 'package:flutter_food_otus/model/recipe_step.dart';
import 'package:flutter_food_otus/utils/ingredient_amount_parsers.dart';

class FakeRecipesRepository implements Repository {
  static final FakeRecipesRepository _instance =
      FakeRecipesRepository._internal();

  FakeRecipesRepository._internal();

  factory FakeRecipesRepository() => _instance;

  List<Recipe> _recipes = [];
  List<Ingredient> _ingredients = [];
  List<RecipeStep> _steps = [];
  List<RecipeIngredientsLink> _recipeIngredientsLinks = [];
  List<RecipeStepLink> _recipeStepLinks = [];
  List<MeasureUnit> _measureUnits = [];
  final _random = Random();

  int generateRandomId() {
    return _random.nextInt(1000000000);
  }

  Future<void> initRecipes() async {
    final String jsonString = await rootBundle.loadString(Recipe.asset);

    final List<dynamic> jsonList = jsonDecode(jsonString);

    for (var json in jsonList) {
      _recipes.add(Recipe.fromJson(json));
    }
  }

  Future<void> initRecipeSteps() async {
    final String jsonString = await rootBundle.loadString(RecipeStep.asset);

    final List<dynamic> jsonList = jsonDecode(jsonString);

    for (var json in jsonList) {
      _steps.add(RecipeStep.fromJson(json));
    }
  }

  Future<void> initIngredients() async {
    final String jsonString = await rootBundle.loadString(Ingredient.asset);

    final List<dynamic> jsonList = jsonDecode(jsonString);

    for (var json in jsonList) {
      _ingredients.add(Ingredient.fromJson(json));
    }
  }

  Future<void> initMeasureUnits() async {
    final String jsonString = await rootBundle.loadString(MeasureUnit.asset);

    final List<dynamic> jsonList = jsonDecode(jsonString);

    for (var json in jsonList) {
      _measureUnits.add(MeasureUnit.fromJson(json));
    }
  }

  Future<void> initRecipeStepsLinks() async {
    final String jsonString = await rootBundle.loadString(RecipeStepLink.asset);

    final List<dynamic> jsonList = jsonDecode(jsonString);

    for (var json in jsonList) {
      _recipeStepLinks.add(RecipeStepLink.fromJson(json));
    }
  }

  Future<void> initRecipeIngredientsLinks() async {
    final String jsonString = await rootBundle.loadString(
      RecipeIngredientsLink.asset,
    );

    final List<dynamic> jsonList = jsonDecode(jsonString);

    for (var json in jsonList) {
      _recipeIngredientsLinks.add(RecipeIngredientsLink.fromJson(json));
    }
  }

  @override
  Future<List<Recipe>> fetchRecipes() async {
    if (_recipes.isEmpty) {
      await initRecipes();
    }

    return _recipes;
  }

  @override
  Future<Recipe?> fetchRecipe(int id) async {
    if (_recipes.isEmpty) {
      await initRecipes();
    }

    return _recipes.firstWhere((recipe) => recipe.id == id);
  }

  @override
  Future<List<RecipeStep>> fetchRecipeStepsById(int id) async {
    if (_recipeStepLinks.isEmpty) {
      await initRecipeStepsLinks();
    }

    if (_steps.isEmpty) {
      await initRecipeSteps();
    }

    List<RecipeStepLink> links = _recipeStepLinks
        .where((link) => link.recipeId == id)
        .toList();

    links.sort((a, b) => a.number - b.number);

    final List<RecipeStep> recipeSteps = [];

    for (var link in links) {
      final step = _steps.firstWhere((step) => step.id == link.stepId);
      recipeSteps.add(step);
    }

    return recipeSteps;
  }

  @override
  Future<List<Ingredient>> fetchIngredientsById(int id) async {
    if (_recipeIngredientsLinks.isEmpty) {
      await initRecipeIngredientsLinks();
    }

    if (_ingredients.isEmpty) {
      await initIngredients();
    }

    if (_measureUnits.isEmpty) {
      await initMeasureUnits();
    }

    final links = _recipeIngredientsLinks
        .where((ing) => ing.recipeId == id)
        .toList();

    final List<Ingredient> ingredients = [];

    for (var link in links) {
      final result = _ingredients.firstWhere(
        (ingredient) => ingredient.id == link.ingredientId,
      );

      final measureUnit = _measureUnits.firstWhere(
        (measure) => measure.id == result.measureUnitId,
      );

      if (measureUnit != null) {
        result.measureString = formatIngredientAmount(
          count: link.count,
          measure: (
            one: measureUnit.one,
            few: measureUnit.few,
            many: measureUnit.many,
          ),
        );
      }

      ingredients.add(result);
    }

    return ingredients;
  }

  @override
  Future<void> createRecipe({
    required String name,
    required String photo,
    required List<IngredientView> ingredients,
    required List<RecipeStep> steps,
  }) async {
    final newRecipe = Recipe(
      id: generateRandomId(),
      name: name,
      photo: photo,
      duration: steps.fold(0, (sum, recipe) => sum + recipe.duration) ~/ 60,
    );
    _recipes.insert(0, newRecipe);
  }
}
