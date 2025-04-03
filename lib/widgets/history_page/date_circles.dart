import 'package:flutter/material.dart';
import 'dart:math';

class DateCirclePainter extends CustomPainter {
  final double litersRefilled;
  final bool isSelected;
  final Color activeColor;
  final Color inactiveColor;
  final double maxLiters;

  DateCirclePainter({
    required this.litersRefilled,
    required this.isSelected,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
    this.maxLiters = 2000, // Default tank capacity
  });

  @override
  void paint(Canvas canvas, Size size) {
    double progress = (litersRefilled / maxLiters).clamp(0.0, 1.0);
    double radius = size.width / 2;
    Offset center = Offset(size.width / 2, size.height / 2);
    if (isSelected) {
      Paint selectionPaint = Paint()
        ..color = activeColor.withValues(alpha: .2)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(center, radius + 5, selectionPaint);
    }

    Paint backgroundPaint = Paint()..color = Colors.white;
    canvas.drawCircle(center, radius, backgroundPaint);

    // Gray Border
    if (!isSelected) {
      Paint borderPaint = Paint()
        ..color = inactiveColor.withValues(alpha: .5)
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke;
      canvas.drawCircle(center, radius, borderPaint);
    }

    // Progress Arc
    if (progress > 0) {
      Paint progressPaint = Paint()
        ..color = activeColor
        ..strokeWidth = 5
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      double startAngle = -pi / 2;
      double sweepAngle = 2 * pi * progress;
      Rect rect = Rect.fromCircle(center: center, radius: radius);
      canvas.drawArc(rect, startAngle, sweepAngle, false, progressPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
