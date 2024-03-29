import 'package:flutter/material.dart';

class ColorPalette {
  static const Color blue = Color(0xFF6DDDCD);
  //error red
  static Color red = const Color(0xFFE53E3E).withOpacity(0.7);
  static const Color blueBold = Color(0xFF4ec4c6);
  static const Color blueBold2 = Color(0xFF0A4F45);
  static const Color bluelight = Color(0xFFDEFDF9);
  static const Color bluelight2 = Color(0xFF668E88);
  static const Color blue2 = Color(0xFFDEFFFA);
  static const Color blue3 = Color(0xFF91B0AB);
  static const Color pink = Color(0xFFFF9F9F);
  static const Color pinklight = Color(0xFFFFDEDE);
  static const Color pinkBold = Color(0xFFDD7070);
  static Color selectedPink = const Color(0xFFAE3030).withOpacity(0.42);
  static const Color white = Colors.white;
  static const Color secondaryWhite = Color(0xFFF8F8F3);
  static const Color thirdWhite = Color(0xFFFFFFFC);
  static const Color bgColor = Color(0xFFFEFEF9);
  static const Color grey = Color(0xFFAFAFAF);
  static const Color primaryText = Color(0xFF141414);
  static const Color secondaryText = Color(0xFF2C2E34);
  static const Color grey2 = Color(0xFFE6E6E6);
  static const Color star = Color(0xFFEC942C);
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
