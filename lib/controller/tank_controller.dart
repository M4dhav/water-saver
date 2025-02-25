import 'package:flutter/material.dart';

class TankController extends ChangeNotifier {
  double _waterLevel = 0;

  double get waterLevel => _waterLevel;

  void updateWaterLevel(double newLevel) {
    _waterLevel = newLevel;
    notifyListeners();
  }

}
