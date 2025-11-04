String? validIngredientAmount(String input) {
  final trimmed = input.trim();

  if (RegExp(r'^\d+\s+.+$').hasMatch(trimmed)) {
    return null;
  }

  return 'Формат: "5 cт.ложек", "10 г", "2 шт" и т.д.';
}

String? validIngredientName(value) {
  return value?.isEmpty == true ? 'Введите название ингредиента' : null;
}

String? validIngredientCount(value) {
  return (value?.isEmpty == true || value == null)
      ? 'Введите количество'
      : validIngredientAmount(value);
}

String? validateNumber(String? value, {bool isSeconds = false}) {
  if (value == null || value.isEmpty) {
    return null;
  }
  final parsed = int.tryParse(value);

  if (parsed == null || parsed <= 0) {
    return 'Должно быть больше 0';
  }
  if (isSeconds && parsed > 59) {
    return 'Не больше 59';
  }
  return null;
}

String? validateRecipeName(String? string) {
  return (string == null || string.isEmpty) ? 'Введите название рецепта' : null;
}
