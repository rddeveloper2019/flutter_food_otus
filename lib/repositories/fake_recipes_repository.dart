// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:flutter_food_otus/domain/repository.dart';
import 'package:flutter_food_otus/model/Ingredient.dart';
import 'package:flutter_food_otus/model/measure_simple_unit.dart';
import 'package:flutter_food_otus/model/recipe.dart';
import 'package:flutter_food_otus/model/recipe_ingredients_link.dart';
import 'package:flutter_food_otus/model/recipe_step_link.dart';
import 'package:flutter_food_otus/model/recipe_step.dart';

class FakeRecipesRepository implements Repository {
  List<Recipe> _recipes = [];
  List<Ingredient> _ingredients = [];
  List<RecipeStep> _steps = [];
  List<RecipeIngredientsLink> _recipeIngredientsLinks = [];
  List<RecipeStepLink> _recipeStepLinks = [];
  List<MeasureSimpleUnit> _measureSimpleUnits = [];

  Future<void> init() async {
    initRecipeSteps();
    initIngredients();
    initMeasureSimpleUnits();
    initRecipeStepsLinks();
    initRecipeIngredientsLinks();
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

  Future<void> initMeasureSimpleUnits() async {
    final String jsonString = await rootBundle.loadString(
      MeasureSimpleUnit.asset,
    );

    final List<dynamic> jsonList = jsonDecode(jsonString);

    for (var json in jsonList) {
      _measureSimpleUnits.add(MeasureSimpleUnit.fromJson(json));
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

    if (_measureSimpleUnits.isEmpty) {
      await initMeasureSimpleUnits();
    }

    final links = _recipeIngredientsLinks
        .where((ing) => ing.recipeId == id)
        .toList();

    final List<Ingredient> ingredients = [];

    for (var link in links) {
      final result = _ingredients.firstWhere(
        (ingredient) => ingredient.id == link.ingredientId,
      );
      final measureString = _measureSimpleUnits.firstWhere(
        (measure) => measure.id == result.measureSimpleUnitId,
      );
      result.measureString = measureString.unit;
      ingredients.add(result);
    }

    return ingredients;
  }
}
