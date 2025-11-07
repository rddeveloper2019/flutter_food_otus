// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_otus/theme/app_colors_extension.dart';

class DecoratedContainer extends StatelessWidget {
  final Widget child;
  double height = 215;
  DecoratedContainer({super.key, required this.child, this.height = 215});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        radius: Radius.circular(5),
        dashPattern: [16, 16],
        strokeWidth: 2,
        color: context.appColors.mainColor,
        borderPadding: EdgeInsets.all(2),
      ),
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: context.appColors.secondaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(child: child),
      ),
    );
  }
}
