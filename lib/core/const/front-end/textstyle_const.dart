// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'color_const.dart';

class TextStyles {
  TextStyles(this.context);

  BuildContext? context;

  static const TextStyle defaultStyle = TextStyle(
      fontSize: 14,
      color: ColorPalette.primaryText,
      fontWeight: FontWeight.w400,
      height: 16 / 14,
      fontFamily: 'roboto');
}

extension ExtendedTextStyle on TextStyle {
  TextStyle get Light {
    return copyWith(fontWeight: FontWeight.w300);
  }

  TextStyle get regular {
    return copyWith(fontWeight: FontWeight.w400);
  }

  TextStyle get italic {
    return copyWith(
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.italic,
    );
  }

  TextStyle get medium {
    return copyWith(fontWeight: FontWeight.w500);
  }

  TextStyle get fontHeader {
    return copyWith(
      fontSize: 22,
      height: 22 / 20,
    );
  }

  TextStyle get fontCaption {
    return copyWith(fontSize: 12, height: 12 / 10);
  }

  TextStyle get semibold {
    return copyWith(fontWeight: FontWeight.w600);
  }

  TextStyle get bold {
    return copyWith(fontWeight: FontWeight.w700);
  }

  TextStyle get textColor {
    return copyWith(color: ColorPalette.primaryText);
  }

  TextStyle setColor(Color color) {
    return copyWith(color: color);
  }

  TextStyle setTextSize(double size) {
    return copyWith(fontSize: size);
  }

  TextStyle get whiteTextColor {
    return copyWith(color: Colors.white);
  }
}
