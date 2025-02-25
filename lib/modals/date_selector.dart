import 'package:flutter/material.dart';
import 'dart:math';

class DateCirclePainter extends CustomPainter {
  final double litersRefilled;
  final bool isSelected;
  final Color activeColor;
  final Color inactiveColor;
  final double maxLiters = 2000; // Maximum tank capacity

  DateCirclePainter({
    required this.litersRefilled,
    required this.isSelected,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double progress = (litersRefilled / maxLiters).clamp(0.0, 1.0);
    double radius = size.width / 2;
    Offset center = Offset(size.width / 2, size.height / 2);

    // Draw selection box if selected (Bigger & More Transparent)
    if (isSelected) {
      Paint selectionBoxPaint = Paint()
        ..color = activeColor.withOpacity(0.15) // Light blue transparent
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3;

      double padding = 8; // Increase padding for a bigger box
      Rect selectionRect = Rect.fromLTWH(
        -padding / 2,
        -padding / 2,
        size.width + padding,
        size.height + padding,
      );

      RRect roundedRect =
          RRect.fromRectAndRadius(selectionRect, Radius.circular(14));
      canvas.drawRRect(roundedRect, selectionBoxPaint);
    }

    // Draw background circle (Always White for Clear Text Visibility)
    Paint backgroundPaint = Paint()..color = Colors.white;
    canvas.drawCircle(center, radius, backgroundPaint);

    // Apply gray border **only when not selected** to avoid hiding text
    if (!isSelected) {
      Paint borderPaint = Paint()
        ..color = inactiveColor.withOpacity(0.5) // Slightly transparent gray
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke;
      canvas.drawCircle(center, radius, borderPaint);
    }

    // Draw progress arc
    Paint progressPaint = Paint()
      ..color = activeColor
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    double startAngle = -pi / 2;
    double sweepAngle = 2 * pi * progress;
    Rect rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(rect, startAngle, sweepAngle, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
