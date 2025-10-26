import 'package:flutter/material.dart';
import 'package:flutter_food_otus/theme/app_colors_extension.dart';
import 'package:flutter_food_otus/theme/app_colors.dart';

class DurationWidget extends StatelessWidget {
  final int duration;

  const DurationWidget({super.key, required this.duration});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.alarm),
        SizedBox(width: 12),
        Text(
          "${duration.toString()} минут",
          style: TextStyle(fontSize: 16, color: context.appColors.accentColor),
        ),
      ],
    );
  }
}
