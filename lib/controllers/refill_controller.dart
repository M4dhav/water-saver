import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RefillController {
  double waterLevel =
      1200; // Static value for current water level in tank (in liters)
  double maxCapacity = 2500; // Static value for tank capacity (in liters)

  // TODO: Integrate with ESP API to fetch real-time water level
  // Example:
  // Future<void> fetchWaterLevelFromESP() async {
  //   // Call your ESP API here and update waterLevel
  // }

  Future<void> fetchFromUserModel(String userId) async {
    final doc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (doc.exists) {
      final data = doc.data()!;
      waterLevel = (data['reservoir'] ?? 0).toDouble();
      maxCapacity = (data['tank'] ?? 0).toDouble();
    }
  }

  void refillWater(VoidCallback onComplete) {
    waterLevel = maxCapacity;
    onComplete();
  }
}
