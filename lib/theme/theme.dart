import 'package:flutter/material.dart';

class ElomiaTheme {
  static ThemeData mainTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: ElomiaTheme.background,
    textTheme: Typography.material2018(platform: TargetPlatform.iOS).white,
    primaryColor: blue,
    textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.white),
  );

  static const TextStyle header =
      TextStyle(fontSize: 28, fontWeight: FontWeight.w600);
  static const TextStyle title =
      TextStyle(fontSize: 17, fontWeight: FontWeight.w400);

  static const Color lightGrey = Color(0xFFD1D5DB);
  static const Color darkWhite = Color(0xFFF4F3F3);
  static const Color darkGrey = Color(0xFF50555C);
  static const Color lightBlack = Color(0xFF2E2F34);
  static const Color background = Color(0xFF152241);
  static const Color grey = Color(0xFFADB3BC);
  static const Color darkIndigo = Color(0xFF040D25);
  static const Color indigo = Color(0xFF12224D);
  static const Color mazarine = Color(0xFF29395F);
  static const Color lightMazarine = Color(0xFF43598E);
  static const Color blue = Color(0xFF2192F0);
  static const Color milkWhite = Color(0xFFF0F4F8);
  static const Color green = Color(0xFF52D225);
  static const Color red = Colors.red;
  static const Color purple = Color(0xFFAC6EF6);
}
