import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:water_saver/theme/app_themes.dart';
import 'package:water_saver/widgets/home_page/water_tank.dart';

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

class WaterTankWidget extends StatefulWidget {
  final double fillPercentage;
  final double waterLevel;
  final double tankHeight;
  final int volume;
  final AnimatedTextController controller;
  final bool isMotorOn;

  const WaterTankWidget({
    super.key,
    required this.fillPercentage,
    required this.waterLevel,
    required this.tankHeight,
    required this.volume,
    required this.controller,
    this.isMotorOn = false,
  });

  @override
  State<WaterTankWidget> createState() => _WaterTankWidgetState();
}

class _WaterTankWidgetState extends State<WaterTankWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _bubbleController;
  final List<Bubble> _bubbles = [];
  final Random _random = Random();
  bool _shouldGenerateBubbles = false;

  @override
  void initState() {
    super.initState();
    _bubbleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
    )..addListener(_updateBubbles);

    if (widget.isMotorOn) {
      _shouldGenerateBubbles = true;
      _bubbleController.repeat();
    }
  }

  @override
  void didUpdateWidget(WaterTankWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isMotorOn && !oldWidget.isMotorOn) {
      _shouldGenerateBubbles = true;
      _bubbleController.repeat();
    } else if (!widget.isMotorOn && oldWidget.isMotorOn) {
      _shouldGenerateBubbles = false;
    }
  }

  void _updateBubbles() {
    if (!_shouldGenerateBubbles && _bubbles.isEmpty) {
      _bubbleController.stop();
      return;
    }

    setState(() {
      if (_shouldGenerateBubbles && _random.nextDouble() < 0.028) {
        _bubbles.add(Bubble(
          x: _random.nextDouble() * 0.7 + 0.15,
          y: 1.0,
          size: _random.nextDouble() * 4,
          speed: _random.nextDouble() * 0.01,
          opacity: _random.nextDouble() * 0.3 + 0.6,
        ));
      }
      for (var bubble in _bubbles) {
        bubble.y -= bubble.speed;
        bubble.x = bubble.x.clamp(0.08, 0.92);
        bubble.size += (_random.nextDouble() - 0.5) * 0.1;
        bubble.size = bubble.size.clamp(3.0, 14.0);
      }
      final waterSurface = 1 - (widget.fillPercentage / 100);
      _bubbles.removeWhere((b) => b.y < waterSurface + 0.02);
    });
  }

  @override
  void dispose() {
    _bubbleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.05),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AnimatedTextKit(
                        controller: widget.controller,
                        animatedTexts: [
                          ColorizeAnimatedText(
                              fadeInOnStart: false,
                              '${widget.volume} L',
                              textStyle: TextStyle(
                                  fontFamily: GoogleFonts.inter().fontFamily,
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w900),
                              colors: AppColors.textGradientColors),
                        ],
                        repeatForever: true,
                        isRepeatingAnimation: true,
                      ),
                      Text(
                        'volume',
                        style: TextStyle(
                            fontSize: 14.sp,
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color,
                            fontWeight: FontWeight.w700),
                      ),
                      AnimatedTextKit(
                        controller: widget.controller,
                        animatedTexts: [
                          ColorizeAnimatedText(
                              fadeInOnStart: false,
                              '${widget.waterLevel.toStringAsFixed(1)} m',
                              textStyle: TextStyle(
                                  fontFamily: GoogleFonts.inter().fontFamily,
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w900),
                              colors: AppColors.textGradientColors),
                        ],
                        repeatForever: true,
                        isRepeatingAnimation: true,
                      ),
                      Text(
                        'from the bottom',
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w900),
                      ),
                      AnimatedTextKit(
                        controller: widget.controller,
                        animatedTexts: [
                          ColorizeAnimatedText(
                              fadeInOnStart: false,
                              '${widget.fillPercentage.toStringAsFixed(0)}%',
                              textStyle: TextStyle(
                                  fontFamily: GoogleFonts.inter().fontFamily,
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w900),
                              colors: AppColors.textGradientColors),
                        ],
                        repeatForever: true,
                        isRepeatingAnimation: true,
                      ),
                      Text(
                        'filled',
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(constraints.maxHeight * 0.02),
                  child: SizedBox(
                    width: constraints.maxWidth * 0.4,
                    height: constraints.maxHeight * 0.9,
                    child: Stack(
                      children: [
                        LiquidCustomProgressIndicator(
                          value: widget.fillPercentage / 100,
                          direction: Axis.vertical,
                          backgroundColor: const Color(0xFFE8F4FC),
                      waveCount: 2,
                      waveColors: [Colors.blue, Colors.lightBlueAccent],

                          valueColor: AlwaysStoppedAnimation(
                            const Color(0xFF42A5F5),
                          ),
                          shapePath: buildThirdWaterTankPath(
                            size: Size(
                              constraints.maxWidth * 0.4,
                              constraints.maxHeight * 0.9,
                            ),
                          ),
                        ),
                        CustomPaint(
                          size: Size(
                            constraints.maxWidth * 0.4,
                            constraints.maxHeight * 0.9,
                          ),
                          painter: Water3DOverlayPainter(
                            fillPercentage: widget.fillPercentage / 100,
                            bubbles: _bubbles,
                            isMotorOn: widget.isMotorOn,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}

class Water3DOverlayPainter extends CustomPainter {
  final double fillPercentage;
  final List<Bubble> bubbles;
  final bool isMotorOn;

  Water3DOverlayPainter({
    required this.fillPercentage,
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
    if (bubbles.isNotEmpty && fillPercentage > 0) {
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
          // Bubble outline
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

  @override
  bool shouldRepaint(Water3DOverlayPainter oldDelegate) {
    return oldDelegate.fillPercentage != fillPercentage ||
        oldDelegate.bubbles.length != bubbles.length ||
        oldDelegate.isMotorOn != isMotorOn;
  }
}
