import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TankController extends ChangeNotifier {
  double _waterLevel = 0;

  double get waterLevel => _waterLevel;

  void updateWaterLevel(double newLevel) {
    _waterLevel = newLevel;
    notifyListeners();
  }

  Future<void> fetchWaterLevelFromUser(String userId) async {
    final doc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (doc.exists) {
      final data = doc.data()!;
      _waterLevel = (data['reservoir'] ?? 0).toDouble();
      notifyListeners();
    }
  }
}
