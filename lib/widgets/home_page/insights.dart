import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';

class InsightsWidget extends StatelessWidget {
  final int buckets;
  final int washingMachines;
  final AnimatedTextController controller;

  const InsightsWidget({
    super.key,
    required this.buckets,
    required this.washingMachines,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.02),
        child: FakeGlass(
          settings: LiquidGlassSettings(refractiveIndex: 1.2, lightIntensity: 1
              // lightness: 1.2,
              ),
          shape: LiquidRoundedSuperellipse(
            borderRadius: 20,
          ),
          child: Card(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(vertical: constraints.maxHeight * 0.05),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        horizontal: constraints.maxWidth * 0.05),
                    child: AnimatedTextKit(
                      controller: controller,
                      animatedTexts: [
                        ColorizeAnimatedText(
                          'Insights',
                          textStyle: TextStyle(
                              fontFamily: GoogleFonts.inter().fontFamily,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold),
                          colors: [
                            Color.fromARGB(255, 0, 140, 255),
                            Color.fromARGB(255, 15, 62, 123),
                          ],
                        ),
                      ],
                      repeatForever: true,
                      isRepeatingAnimation: true,
                    ),
                  ),
                  Container(
                    width: constraints.maxWidth * 0.85,
                    padding: EdgeInsets.symmetric(
                        horizontal: constraints.maxWidth * 0.04,
                        vertical: constraints.maxHeight * 0.05),
                    margin: EdgeInsets.symmetric(
                        vertical: constraints.maxHeight * 0.02),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(constraints.maxWidth * 0.03),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Icon(
                            Icons.format_color_fill,
                            size: constraints.maxWidth * 0.06,
                          ),
                        ),
                        SizedBox(width: constraints.maxWidth * 0.04),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Enough for',
                              style: TextStyle(
                                fontSize: 14.sp,
                              ),
                            ),
                            AnimatedTextKit(
                              animatedTexts: [
                                ColorizeAnimatedText('$buckets 2L-buckets',
                                    textStyle: TextStyle(
                                        fontFamily:
                                            GoogleFonts.inter().fontFamily,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold),
                                    colors: [
                                      Color.fromARGB(255, 0, 140, 255),
                                      Color.fromARGB(255, 15, 62, 123),
                                    ],
                                    fadeInOnStart: false),
                              ],
                              repeatForever: true,
                              isRepeatingAnimation: true,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: constraints.maxWidth * 0.85,
                    padding: EdgeInsets.symmetric(
                        horizontal: constraints.maxWidth * 0.04,
                        vertical: constraints.maxHeight * 0.05),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(3.w),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Icon(
                            Icons.local_laundry_service,
                            size: constraints.maxWidth * 0.06,
                          ),
                        ),
                        SizedBox(width: constraints.maxWidth * 0.04),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Enough for',
                              style: TextStyle(
                                fontSize: 14.sp,
                              ),
                            ),
                            AnimatedTextKit(
                              controller: controller,
                              animatedTexts: [
                                ColorizeAnimatedText(
                                  '$washingMachines washing machines',
                                  textStyle: TextStyle(
                                      fontFamily:
                                          GoogleFonts.inter().fontFamily,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold),
                                  colors: [
                                    Color.fromARGB(255, 0, 140, 255),
                                    Color.fromARGB(255, 15, 62, 123),
                                  ],
                                  // fadeInOnStart: false,
                                  // fadeOutOnEnd: false,
                                ),
                              ],
                              repeatForever: true,
                              isRepeatingAnimation: true,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
