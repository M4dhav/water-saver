import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static ThemeData lightTheme = ThemeData.light(
    useMaterial3: true,
  ).copyWith(
      cardColor: Colors.white.withAlpha(100),
      cardTheme: CardThemeData(color: Colors.white.withAlpha(100)),
      primaryColor: Colors.white.withAlpha(100),
      iconTheme: IconThemeData(
        color: Color.fromARGB(255, 15, 62, 123),
      ),
      textTheme: GoogleFonts.interTextTheme().copyWith(
          bodyMedium: GoogleFonts.interTextTheme()
              .bodyMedium
              ?.copyWith(color: Color.fromARGB(255, 107, 114, 128))));
  static ThemeData darkTheme = ThemeData.dark(
    useMaterial3: true,
  ).copyWith();
  static const RadialGradient primaryGradient = RadialGradient(
    radius: 1.18,
    colors: [
      Color.fromARGB(255, 15, 186, 205),
      Color.fromARGB(255, 36, 206, 218),
      Color.fromARGB(255, 56, 214, 232),
      Color.fromARGB(255, 36, 205, 227),
      Color.fromARGB(255, 48, 188, 220),
    ],
    stops: [0, 0.4, 0.58, 0.84, 1],
  );
}
