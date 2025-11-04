// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_food_otus/domain/recipes_controller.dart';
import 'package:flutter_food_otus/model/Ingredient.dart';
import 'package:flutter_food_otus/model/recipe.dart';
import 'package:flutter_food_otus/model/recipe_step.dart';
import 'package:flutter_food_otus/repositories/fake_recipes_repository.dart';
import 'package:flutter_food_otus/theme/app_colors_extension.dart';
import 'package:flutter_food_otus/ui/recipes/widgets/add_ingredient_dialog.dart';
import 'package:flutter_food_otus/ui/recipes/widgets/add_photo_widget.dart';
import 'package:flutter_food_otus/ui/recipes/widgets/add_step_dialog.dart';
import 'package:flutter_food_otus/ui/recipes/widgets/app_button.dart';
import 'package:flutter_food_otus/ui/recipes/widgets/app_input.dart';
import 'package:flutter_food_otus/ui/recipes/widgets/details_list.dart';

class RecipeFormPage extends StatefulWidget {
  final int recipeId;
  const RecipeFormPage({super.key, required this.recipeId});

  @override
  State<RecipeFormPage> createState() => _RecipeFormPageState();
}

class _RecipeFormPageState extends State<RecipeFormPage> {
  final _controller = RecipesController(repository: FakeRecipesRepository());
  Recipe? recipe;
  List<Ingredient> _ingredients = [];
  List<RecipeStep> _steps = [];
  String photo = '';
  String name = '';

  final GlobalKey<FormState> _newRecipeFormKey = GlobalKey<FormState>();

  final TextEditingController _nameCtr = TextEditingController();
  final TextEditingController _ingredientNameCtr = TextEditingController();
  final TextEditingController _ingredientCountCtr = TextEditingController();

  Future<void> init() async {
    recipe = await _controller.getRecipe(widget.recipeId);
    _ingredients = await _controller.getRecipeIngredients(widget.recipeId);
    _steps = await _controller.getRecipeSteps(widget.recipeId);

    print(recipe);
    print(_ingredients);
    print(_steps);
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    _nameCtr.dispose();
    _ingredientNameCtr.dispose();
    _ingredientCountCtr.dispose();
    super.dispose();
  }

  void onSubmit() {
    String name = _nameCtr.text;
    print('Сохранено: $name');
    if (_newRecipeFormKey.currentState?.validate() ?? false) {
      _newRecipeFormKey.currentState?.save();
    }
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
          child: Form(
            key: _newRecipeFormKey,
            child: Column(
              children: [
                AppInput(
                  labelText: "Название рецепта",
                  controller: _nameCtr,
                  validator: (String? string) {
                    return (string == null || string.isEmpty)
                        ? 'Введите название рецепта'
                        : null;
                  },
                ),
                SizedBox(height: 17),
                AddPhotoWidget(
                  text: 'Добавить фото рецепта',
                  photo: photo,
                  onClick: () {
                    setState(() {
                      photo =
                          "https://cdn.dummyjson.com/recipe-images/${Random().nextInt(50)}.webp";
                    });
                  },
                ),

                SizedBox(height: 17),
                DetailsList(
                  list: [],
                  buttonText: 'Добавить ингредиент',
                  onAdd: () async {
                    final result = await showDialog(
                      context: context,
                      builder: (context) => const AddIngredientDialog(),
                    );

                    if (result != null) {
                      final name = result['name'];
                      final count = result['count'];
                      print('Добавлен ингредиент: $name — $count');
                    }
                  },
                  title: 'Ингредиенты',
                  emptyText: 'нет ингредиентов',
                ),
                SizedBox(height: 17),
                DetailsList(
                  list: [],
                  buttonText: 'Добавить шаг',
                  onAdd: () async {
                    final result = await showDialog(
                      context: context,
                      builder: (context) => const AddStepDialog(),
                    );

                    if (result != null) {
                      final text = result['text'];
                      final minutes = result['minutes'];
                      final seconds = result['seconds'];
                      print('Добавлен ингредиент: $text — $minutes - $seconds');
                    }
                  },
                  title: 'Шаги приготовления',
                  emptyText: 'нет шагов приготовления',
                ),
                SizedBox(height: 17),
                AppButton(
                  text: 'Добавить ингредиент',
                  onPressed: onSubmit,
                  filled: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
