import 'package:flutter/material.dart';
import 'package:flutter_food_otus/theme/app_text_colors_extension.dart';

class DetailCard extends StatelessWidget {
  final String title;
  final String text;
  String? bottomText;
  final void Function() onEdit;
  final void Function() onDelete;

  DetailCard({
    super.key,
    required this.title,
    required this.text,
    this.bottomText,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              width: 2,
              color: context.appTextColors.secondaryTextColor,
            ),
          ),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: context.appTextColors.blackTextColor,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 12,
                      color: context.appTextColors.secondaryTextColor,
                    ),
                  ),

                  if (bottomText != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        bottomText!,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: context.appTextColors.blackTextColor,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: onEdit,
                icon: Icon(
                  Icons.edit,
                  color: context.appTextColors.mainTextColor,
                ),
              ),
              IconButton(
                onPressed: onDelete,
                icon: Icon(
                  Icons.delete,
                  color: context.appTextColors.mainTextColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
