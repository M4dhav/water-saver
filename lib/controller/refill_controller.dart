import 'package:flutter/material.dart';

class RefillController {
  double waterLevel = 1650;
  final double maxCapacity = 2500;

  void refillWater(VoidCallback onComplete) {
    waterLevel = maxCapacity;
    onComplete();
  }
}
