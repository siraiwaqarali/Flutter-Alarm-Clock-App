import 'package:flutter/material.dart';

@immutable
class AppColors {
  static const Color primaryTextColor = Colors.white;
  static const Color dividerColor = Colors.white54;
  static const Color pageBackgroundColor = Color(0xFF2D2F41);
  static const Color menuBackgroundColor = Color(0xFF242634);
  static const Color clockBG = Color(0xFF444974);
  static const Color clockOutline = Color(0xFFEAECFF);
  static final Color secHandColor = Colors.orange[300]!;
  static const Color minHandStatColor = Color(0xFF748EF6);
  static const Color minHandEndColor = Color(0xFF77DDFF);
  static const Color hourHandStatColor = Color(0xFFC279FB);
  static const Color hourHandEndColor = Color(0xFFEA74AB);
}

class GradientColors {
  final List<Color> colors;
  GradientColors(this.colors);

  static List<Color> sky = [const Color(0xFF6448FE), const Color(0xFF5FC6FF)];
  static List<Color> sunset = [
    const Color(0xFFFE6197),
    const Color(0xFFFFB463)
  ];
  static List<Color> sea = [const Color(0xFF61A3FE), const Color(0xFF63FFD5)];
  static List<Color> mango = [const Color(0xFFFFA738), const Color(0xFFFFE130)];
  static List<Color> fire = [const Color(0xFFFF5DCD), const Color(0xFFFF8484)];
}

class GradientTemplate {
  static List<GradientColors> gradientTemplate = [
    GradientColors(GradientColors.sky),
    GradientColors(GradientColors.sunset),
    GradientColors(GradientColors.sea),
    GradientColors(GradientColors.mango),
    GradientColors(GradientColors.fire),
  ];
}
