import 'package:flutter/material.dart';
import 'package:flutter_food_otus/theme/app_colors_extension.dart';
import 'package:flutter_food_otus/theme/app_text_colors_extension.dart';
import 'package:flutter_food_otus/theme/app_colors.dart';

const MaterialColor primarySwatch = MaterialColor(0xFF165932, <int, Color>{
  50: Color(0xFFE8F5F0),
  100: Color(0xFFC1E2D0),
  200: Color(0xFF99D0B1),
  300: Color(0xFF71BE91),
  400: Color(0xFF55B17A),
  500: Color(0xFF165932),
  600: Color(0xFF134F2C),
  700: Color(0xFF104426),
  800: Color(0xFF0D3A20),
  900: Color(0xFF082B17),
});

class GreenTheme {
  GreenTheme._();

  static final ThemeData lightTheme = ThemeData(
    primarySwatch: primarySwatch,
    colorScheme: ColorScheme.fromSwatch(primarySwatch: primarySwatch),
    appBarTheme: AppBarTheme(
      backgroundColor: GreenLightThemeSurfaceColors.accentColor,
      foregroundColor: Colors.white,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: const CircleBorder(),
      backgroundColor: GreenLightThemeSurfaceColors.accentColor,
      foregroundColor: Colors.white,
    ),
    scaffoldBackgroundColor: GreenLightThemeSurfaceColors.secondaryColor,
    cardTheme: CardThemeData(color: GreenLightThemeSurfaceColors.lightSurface),
    extensions: <ThemeExtension<dynamic>>[
      AppColorsExtension(
        mainColor: GreenLightThemeSurfaceColors.mainColor,
        secondaryColor: GreenLightThemeSurfaceColors.secondaryColor,
        accentColor: GreenLightThemeSurfaceColors.accentColor,
        lightSurface: GreenLightThemeSurfaceColors.lightSurface,
      ),
      AppTextColorsExtension(
        accentTextColor: GreenLightThemeTypographyColors.accentTextColor,
        mainTextColor: GreenLightThemeTypographyColors.mainTextColor,
        blackTextColor: GreenLightThemeTypographyColors.blackTextColor,
        secondaryTextColor: GreenLightThemeTypographyColors.secondaryTextColor,
        lightText: GreenLightThemeTypographyColors.lightText,
      ),
    ],
  );
}
