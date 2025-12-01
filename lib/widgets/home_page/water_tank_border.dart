import 'package:flutter/material.dart';

class WaterTankBorderPainter extends CustomPainter {
  final Path path;

  WaterTankBorderPainter(this.path);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint borderPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeJoin = StrokeJoin.round
      ..isAntiAlias = true;

    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant WaterTankBorderPainter oldDelegate) =>
      oldDelegate.path != path;
}
