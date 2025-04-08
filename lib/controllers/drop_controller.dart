import 'package:flutter/material.dart';

class DropController {
  late AnimationController _waveController;
  double wavePhase = 0.0;
  final TickerProvider vsync;
  final VoidCallback onUpdate; // Callback to notify UI

  DropController(this.vsync, this.onUpdate);

  void initAnimation() {
    _waveController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 300),
    )..addListener(() {
        _updateWavePhase();
      });
    _waveController.repeat();
  }

  void _updateWavePhase() {
    wavePhase += 0.05;
    if (wavePhase > 2 * 3.1415) {
      wavePhase = 0;
    }
    onUpdate(); // Notify the UI
  }

  void dispose() {
    _waveController.dispose();
  }
}
