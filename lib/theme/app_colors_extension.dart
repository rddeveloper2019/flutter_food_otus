import 'package:flutter/material.dart';

class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  final Color mainColor;
  final Color accentColor;
  final Color secondaryColor;
  final Color lightSurface;

  const AppColorsExtension({
    required this.mainColor,
    required this.accentColor,
    required this.secondaryColor,
    required this.lightSurface,
  });

  @override
  ThemeExtension<AppColorsExtension> copyWith({
    Color? mainBgColor,
    Color? accentBgColor,
    Color? secondaryBgColor,
    Color? lightSurface,
  }) {
    return AppColorsExtension(
      mainColor: mainBgColor ?? this.mainColor,
      accentColor: accentBgColor ?? this.accentColor,
      secondaryColor: secondaryBgColor ?? this.secondaryColor,
      lightSurface: lightSurface ?? this.lightSurface,
    );
  }

  @override
  ThemeExtension<AppColorsExtension> lerp(
    covariant ThemeExtension<AppColorsExtension>? other,
    double t,
  ) {
    if (other == null || other is! AppColorsExtension) {
      return this;
    }

    return AppColorsExtension(
      mainColor: Color.lerp(mainColor, other.mainColor, t)!,
      accentColor: Color.lerp(accentColor, other.accentColor, t)!,
      secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t)!,
      lightSurface: Color.lerp(lightSurface, other.lightSurface, t)!,
    );
  }
}

extension AppColorsExtensionContext on BuildContext {
  AppColorsExtension get appColors =>
      Theme.of(this).extension<AppColorsExtension>()!;
}
