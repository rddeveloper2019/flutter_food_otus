import 'package:flutter/material.dart';

class AppColors {
  static const Color mainBgColor = Color.fromRGBO(22, 89, 50, 1);
  static const Color accentBgColor = Color.fromRGBO(46, 204, 113, 1);
  static const Color scaffoldBgColor = Color.fromRGBO(236, 236, 236, 1);
}

class AppTypography {
  static const Color mainTextColor = Color.fromRGBO(22, 89, 50, 1);
  static const Color blackTextColor = Color.fromRGBO(0, 0, 0, 1);
  static const Color accentTextColor = Color.fromRGBO(46, 204, 113, 1);
  static const Color secondaryTextColor = Color.fromRGBO(121, 118, 118, 1);
}

class AppCards {
  static const Color cardColor = Color.fromRGBO(255, 255, 255, 1);

  static const TextStyle kCardTitle = TextStyle(
    fontSize: 22,
    color: AppTypography.blackTextColor,
    fontWeight: FontWeight.w500,
    overflow: TextOverflow.ellipsis,
  );

  static const TextStyle kCardSubtitle = TextStyle(
    fontSize: 16,
    color: AppTypography.accentTextColor,
  );
}
