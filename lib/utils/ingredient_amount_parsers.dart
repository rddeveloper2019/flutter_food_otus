import 'package:flutter_food_otus/typedefs.dart';

IngredientResult parseIngredientAmount(String input) {
  final trimmed = input.trim();
  final match = RegExp(r'^(\d+)\s+(.+)$').firstMatch(trimmed);

  if (match == null) {
    throw FormatException('Неверный формат строки: $input');
  }

  final count = int.parse(match.group(1)!);
  final unitText = match.group(2)!;

  String one = '', few = '', many = '';

  if (count == 1) {
    one = unitText;
  } else if (_isFew(count)) {
    few = unitText;
  } else {
    many = unitText;
  }

  return (count: count, measure: (one: one, few: few, many: many));
}

String formatIngredientAmount({
  required int count,
  required ({String one, String few, String many}) measure,
}) {
  String unitText;
  if (count == 1) {
    unitText = measure.one;
  } else if (_isFew(count)) {
    unitText = measure.few;
  } else {
    unitText = measure.many;
  }

  if (unitText.isEmpty) {
    return '$count';
  }

  return '$count $unitText';
}

bool _isFew(int n) {
  if (n % 100 >= 11 && n % 100 <= 14) return false;
  final lastDigit = n % 10;
  return lastDigit >= 2 && lastDigit <= 4;
}
