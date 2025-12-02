import 'dart:math' as math;
import 'package:flutter/material.dart';

class Water3DWaveWidget extends StatefulWidget {
  final double fillPercentage;
  final Size size;
  final List<Bubble> bubbles;
  final bool isMotorOn;

  const Water3DWaveWidget({
    super.key,
    required this.fillPercentage,
    required this.size,
    required this.bubbles,
    this.isMotorOn = false,
  });

  @override
  State<Water3DWaveWidget> createState() => _Water3DWaveWidgetState();
}

class _Water3DWaveWidgetState extends State<Water3DWaveWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _waveController;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    )..repeat();
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _waveController,
      builder: (context, child) {
        final phase = _waveController.value * 2 * math.pi;
        return CustomPaint(
          size: widget.size,
          painter: Water3DWavePainter(
            fillPercentage: widget.fillPercentage,
            wavePhase: phase,
            bubbles: widget.bubbles,
            isMotorOn: widget.isMotorOn,
          ),
        );
      },
    );
  }
}

class Bubble {
  double x;
  double y;
  double size;
  double speed;
  double opacity;

  Bubble({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    this.opacity = 0.8,
  });
}

class Water3DWavePainter extends CustomPainter {
  final double fillPercentage;
  final double wavePhase;
  final List<Bubble> bubbles;
  final bool isMotorOn;

  Water3DWavePainter({
    required this.fillPercentage,
    required this.wavePhase,
    required this.bubbles,
    required this.isMotorOn,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final tankPath = buildThirdWaterTankPath(size: size);
    final waterHeight = size.height * fillPercentage;
    final waterTop = size.height - waterHeight;

    canvas.save();
    canvas.clipPath(tankPath);
    final backgroundPaint = Paint()..color = const Color(0xFFE8F4FC);
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);

    if (fillPercentage > 0) {
      final waterRect = Rect.fromLTWH(0, waterTop + 3, size.width, waterHeight);
      final waterGradient = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          const Color.fromARGB(255, 46, 132, 229),
          const Color(0xFF42A5F5),
          const Color(0xFF64B5F6),
          const Color(0xFF42A5F5),
          const Color.fromARGB(255, 50, 130, 222),
        ],
        stops: const [0.0, 0.2, 0.5, 0.8, 1.0],
      );
      canvas.drawRect(
        waterRect,
        Paint()..shader = waterGradient.createShader(waterRect),
      );
      _drawTankWave(
        canvas,
        size,
        waterTop,
        wavePhase,
        amplitude: 2.5,
        color: const Color.fromARGB(255, 71, 137, 235),
        yOffset: -2,
        phaseOffset: math.pi * 0.5,
      );
      _drawTankWave(
        canvas,
        size,
        waterTop,
        wavePhase,
        amplitude: 3.5,
        color: const Color(0xFF42A5F5),
        yOffset: 0,
        isFrontWave: true,
      );
      _drawTankWave(
        canvas,
        size,
        waterTop,
        wavePhase,
        amplitude: 2.0,
        color: const Color(0xFF90CAF9).withValues(alpha: 0.4),
        yOffset: 1,
        isHighlight: true,
        phaseOffset: math.pi * 0.2,
      );
      _draw3DDepthOverlay(canvas, size, waterTop, waterHeight);
      _drawBubbles(canvas, size, waterTop, waterHeight);
    }

    canvas.restore();
    final outlinePaint = Paint()
      ..color = const Color.fromARGB(255, 124, 137, 143)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawPath(tankPath, outlinePaint);

    final tankHighlight = Paint()
      ..shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Colors.white.withValues(alpha: 0.4),
          Colors.transparent,
        ],
        stops: const [0.0, 0.15],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawPath(tankPath, tankHighlight);
  }

  void _drawTankWave(
    Canvas canvas,
    Size size,
    double waterTop,
    double phase, {
    required double amplitude,
    required Color color,
    double yOffset = 0,
    double phaseOffset = 0,
    bool isFrontWave = false,
    bool isHighlight = false,
  }) {
    final wavePath = Path();
    wavePath.moveTo(0, size.height);
    wavePath.lineTo(0, waterTop + yOffset);
    for (double x = 0; x <= size.width; x += 0.5) {
      final normalizedX = x / size.width;
      final slosh = math.sin(phase + phaseOffset) *
          math.sin(normalizedX * math.pi) *
          amplitude;
      final ripple =
          math.sin(normalizedX * math.pi * 3 + phase) * (amplitude * 0.15);

      final waveY = waterTop + yOffset + slosh + ripple;
      wavePath.lineTo(x, waveY);
    }
    wavePath.lineTo(size.width, size.height);
    wavePath.close();
    final waveRect = Rect.fromLTWH(0, waterTop - amplitude * 1.5, size.width,
        size.height - waterTop + amplitude * 2);

    Paint wavePaint;
    if (isFrontWave) {
      wavePaint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            color.withValues(alpha: 0.8),
            color,
            color.withValues(alpha: 0.95),
            color,
            color.withValues(alpha: 0.8),
          ],
          stops: const [0.0, 0.2, 0.5, 0.8, 1.0],
        ).createShader(waveRect);
    } else if (isHighlight) {
      wavePaint = Paint()..color = color;
    } else {
      wavePaint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            color.withValues(alpha: 0.6),
            color.withValues(alpha: 0.85),
            color,
            color.withValues(alpha: 0.85),
            color.withValues(alpha: 0.6),
          ],
          stops: const [0.0, 0.2, 0.5, 0.8, 1.0],
        ).createShader(waveRect);
    }

    canvas.drawPath(wavePath, wavePaint);
  }

  void _draw3DDepthOverlay(
      Canvas canvas, Size size, double waterTop, double waterHeight) {
    if (waterHeight <= 0) return;

    final waterRect = Rect.fromLTWH(0, waterTop, size.width, waterHeight);
    final cylinderGradient = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0.0, 0.0),
        radius: 1.2,
        colors: [
          Colors.white.withValues(alpha: 0.12),
          Colors.transparent,
          const Color(0xFF0D47A1).withValues(alpha: 0.08),
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(waterRect);
    canvas.drawRect(waterRect, cylinderGradient);
    final leftGlowRect =
        Rect.fromLTWH(0, waterTop, size.width * 0.35, waterHeight);
    final leftGlow = Paint()
      ..shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Colors.white.withValues(alpha: 0.18),
          Colors.white.withValues(alpha: 0.06),
          Colors.transparent,
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(leftGlowRect);
    canvas.drawRect(leftGlowRect, leftGlow);
    final rightShadowRect = Rect.fromLTWH(
        size.width * 0.65, waterTop, size.width * 0.35, waterHeight);
    final rightShadow = Paint()
      ..shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Colors.transparent,
          const Color(0xFF0D47A1).withValues(alpha: 0.1),
          const Color(0xFF0D47A1).withValues(alpha: 0.2),
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(rightShadowRect);
    canvas.drawRect(rightShadowRect, rightShadow);
    final bottomDepthHeight = waterHeight * 0.35;
    final bottomRect = Rect.fromLTWH(
        0, size.height - bottomDepthHeight, size.width, bottomDepthHeight);
    final bottomDepth = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.transparent,
          const Color(0xFF0D47A1).withValues(alpha: 0.12),
          const Color(0xFF0D47A1).withValues(alpha: 0.2),
        ],
        stops: const [0.0, 0.6, 1.0],
      ).createShader(bottomRect);
    canvas.drawRect(bottomRect, bottomDepth);
    final specularRect = Rect.fromLTWH(
        size.width * 0.25, waterTop, size.width * 0.5, waterHeight * 0.3);
    final specular = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0.0, -0.5),
        radius: 1.0,
        colors: [
          Colors.white.withValues(alpha: 0.1),
          Colors.transparent,
        ],
      ).createShader(specularRect);
    canvas.drawRect(specularRect, specular);
  }

  void _drawBubbles(
      Canvas canvas, Size size, double waterTop, double waterHeight) {
    if (bubbles.isEmpty || fillPercentage <= 0) return;

    for (var bubble in bubbles) {
      final bubbleX = bubble.x * size.width;
      final bubbleY = waterTop +
          (bubble.y - (1 - fillPercentage)) * waterHeight / fillPercentage;

      if (bubbleY >= waterTop && bubbleY <= size.height) {
        final bubblePaint = Paint()
          ..shader = RadialGradient(
            center: const Alignment(-0.4, -0.4),
            colors: [
              Colors.white.withValues(alpha: bubble.opacity),
              Colors.white.withValues(alpha: bubble.opacity * 0.5),
              const Color(0xFF90CAF9).withValues(alpha: 0.25),
              Colors.transparent,
            ],
            stops: const [0.0, 0.25, 0.65, 1.0],
          ).createShader(Rect.fromCircle(
            center: Offset(bubbleX, bubbleY),
            radius: bubble.size,
          ));

        canvas.drawCircle(
          Offset(bubbleX, bubbleY),
          bubble.size,
          bubblePaint,
        );

        final outlinePaint = Paint()
          ..color = Colors.white.withValues(alpha: 0.5)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.8;
        canvas.drawCircle(
          Offset(bubbleX, bubbleY),
          bubble.size,
          outlinePaint,
        );

        final highlightDot = Paint()
          ..color = Colors.white.withValues(alpha: 0.9);
        canvas.drawCircle(
          Offset(bubbleX - bubble.size * 0.3, bubbleY - bubble.size * 0.3),
          bubble.size * 0.2,
          highlightDot,
        );
      }
    }
  }

  @override
  bool shouldRepaint(Water3DWavePainter oldDelegate) {
    return oldDelegate.fillPercentage != fillPercentage ||
        oldDelegate.wavePhase != wavePhase ||
        oldDelegate.bubbles.length != bubbles.length ||
        oldDelegate.isMotorOn != isMotorOn;
  }
}

Path buildRawShapePath() {
  final Path path = Path();
  path.moveTo(42.11, 3);
  path.lineTo(42.11, 4.02);
  path.cubicTo(42.45, 4.029999999999999, 42.79, 4.039999999999999, 43.11,
      4.069999999999999);
  path.lineTo(43.11, 3.0499999999999994);
  path.cubicTo(42.769999999999996, 3.0299999999999994, 42.43,
      3.0199999999999996, 42.11, 2.9999999999999996);
  path.close();
  path.moveTo(33.3, 4.11);
  path.cubicTo(33.62, 4.08, 33.959999999999994, 4.0600000000000005, 34.3,
      4.050000000000001);
  path.lineTo(34.3, 3.040000000000001);
  path.cubicTo(33.97, 3.0500000000000007, 33.64, 3.0700000000000007, 33.3,
      3.0900000000000007);
  path.lineTo(33.3, 4.110000000000001);
  path.close();
  path.moveTo(74.76, 43.36);
  path.lineTo(74.76, 49.05);
  path.cubicTo(
      75.82000000000001, 49.769999999999996, 76.36, 50.62, 76.36, 51.58);
  path.cubicTo(76.36, 52.54, 75.83, 53.39, 74.76, 54.11);
  path.lineTo(74.76, 58.04);
  path.cubicTo(75.75, 58.9, 76.25, 59.87, 76.25, 60.9);
  path.cubicTo(76.25, 61.93, 75.75, 62.879999999999995, 74.76, 63.75);
  path.lineTo(74.76, 68.29);
  path.cubicTo(75.86, 69.29, 76.42, 70.38000000000001, 76.42, 71.54);
  path.cubicTo(76.42, 72.7, 75.86, 73.73, 74.76, 74.72000000000001);
  path.lineTo(74.76, 82.61000000000001);
  path.cubicTo(74.76, 87.73000000000002, 56.150000000000006, 90.50000000000001,
      38.650000000000006, 90.50000000000001);
  path.cubicTo(21.150000000000006, 90.50000000000001, 2.5400000000000063,
      87.73000000000002, 2.5400000000000063, 82.61000000000001);
  path.lineTo(2.5400000000000063, 74.94000000000001);
  path.cubicTo(1.2800000000000062, 73.9, 0.6400000000000063, 72.75000000000001,
      0.6400000000000063, 71.54);
  path.cubicTo(0.6400000000000063, 70.33, 1.2800000000000065, 69.14,
      2.5400000000000063, 68.09);
  path.lineTo(2.5400000000000063, 63.910000000000004);
  path.cubicTo(1.3900000000000063, 62.99, 0.8100000000000063,
      61.980000000000004, 0.8100000000000063, 60.900000000000006);
  path.cubicTo(0.8100000000000063, 59.82000000000001, 1.3900000000000063,
      58.75000000000001, 2.5400000000000063, 57.84);
  path.lineTo(2.5400000000000063, 54.27);
  path.cubicTo(1.3100000000000063, 53.5, 0.7100000000000062, 52.620000000000005,
      0.7100000000000062, 51.580000000000005);
  path.cubicTo(0.7100000000000062, 50.540000000000006, 1.3100000000000063,
      49.650000000000006, 2.5400000000000063, 48.89000000000001);
  path.lineTo(2.5400000000000063, 43.49000000000001);
  path.cubicTo(0.5900000000000063, 42.48000000000001, 0.5900000000000063,
      41.45000000000001, 0.5900000000000063, 40.94000000000001);
  path.cubicTo(0.5900000000000063, 39.92000000000001, 1.2300000000000062,
      39.09000000000001, 2.5400000000000063, 38.390000000000015);
  path.lineTo(2.5400000000000063, 32.97000000000001);
  path.cubicTo(0.6700000000000061, 32.16000000000001, 0.5000000000000062,
      31.320000000000014, 0.5000000000000062, 30.590000000000014);
  path.cubicTo(0.5000000000000062, 29.320000000000014, 1.5900000000000063,
      28.630000000000013, 2.5400000000000063, 28.220000000000013);
  path.lineTo(2.5400000000000063, 18.720000000000013);
  path.cubicTo(2.5400000000000063, 18.720000000000013, 2.550000000000006,
      18.640000000000015, 2.5600000000000063, 18.600000000000012);
  path.cubicTo(2.5500000000000065, 18.510000000000012, 2.5500000000000065,
      18.420000000000012, 2.5400000000000063, 18.330000000000013);
  path.cubicTo(2.5400000000000063, 13.440000000000012, 11.460000000000006,
      9.180000000000012, 25.300000000000008, 7.430000000000012);
  path.lineTo(25.300000000000008, 5.280000000000012);
  path.cubicTo(25.300000000000008, 3.890000000000012, 29.550000000000008,
      3.320000000000012, 33.30000000000001, 3.090000000000012);
  path.lineTo(33.30000000000001, 5.160000000000012);
  path.cubicTo(33.30000000000001, 5.440000000000012, 33.52000000000001,
      5.660000000000012, 33.80000000000001, 5.660000000000012);
  path.cubicTo(34.08000000000001, 5.660000000000012, 34.30000000000001,
      5.440000000000012, 34.30000000000001, 5.160000000000012);
  path.lineTo(34.30000000000001, 3.0400000000000116);
  path.cubicTo(33.97000000000001, 3.0500000000000114, 33.640000000000015,
      3.0700000000000114, 33.30000000000001, 3.0900000000000114);
  path.lineTo(33.30000000000001, 1.6400000000000114);
  path.cubicTo(33.30000000000001, 1.0100000000000113, 33.81000000000001,
      0.5000000000000115, 34.44000000000001, 0.5000000000000115);
  path.lineTo(41.97000000000001, 0.5000000000000115);
  path.cubicTo(42.600000000000016, 0.5000000000000115, 43.110000000000014,
      1.0100000000000116, 43.110000000000014, 1.6400000000000114);
  path.lineTo(43.110000000000014, 3.0500000000000114);
  path.cubicTo(42.77000000000001, 3.0300000000000114, 42.430000000000014,
      3.0200000000000116, 42.110000000000014, 3.0000000000000115);
  path.lineTo(42.110000000000014, 5.160000000000012);
  path.cubicTo(42.110000000000014, 5.440000000000012, 42.33000000000001,
      5.660000000000012, 42.610000000000014, 5.660000000000012);
  path.cubicTo(42.890000000000015, 5.660000000000012, 43.110000000000014,
      5.440000000000012, 43.110000000000014, 5.160000000000012);
  path.lineTo(43.110000000000014, 3.050000000000012);
  path.cubicTo(47.000000000000014, 3.2600000000000118, 51.76000000000001,
      3.810000000000012, 51.76000000000001, 5.280000000000012);
  path.lineTo(51.76000000000001, 7.400000000000012);
  path.cubicTo(65.75000000000001, 9.140000000000011, 74.76000000000002,
      13.41000000000001, 74.76000000000002, 18.330000000000013);
  path.cubicTo(74.75000000000001, 18.420000000000012, 74.75000000000001,
      18.510000000000012, 74.74000000000002, 18.600000000000012);
  path.cubicTo(74.75000000000003, 18.64000000000001, 74.76000000000002,
      18.68000000000001, 74.76000000000002, 18.720000000000013);
  path.lineTo(74.76000000000002, 28.320000000000014);
  path.cubicTo(75.97000000000001, 28.910000000000014, 76.56000000000002,
      29.660000000000014, 76.56000000000002, 30.590000000000014);
  path.cubicTo(76.56000000000002, 31.290000000000013, 76.41000000000001,
      32.09000000000002, 74.76000000000002, 32.860000000000014);
  path.lineTo(74.76000000000002, 38.52000000000001);
  path.cubicTo(75.91000000000003, 39.18000000000001, 76.47000000000001,
      39.98000000000001, 76.47000000000001, 40.94000000000001);
  path.cubicTo(76.47000000000001, 41.70000000000001, 76.25000000000001,
      42.52000000000001, 74.76000000000002, 43.360000000000014);
  path.close();
  path.moveTo(33.3, 3.09);
  path.cubicTo(33.64, 3.07, 33.97, 3.05, 34.3, 3.04);
  path.lineTo(34.3, 5.16);
  path.cubicTo(34.3, 5.44, 34.07, 5.66, 33.8, 5.66);
  path.cubicTo(33.529999999999994, 5.66, 33.3, 5.44, 33.3, 5.16);
  path.lineTo(33.3, 3.0900000000000003);
  path.close();
  path.moveTo(43.11, 3.05);
  path.lineTo(43.11, 5.16);
  path.cubicTo(43.11, 5.44, 42.88, 5.66, 42.61, 5.66);
  path.cubicTo(42.339999999999996, 5.66, 42.11, 5.44, 42.11, 5.16);
  path.lineTo(42.11, 3);
  path.cubicTo(42.43, 3.02, 42.769999999999996, 3.03, 43.11, 3.05);
  path.close();

  return path;
}

Path buildThirdWaterTankPath({Size size = const Size(200, 300)}) {
  Path rawPath = buildRawShapePath(); // your current negative path

  // Get bounds of the raw path
  Rect bounds = rawPath.getBounds();

  // Move it so the top-left is (0,0)
  Matrix4 matrix4 = Matrix4.identity()..translate(-bounds.left, -bounds.top);

  Path shifted = rawPath.transform(matrix4.storage);

  // Scale it to fit the given size (width × height)
  double scaleX = size.width / bounds.width;
  double scaleY = size.height / bounds.height;
  Matrix4 scaleMatrix = Matrix4.identity()..scale(scaleX, scaleY);

  return shifted.transform(scaleMatrix.storage);
}
