import 'package:flutter/material.dart';

class AppTextColorsExtension extends ThemeExtension<AppTextColorsExtension> {
  final Color mainTextColor;
  final Color blackTextColor;
  final Color accentTextColor;
  final Color secondaryTextColor;
  final Color lightText;

  const AppTextColorsExtension({
    required this.mainTextColor,
    required this.blackTextColor,
    required this.accentTextColor,
    required this.secondaryTextColor,
    required this.lightText,
  });

  @override
  ThemeExtension<AppTextColorsExtension> copyWith({
    Color? mainTextColor,
    Color? blackTextColor,
    Color? accentTextColor,
    Color? secondaryTextColor,
    Color? lightText,
  }) {
    return AppTextColorsExtension(
      mainTextColor: mainTextColor ?? this.mainTextColor,
      blackTextColor: blackTextColor ?? this.blackTextColor,
      accentTextColor: accentTextColor ?? this.accentTextColor,
      secondaryTextColor: secondaryTextColor ?? this.secondaryTextColor,
      lightText: lightText ?? this.lightText,
    );
  }

  @override
  ThemeExtension<AppTextColorsExtension> lerp(
    covariant ThemeExtension<AppTextColorsExtension>? other,
    double t,
  ) {
    if (other == null || other is! AppTextColorsExtension) {
      return this;
    }

    return AppTextColorsExtension(
      mainTextColor: Color.lerp(mainTextColor, other.mainTextColor, t)!,
      blackTextColor: Color.lerp(blackTextColor, other.blackTextColor, t)!,
      accentTextColor: Color.lerp(accentTextColor, other.accentTextColor, t)!,
      lightText: Color.lerp(lightText, other.lightText, t)!,
      secondaryTextColor: Color.lerp(
        secondaryTextColor,
        other.secondaryTextColor,
        t,
      )!,
    );
  }
}

extension AppTextColorsExtensionContext on BuildContext {
  AppTextColorsExtension get appTextColors =>
      Theme.of(this).extension<AppTextColorsExtension>()!;
}
