import 'package:flutter/material.dart';

class ColorPalette {
  static const Color blue = Color(0xFF6DDDCD);
  static const Color pink = Color(0xFFFF9F9F);
  static const Color white = Colors.white;
}

class Gradients {
  static const Gradient defaultGradientBackground = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomLeft,
      colors: [ColorPalette.blue, ColorPalette.pink]);
}
