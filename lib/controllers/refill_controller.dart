import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RefillController {
  double tankLevel = 1200; // Current water level in tank (liters)
  double tankCapacity = 2500; // Tank capacity (liters)
  double reservoirLevel = 0; 
  double reservoirCapacity = 0; 
  bool hasReservoir = false;

  // TODO: Integrate with ESP API to fetch real-time water level
  // Example:
  // Future<void> fetchWaterLevelFromESP() async {
  //   // Call your ESP API here and update tankLevel and/or reservoirLevel
  // }

  Future<void> fetchFromUserModel(String userId) async {
    final doc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (doc.exists) {
      final data = doc.data()!;
      tankLevel = (data['tankLevel'] ?? 0).toDouble();
      tankCapacity = (data['tank'] ?? 0).toDouble();
      if (data.containsKey('reservoir')) {
        hasReservoir = true;
        reservoirLevel = (data['reservoirLevel'] ?? 0).toDouble();
        reservoirCapacity = (data['reservoir'] ?? 0).toDouble();
      } else {
        hasReservoir = false;
        reservoirLevel = 0;
        reservoirCapacity = 0;
      }
    }
  }

  void refillWater(VoidCallback onComplete) {
    if (hasReservoir) {
      reservoirLevel = reservoirCapacity;
    }
    tankLevel = tankCapacity;
    onComplete();
  }
}
