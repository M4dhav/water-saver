import 'package:flutter/material.dart';
import 'dart:math';

class WaterDropPainter extends CustomPainter {
  final double progress; // 0.0 to 1.0 (fill percentage)
  final Color fillColor;
  final double wavePhase; // Phase for animation
  final double waveHeight; // Height of the wave

  WaterDropPainter({
    required this.progress,
    required this.fillColor,
    required this.wavePhase,
    this.waveHeight = 8.0, // Controls wave height
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint dropPaint = Paint()
      ..color = Colors.grey.shade300 // Background drop color
      ..style = PaintingStyle.fill;

    final Paint fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    Path dropPath = Path();

    // **More realistic drop shape**
    dropPath.moveTo(size.width * 0.5, 0);
    dropPath.quadraticBezierTo(
        size.width * 1.05, size.height * 1.0, size.width * 0.5, size.height);
    dropPath.quadraticBezierTo(
        size.width * -0.02, size.height * 1.0, size.width * 0.5, 0);
    dropPath.close();

    // Draw drop outline
    canvas.drawPath(dropPath, dropPaint);

    // **Create wavy water level effect**
    Path wavePath = Path();
    double waveStartY = size.height * (1 - progress);

    wavePath.moveTo(0, waveStartY);
    for (double i = 0; i <= size.width; i++) {
      wavePath.lineTo(
        i,
        waveStartY + sin((i / size.width * 2 * pi) + wavePhase) * waveHeight,
      );
    }
    wavePath.lineTo(size.width, size.height);
    wavePath.lineTo(0, size.height);
    wavePath.close();

    // Clip to water drop shape
    canvas.save();
    canvas.clipPath(dropPath);
    canvas.drawPath(wavePath, fillPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
