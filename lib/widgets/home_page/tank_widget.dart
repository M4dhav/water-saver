import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:water_saver/widgets/home_page/water_tank_new.dart';
import 'package:water_saver/widgets/home_page/water_tank_new_2.dart';
import 'package:water_saver/widgets/home_page/water_tank_shape.dart';

class WaterTankWidget extends StatelessWidget {
  final double fillPercentage;
  final double waterLevel;
  final double tankHeight;
  final int volume;
  final AnimatedTextController controller;

  const WaterTankWidget({
    super.key,
    required this.fillPercentage,
    required this.waterLevel,
    required this.tankHeight,
    required this.volume,
    required this.controller,
  });

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
                        controller: controller,
                        animatedTexts: [
                          ColorizeAnimatedText(
                            '$volume L',
                            textStyle: TextStyle(
                                fontFamily: GoogleFonts.inter().fontFamily,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w900),
                            colors: [
                              Color.fromARGB(255, 0, 140, 255),
                              Color.fromARGB(255, 15, 62, 123),
                            ],
                          ),
                        ],
                        repeatForever: true,
                        isRepeatingAnimation: true,
                      ),
                      Text(
                        'volume',
                        style: TextStyle(
                          fontSize: 14.sp,
                        ),
                      ),
                      AnimatedTextKit(
                        controller: controller,
                        animatedTexts: [
                          ColorizeAnimatedText(
                            '${waterLevel.toStringAsFixed(1)} m',
                            textStyle: TextStyle(
                                fontFamily: GoogleFonts.inter().fontFamily,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w900),
                            colors: [
                              Color.fromARGB(255, 0, 140, 255),
                              Color.fromARGB(255, 15, 62, 123),
                            ],
                          ),
                        ],
                        repeatForever: true,
                        isRepeatingAnimation: true,
                      ),
                      Text(
                        'from the bottom',
                        style: TextStyle(
                          fontSize: 14.sp,
                        ),
                      ),
                      AnimatedTextKit(
                        controller: controller,
                        animatedTexts: [
                          ColorizeAnimatedText(
                            '${fillPercentage.toStringAsFixed(0)}%',
                            textStyle: TextStyle(
                                fontFamily: GoogleFonts.inter().fontFamily,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w900),
                            colors: [
                              Color.fromARGB(255, 0, 140, 255),
                              Color.fromARGB(255, 15, 62, 123),
                            ],
                          ),
                        ],
                        repeatForever: true,
                        isRepeatingAnimation: true,
                      ),
                      Text(
                        'filled',
                        style: TextStyle(
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(constraints.maxHeight * 0.03),
                    child: LiquidCustomProgressIndicator(
                      direction: Axis.vertical,
                      value: fillPercentage / 100,
                      // value: 0,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          const Color(0xff00CEC8)),
                      backgroundColor: const Color(0xFF98D8F6),
                      // shapePath: buildOtherWaterTankPath(),

                      shapePath: buildThirdWaterTankPath(
                          size: Size(constraints.maxWidth * 0.35,
                              constraints.maxHeight * 0.85)),
                      // center: Column(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Text(
                      //       '${fillPercentage.toInt()}%',
                      //       textAlign: TextAlign.center,
                      //       style: TextStyle(
                      //           fontSize: 24.sp,
                      //           color: const Color(0xFFE2E8F0),
                      //           fontWeight: FontWeight.bold),
                      //     ),
                      //     Text(
                      //       'filled',
                      //       style: TextStyle(
                      //         fontSize: 14.sp,
                      //         color: const Color(0xFFE2E8F0),
                      //       ),
                      //       textAlign: TextAlign.center,
                      //     ),
                      //   ],
                      // ),
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
