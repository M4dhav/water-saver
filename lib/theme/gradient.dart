import 'package:flutter/material.dart';

class AppColors {
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromARGB(255, 15, 30, 56),
      
      Color.fromARGB(255, 40, 93, 153),
      Color.fromARGB(255, 15, 30, 56),
    ],
    stops: [0.0, 0.5, 1.0],
  );
}
