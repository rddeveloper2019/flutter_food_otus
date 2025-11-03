// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_food_otus/domain/recipes_controller.dart';
import 'package:flutter_food_otus/model/Ingredient.dart';
import 'package:flutter_food_otus/model/recipe.dart';
import 'package:flutter_food_otus/model/recipe_step.dart';
import 'package:flutter_food_otus/repositories/fake_recipes_repository.dart';
import 'package:flutter_food_otus/theme/app_colors_extension.dart';
import 'package:flutter_food_otus/ui/recipes/widgets/app_input.dart';

class RecipeFormPage extends StatefulWidget {
  final int recipeId;
  const RecipeFormPage({super.key, required this.recipeId});

  @override
  State<RecipeFormPage> createState() => _RecipeFormPageState();
}

class _RecipeFormPageState extends State<RecipeFormPage> {
  final _controller = RecipesController(repository: FakeRecipesRepository());
  Recipe? recipe;
  List<Ingredient>? ingredients;
  List<RecipeStep>? steps;

  Future<void> init() async {
    recipe = await _controller.getRecipe(widget.recipeId);
    ingredients = await _controller.getRecipeIngredients(widget.recipeId);
    steps = await _controller.getRecipeSteps(widget.recipeId);
    print(recipe);
    print(ingredients);
    print(steps);
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.lightSurface,
      appBar: AppBar(
        elevation: 3,
        title: Text("Новый рецепт"),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back, color: context.appColors.mainColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [AppInput(labelText: "Название рецепта", numeric: true)],
          ),
        ),
      ),
    );
  }
}
