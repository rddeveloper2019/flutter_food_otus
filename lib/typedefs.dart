typedef IngredientResult = ({
  int count,
  ({String one, String few, String many}) measure,
});

typedef IngredientInputResult = ({
  String name,
  IngredientResult ingredient, // ← имя поля: ingredient
});
typedef StepInputResult = ({String name, int minutes, int seconds});
