import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_food_otus/model/recipe.dart';
import 'package:flutter_food_otus/domain/repository.dart';

class FakeRecipesRepository implements Repository {
  @override
  Future<List<Recipe>> fetchRecipes() async {
    final List<Recipe> recipes = [];
    final String jsonString = await rootBundle.loadString(
      'assets/fake/recipes.json',
    );

    final List<dynamic> jsonList = jsonDecode(jsonString);

    for (var json in jsonList) {
      recipes.add(Recipe.fromJson(json));
    }

    return recipes;
  }
}
