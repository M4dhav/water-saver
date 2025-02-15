import 'dart:math';
import 'package:flutter/material.dart';

class WaterLevelArcPainter extends CustomPainter {
  final double progress;
  final Color color;

  WaterLevelArcPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    double arcWidth = 30;
    double startAngle = pi * 0.695; // Opening positioned at bottom
    double sweepAngle = pi * 1.6; // Covers 80% of the drop

    // Background Arc
    final Paint arcBackgroundPaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = arcWidth;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      arcBackgroundPaint,
    );

    // Progress Arc
    final Paint arcPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = arcWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle * progress,
      false,
      arcPaint,
    );

    // Notches (placed between arc and drop)
    final Paint notchPaint = Paint()
      ..color = Colors.grey.shade500
      ..strokeWidth = 2;

    double notchRadius =
        radius - (arcWidth / 2) - 10; // Adjusted radius for placement

    for (int i = 0; i < 15; i++) {
      double angle = startAngle + (sweepAngle / 14) * i;

      Offset start = Offset(
        center.dx + (notchRadius - 5) * cos(angle), // Adjusted position
        center.dy + (notchRadius - 5) * sin(angle),
      );

      Offset end = Offset(
        center.dx +
            (notchRadius + 5) * cos(angle), // Positioned between arc and drop
        center.dy + (notchRadius + 5) * sin(angle),
      );

      canvas.drawLine(start, end, notchPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
