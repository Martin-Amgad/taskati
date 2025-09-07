import 'package:flutter/widgets.dart';

class TextStyles {
  static TextStyle getTitle({
    double fontSize = 18,
    FontWeight fontWeight = FontWeight.bold,
    Color? color,
  }) {
    return TextStyle(
      fontFamily: 'poppins',
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle getBody({
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.normal,
    Color? color,
  }) {
    return TextStyle(
      fontFamily: 'poppins',
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle getSmall({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.normal,
    Color? color,
  }) {
    return TextStyle(
      fontFamily: 'poppins',
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }
}
