import 'package:flutter/material.dart';
import 'package:flutter_food_otus/theme/app_colors.dart';
import 'package:flutter_food_otus/ui/recipes/widgets/decorated_container.dart';

class AddPhotoWidget extends StatelessWidget {
  final String text;
  void Function() onClick;

  AddPhotoWidget({
    super.key,
    required this.onClick,
    this.text = 'Добавить фото',
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedContainer(
      child: Material(
        color: Colors.transparent,

        child: InkWell(
          onTap: onClick,
          borderRadius: BorderRadius.circular(5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.add_a_photo,
                size: 48,
                color: GreenLightThemeTypographyColors.mainTextColor,
              ),
              SizedBox(height: 8),
              Text(
                text,

                style: TextStyle(
                  color: GreenLightThemeTypographyColors.mainTextColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
