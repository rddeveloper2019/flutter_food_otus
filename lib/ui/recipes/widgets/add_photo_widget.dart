import 'package:flutter/material.dart';
import 'package:flutter_food_otus/theme/app_text_colors_extension.dart';
import 'package:flutter_food_otus/ui/recipes/widgets/decorated_container.dart';

class AddPhotoWidget extends StatelessWidget {
  final String text;
  String photo;
  void Function() onClick;

  AddPhotoWidget({
    super.key,
    required this.onClick,
    this.text = 'Добавить фото',
    this.photo = '',
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,

      child: InkWell(
        onTap: onClick,
        borderRadius: BorderRadius.circular(5),

        child: photo.isNotEmpty
            ? SizedBox(
                height: 215,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(photo, fit: BoxFit.cover),
                ),
              )
            : DecoratedContainer(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.add_a_photo,
                      size: 48,
                      color: context.appTextColors.mainTextColor,
                    ),
                    SizedBox(height: 8),
                    Text(
                      text,

                      style: TextStyle(
                        color: context.appTextColors.mainTextColor,
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
