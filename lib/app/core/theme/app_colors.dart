import 'package:flutter/material.dart';

class AppColors {
  static Color red = const Color(0xFFDC362E);
  static Color background = const Color(0xFFF9FAFC);

  static MaterialColor get primary => green;
  static MaterialColor get secondary => white;

  static MaterialColor green = const MaterialColor(
    0xFF005F27,
    <int, Color>{
      100: Color(0xFF6DDF9C),
      300: Color(0xFF369F61),
      500: Color(0xFF005F27),
      600: Color(0xFF004C1F),
      700: Color(0xFF003917),
    },
  );

  static MaterialColor white = const MaterialColor(
    0xFFFFFFFF,
    <int, Color>{
      50: Color(0xFFFFFFFF),
      100: Color(0xFFFFFFFF),
      200: Color(0xFFFFFFFF),
      300: Color(0xFFFFFFFF),
      400: Color(0xFFFFFFFF),
      500: Color(0xFFFFFFFF),
      600: Color(0xFFFFFFFF),
      700: Color(0xFFFFFFFF),
      800: Color(0xFFFFFFFF),
      900: Color(0xFFFFFFFF),
    },
  );

  static MaterialColor grey = const MaterialColor(
    0xFF999999,
    <int, Color>{
      50: Color.fromRGBO(241, 243, 243, 0.50),
      100: Color(0xFFE5EBF1),
      300: Color(0xFFBEC9D7),
      500: Color(0xFF999999),
      800: Color(0xFF666666),
    },
  );
}
