import 'package:flutter/material.dart';
import 'dart:math';

class WaterDropPainter extends CustomPainter {
  final double progress;
  final Color fillColor;
  final double wavePhase;
  final double waveHeight;

  WaterDropPainter({
    required this.progress,
    required this.fillColor,
    required this.wavePhase,
    this.waveHeight = 8.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double ws = size.width / 180;
    double hs = size.height / 216;

    final Paint dropPaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.fill;

    final Paint fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    Path dropPath = Path();
    dropPath.moveTo(82.9262 * ws, 16.5416 * hs);
    dropPath.cubicTo(
      84.9174 * ws,
      14.8986 * hs,
      87.4185 * ws,
      14 * hs,
      90 * ws,
      14 * hs,
    );
    dropPath.cubicTo(
      92.5816 * ws,
      14 * hs,
      95.0826 * ws,
      14.8986 * hs,
      97.0738 * ws,
      16.5416 * hs,
    );
    dropPath.cubicTo(
      110.61 * ws,
      27.7963 * hs,
      123.011 * ws,
      40.3491 * hs,
      134.101 * ws,
      54.0205 * hs,
    );
    dropPath.cubicTo(
      149.548 * ws,
      73.2261 * hs,
      165.353 * ws,
      99.2889 * hs,
      165.353 * ws,
      126.548 * hs,
    );
    dropPath.cubicTo(
      165.353 * ws,
      146.533 * hs,
      157.414 * ws,
      165.699 * hs,
      143.283 * ws,
      179.831 * hs,
    );
    dropPath.cubicTo(
      129.151 * ws,
      193.962 * hs,
      109.985 * ws,
      201.901 * hs,
      90 * ws,
      201.901 * hs,
    );
    dropPath.cubicTo(
      70.0151 * ws,
      201.901 * hs,
      50.8487 * ws,
      193.962 * hs,
      36.7172 * ws,
      179.831 * hs,
    );
    dropPath.cubicTo(
      22.5857 * ws,
      165.699 * hs,
      14.6467 * ws,
      146.533 * hs,
      14.6467 * ws,
      126.548 * hs,
    );
    dropPath.cubicTo(
      14.6467 * ws,
      99.2889 * hs,
      30.4521 * ws,
      73.2261 * hs,
      45.8995 * ws,
      54.011 * hs,
    );
    dropPath.cubicTo(
      56.9867 * ws,
      40.3435 * hs,
      69.3943 * ws,
      27.7939 * hs,
      82.9262 * ws,
      16.5416 * hs,
    );
    dropPath.close();

    canvas.drawPath(dropPath, dropPaint);

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

    canvas.save();
    canvas.clipPath(dropPath);
    canvas.drawPath(wavePath, fillPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
