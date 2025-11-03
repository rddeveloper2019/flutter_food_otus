import 'package:flutter/material.dart';
import 'package:flutter_food_otus/theme/app_colors_extension.dart';
import 'package:flutter_food_otus/theme/app_text_colors_extension.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool filled;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    final accentColor = context.appColors.accentColor;
    final mainColor = context.appColors.mainColor;
    final textColor = filled
        ? Colors.white
        : context.appTextColors.mainTextColor;

    if (filled) {
      return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: accentColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text(text, style: TextStyle(color: textColor)),
      );
    } else {
      return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: mainColor, width: 3),
          foregroundColor: mainColor,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text(text, style: TextStyle(color: textColor)),
      );
    }
  }
}
