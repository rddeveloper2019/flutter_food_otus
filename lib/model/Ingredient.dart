import 'package:flutter_food_otus/model/measure_unit.dart';

class Ingredient {
  final int? id;
  final String name;
  final int caloriesForUnit;
  final int measureUnitId;
  String measureString = "";

  static const asset = 'assets/fake/ingredients.json';

  Ingredient({
    required this.name,
    required this.caloriesForUnit,
    required this.measureUnitId,
    this.id,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as int;
    final name = json['name'] as String;
    final caloriesForUnit = json['caloriesForUnit'] as int;
    final measureUnitId = json['measureUnit']['id'] as int;

    return Ingredient(
      id: id,
      name: name,
      caloriesForUnit: caloriesForUnit,
      measureUnitId: measureUnitId,
    );
  }

  @override
  String toString() {
    return "$name - $measureString - $measureUnitId";
  }
}

class IngredientView {
  final String name;
  final int count;
  final MeasureUnit measureUnit;

  IngredientView({
    required this.name,
    required this.count,
    required this.measureUnit,
  });

  @override
  String toString() {
    return "IngredientView: $name - $count - $measureUnit";
  }
}
