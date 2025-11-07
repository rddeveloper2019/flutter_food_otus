import 'package:flutter/material.dart';
import 'package:flutter_food_otus/theme/app_colors_extension.dart';
import 'package:flutter_food_otus/theme/app_text_colors_extension.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool filled;
  bool disabled;

  AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.filled = false,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final accentColor = context.appColors.accentColor;
    final mainColor = context.appColors.mainColor;
    final disabledColor = context.appTextColors.secondaryTextColor;
    final textColor = filled
        ? Colors.white
        : context.appTextColors.mainTextColor;

    final style = ButtonStyle(
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
      fixedSize: WidgetStateProperty.all(const Size(232, 48)),
    );

    if (filled) {
      return UnconstrainedBox(
        child: TextButton(
          onPressed: disabled ? null : onPressed,
          style: style.copyWith(
            backgroundColor: WidgetStateProperty.all(
              disabled ? disabledColor : accentColor,
            ),
            foregroundColor: WidgetStateProperty.all(Colors.white),
          ),
          child: Text(text, style: TextStyle(color: textColor)),
        ),
      );
    } else {
      return UnconstrainedBox(
        child: OutlinedButton(
          onPressed: disabled ? null : onPressed,
          style: style.copyWith(
            side: WidgetStateProperty.all(
              BorderSide(color: disabled ? disabledColor : mainColor, width: 3),
            ),
            foregroundColor: WidgetStateProperty.all(
              disabled ? disabledColor : mainColor,
            ),
          ),
          child: Text(
            text,
            style: TextStyle(color: disabled ? disabledColor : textColor),
          ),
        ),
      );
    }
  }
}
