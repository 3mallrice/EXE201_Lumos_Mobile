import 'package:flutter/material.dart';

class ColorPalette {
  static const Color blue = Color(0xFF6DDDCD);
  static const Color blueBold = Color(0xFF4ec4c6);
  static const Color blueBold2 = Color(0xFF0A4F45);
  static const Color bluelight = Color(0xFFDEFDF9);
  static const Color pink = Color(0xFFFF9F9F);
  static const Color white = Colors.white;
  static const Color grey = Colors.grey;
  static const Color primaryText = Color(0xFF141414);
  static const Color secondaryText = Color(0xFF2C2E34);
}

class Gradients {
  static const Gradient defaultGradientBackground = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomLeft,
      colors: [ColorPalette.blue, ColorPalette.pink]);
  static const Gradient button = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomLeft,
      colors: [ColorPalette.blue, ColorPalette.pink]);
}
