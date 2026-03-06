// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_food_otus/domain/recipes_controller.dart';
import 'package:flutter_food_otus/model/Ingredient.dart';
import 'package:flutter_food_otus/model/measure_unit.dart';
import 'package:flutter_food_otus/model/recipe_step.dart';
import 'package:flutter_food_otus/repositories/fake_recipes_repository.dart';
import 'package:flutter_food_otus/theme/app_colors_extension.dart';
import 'package:flutter_food_otus/typedefs.dart';
import 'package:flutter_food_otus/ui/recipes/widgets/add_ingredient_dialog.dart';
import 'package:flutter_food_otus/ui/recipes/widgets/add_photo_widget.dart';
import 'package:flutter_food_otus/ui/recipes/widgets/add_step_dialog.dart';
import 'package:flutter_food_otus/ui/recipes/widgets/app_button.dart';
import 'package:flutter_food_otus/ui/recipes/widgets/app_input.dart';
import 'package:flutter_food_otus/ui/recipes/widgets/detail_card.dart';
import 'package:flutter_food_otus/ui/recipes/widgets/details_list.dart';
import 'package:flutter_food_otus/utils/format_duration.dart';
import 'package:flutter_food_otus/utils/ingredient_amount_parsers.dart';
import 'package:flutter_food_otus/utils/input_validators.dart';

class RecipeFormPage extends StatefulWidget {
  const RecipeFormPage({super.key});

  @override
  State<RecipeFormPage> createState() => _RecipeFormPageState();
}

class _RecipeFormPageState extends State<RecipeFormPage> {
  final _controller = RecipesController(repository: FakeRecipesRepository());

  List<RecipeStep> _steps = [];
  List<IngredientView> _ingredients = [];
  String? _recipePhoto;
  String? _recipeName;

  final GlobalKey<FormState> _newRecipeFormKey = GlobalKey<FormState>();

  final TextEditingController _nameCtr = TextEditingController();
  final TextEditingController _ingredientNameCtr = TextEditingController();
  final TextEditingController _ingredientCountCtr = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameCtr.addListener(_onNameChanged);
  }

  @override
  void dispose() {
    _nameCtr.removeListener(_onNameChanged);
    _nameCtr.dispose();
    _ingredientNameCtr.dispose();
    _ingredientCountCtr.dispose();
    super.dispose();
  }

  void _onNameChanged() {
    if (mounted) {
      setState(() {
        _recipeName = _nameCtr.text;
      });
    }
  }

  Future<void> onSubmit() async {
    if (_newRecipeFormKey.currentState?.validate() ?? false) {
      _newRecipeFormKey.currentState?.save();

      await _controller.createRecipe(
        name: _recipeName!,
        photo: _recipePhoto!,
        ingredients: _ingredients,
        steps: _steps,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final disabled =
        _recipeName == null ||
        _recipeName!.trim().isEmpty ||
        _steps.isEmpty ||
        _ingredients.isEmpty ||
        _recipePhoto == null;

    return Scaffold(
      backgroundColor: context.appColors.lightSurface,
      appBar: AppBar(
        elevation: 3,
        title: Text("Новый рецепт"),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: OrientationBuilder(
            builder: (context, orientation) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  final maxWidth = orientation == Orientation.landscape
                      ? constraints.maxWidth * 0.5
                      : constraints.maxWidth;
                  return Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: maxWidth),
                      child: Form(
                        key: _newRecipeFormKey,
                        child: Column(
                          children: [
                            AppInput(
                              labelText: "Название рецепта",
                              controller: _nameCtr,
                              validator: validateRecipeName,
                            ),
                            SizedBox(height: 17),
                            AddPhotoWidget(
                              text: 'Добавить фото рецепта',
                              photo: _recipePhoto ?? '',
                              onClick: () {
                                FocusScope.of(context).unfocus(
                                  disposition: UnfocusDisposition.scope,
                                );
                                setState(() {
                                  _recipePhoto =
                                      "https://cdn.dummyjson.com/recipe-images/${Random().nextInt(50)}.webp";
                                });
                              },
                            ),

                            SizedBox(height: 17),
                            DetailsList(
                              list: _ingredients.map((ingredient) {
                                final formattedAmount = formatIngredientAmount(
                                  count: ingredient.count,
                                  measure: (
                                    one: ingredient.measureUnit.one,
                                    few: ingredient.measureUnit.few,
                                    many: ingredient.measureUnit.many,
                                  ),
                                );

                                return DetailCard(
                                  title: ingredient.name,
                                  text: formattedAmount,
                                  onEdit: () {},
                                  onDelete: () {},
                                );
                              }).toList(),
                              buttonText: 'Добавить ингредиент',
                              onAdd: () async {
                                FocusScope.of(context).unfocus(
                                  disposition: UnfocusDisposition.scope,
                                );
                                final input =
                                    await showDialog<IngredientInputResult>(
                                      context: context,
                                      builder: (context) =>
                                          const AddIngredientDialog(),
                                    );

                                if (input != null) {
                                  final name = input.name;
                                  final count = input.ingredient.count;
                                  final measureData = input.ingredient.measure;

                                  setState(() {
                                    _ingredients.add(
                                      IngredientView(
                                        name: name,
                                        count: count,
                                        measureUnit: MeasureUnit(
                                          one: measureData.one,
                                          few: measureData.few,
                                          many: measureData.many,
                                        ),
                                      ),
                                    );
                                  });
                                }
                              },
                              title: 'Ингредиенты',
                              emptyText: 'нет ингредиентов',
                            ),
                            SizedBox(height: 17),
                            DetailsList(
                              list: _steps.asMap().entries.map((entry) {
                                final index = entry.key;
                                final step = entry.value;
                                return DetailCard(
                                  title: "Шаг ${index + 1}",
                                  text: step.name,
                                  onEdit: () {},
                                  onDelete: () {},
                                  bottomText: formatDuration(step.duration),
                                );
                              }).toList(),
                              buttonText: 'Добавить шаг',
                              onAdd: () async {
                                FocusScope.of(context).unfocus(
                                  disposition: UnfocusDisposition.scope,
                                );
                                final input = await showDialog<StepInputResult>(
                                  context: context,
                                  builder: (context) => const AddStepDialog(),
                                );

                                if (input != null) {
                                  final name = input.name;
                                  final minutes = input.minutes;
                                  final seconds = input.seconds;

                                  setState(() {
                                    _steps.add(
                                      RecipeStep(
                                        name: name,
                                        duration: minutes * 60 + seconds,
                                      ),
                                    );
                                  });
                                }
                              },
                              title: 'Шаги приготовления',
                              emptyText: 'нет шагов приготовления',
                            ),
                            SizedBox(height: 17),
                            AppButton(
                              text: 'Добавить ингредиент',
                              disabled: disabled,
                              onPressed: () async {
                                FocusScope.of(context).unfocus(
                                  disposition: UnfocusDisposition.scope,
                                );
                                await onSubmit();
                                Navigator.of(context).pop(true);
                              },
                              filled: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
