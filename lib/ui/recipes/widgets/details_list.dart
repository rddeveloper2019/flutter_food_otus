import 'package:flutter/material.dart';
import 'package:flutter_food_otus/theme/app_text_colors_extension.dart';
import 'package:flutter_food_otus/ui/recipes/widgets/app_button.dart';
import 'package:flutter_food_otus/ui/recipes/widgets/detail_card.dart';

class DetailsList extends StatelessWidget {
  final List<DetailCard> list;
  final String buttonText;
  final String title;
  final String emptyText;
  final VoidCallback onAdd;

  const DetailsList({
    super.key,
    required this.list,
    required this.buttonText,
    required this.onAdd,
    required this.title,
    required this.emptyText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          textAlign: TextAlign.left,
          title,
          style: TextStyle(
            color: context.appTextColors.mainTextColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),

        if (list.isEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              textAlign: TextAlign.center,
              emptyText,
              style: TextStyle(
                color: context.appTextColors.secondaryTextColor,
                fontSize: 12,
              ),
            ),
          ),

        if (list.isNotEmpty)
          ...list.map(
            (element) => Padding(
              padding: EdgeInsetsGeometry.only(top: 16),
              child: element,
            ),
          ),
        const SizedBox(height: 12),
        AppButton(text: buttonText, onPressed: onAdd),
      ],
    );
  }
}
