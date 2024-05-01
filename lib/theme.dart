import 'package:flutter/material.dart';

final class MainThemeData {
  ThemeData mainTheme = ThemeData(
      textTheme: TextTheme(
    labelMedium: TextStyle(
      color: const Color(0xFF1B1A1C).withOpacity(0.6),
      fontSize: 14,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
      height: 0.09,
    ),
    titleMedium: const TextStyle(
      color: Color(0xFF1B1A1C),
      fontSize: 16,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
      height: 0.07,
    ),
    titleLarge: const TextStyle(
      color: Color(0xFF1B1A1C),
      fontSize: 18,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
    ),
    headlineMedium: const TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
      height: 0.07,
    ),
    displaySmall: const TextStyle(
      color: Colors.white,
      fontSize: 30,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w700,
      height: 0.03,
    ),
  ));
}
