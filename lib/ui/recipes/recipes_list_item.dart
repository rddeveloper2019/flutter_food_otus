import 'package:flutter/material.dart';
import 'package:flutter_food_otus/model/recipe.dart';
import 'package:flutter_food_otus/theme/constants.dart';
import 'package:flutter_food_otus/ui/recipes/widgets/duration_widget.dart';

class RecipesListItem extends StatelessWidget {
  final Recipe recipe;
  const RecipesListItem({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        color: AppCards.cardColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color.fromRGBO(149, 146, 146, 0.1),
            offset: Offset(0.0, 4.0),
            blurRadius: 4.0,
          ),
        ],
        borderRadius: BorderRadius.all(const Radius.circular(5.0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch, // ← КЛЮЧЕВОЙ момент
        children: [
          SizedBox(
            width: 136,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                bottomLeft: Radius.circular(5),
              ),
              child: Image.network(
                recipe.photo,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) => progress == null
                    ? child
                    : const Center(child: CircularProgressIndicator()),
                errorBuilder: (context, error, stack) =>
                    const Icon(Icons.error),
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    recipe.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppCards.kCardTitle,
                  ),

                  DurationWidget(duration: recipe.duration),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
