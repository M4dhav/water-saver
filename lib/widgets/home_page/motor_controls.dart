import 'dart:math';

import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:google_fonts/google_fonts.dart';

class MotorControlsWidget extends StatelessWidget {
  final bool isMotorOn;
  final bool isAutoMode;
  final VoidCallback onMotorToggle;
  final VoidCallback onAutoToggle;
  final VoidCallback onMotorButtonPressed;
  final AnimatedTextController controller;

  const MotorControlsWidget({
    super.key,
    required this.isMotorOn,
    required this.isAutoMode,
    required this.onMotorToggle,
    required this.onAutoToggle,
    required this.onMotorButtonPressed,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.02),
        child: FakeGlass(
          shape: LiquidRoundedSuperellipse(
            borderRadius: 20,
          ),
          settings: LiquidGlassSettings(
            refractiveIndex: 1.2,
            // lightness: 1.2,
          ),
          child: Card(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(vertical: constraints.maxHeight * 0.04),
              child: LiquidGlassLayer(
                // settings: LiquidGlassSettings(
                //   refractiveIndex: 0,
                //   // lightness: 1.0,
                //   ambientStrength: 0.5,
                //   blur: 5,
                //   lightAngle: pi,
                //   thickness: 100,
                //   glassColor: isMotorOn
                //       ? const Color.fromARGB(100, 74, 165, 207)
                //       : Colors.white.withAlpha(50),
                // ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          horizontal: constraints.maxWidth * 0.05),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          ColorizeAnimatedText(
                            'Water Controls',
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
                      child: Row(
                        children: [
                          Container(
                            padding:
                                EdgeInsets.all(constraints.maxWidth * 0.03),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Icon(
                              Icons.water_drop,
                              size: constraints.maxWidth * 0.06,
                            ),
                          ),
                          SizedBox(width: constraints.maxWidth * 0.04),
                          AnimatedTextKit(
                            controller: controller,
                            animatedTexts: [
                              ColorizeAnimatedText(
                                'Motor',
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
                          Spacer(),
                          Material(
                            elevation: 15,
                            color: Colors.transparent,
                            borderOnForeground: false,
                            animateColor: false,
                            surfaceTintColor: Colors.transparent,
                            child: FakeGlass(
                              settings: LiquidGlassSettings(
                                refractiveIndex: 0,
                                // lightness: 1.0,
                                ambientStrength: 0.5,
                                blur: 5,
                                lightAngle: pi,
                                thickness: 100,
                                glassColor: isMotorOn
                                    ? const Color.fromARGB(100, 74, 165, 207)
                                    : Colors.white.withAlpha(50),
                              ),
                              shape:
                                  LiquidRoundedSuperellipse(borderRadius: 40),
                              // glassContainsChild: true,
                              child: SizedBox(
                                width: constraints.maxWidth * 0.2,
                                height: constraints.maxHeight * 0.2,
                                child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Switch(
                                    value: isMotorOn,
                                    onChanged: (_) => onMotorToggle(),
                                    activeTrackColor: Colors.transparent,
                                    inactiveThumbColor: Colors.black,
                                    inactiveTrackColor: Colors.transparent,
                                    trackOutlineColor:
                                        WidgetStateProperty.all<Color>(
                                            Colors.transparent),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: constraints.maxWidth * 0.85,
                      padding: EdgeInsets.symmetric(
                          horizontal: constraints.maxWidth * 0.04,
                          vertical: constraints.maxHeight * 0.05),
                      margin: EdgeInsets.symmetric(
                          vertical: constraints.maxHeight * 0.02),
                      child: Row(
                        children: [
                          Container(
                            padding:
                                EdgeInsets.all(constraints.maxWidth * 0.03),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Icon(
                              Icons.auto_mode,
                              size: constraints.maxWidth * 0.06,
                            ),
                          ),
                          SizedBox(width: constraints.maxWidth * 0.04),
                          AnimatedTextKit(
                            controller: controller,
                            animatedTexts: [
                              ColorizeAnimatedText(
                                'Auto Mode',
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
                          Spacer(),
                          Material(
                            elevation: 15,
                            color: Colors.transparent,
                            borderOnForeground: false,
                            animateColor: false,
                            surfaceTintColor: Colors.transparent,
                            child: FakeGlass(
                              shape:
                                  LiquidRoundedSuperellipse(borderRadius: 40),
                              settings: LiquidGlassSettings(
                                refractiveIndex: 0,
                                // lightness: 1.0,
                                ambientStrength: 0.5,
                                blur: 5,
                                lightAngle: pi,
                                thickness: 100,
                                glassColor: isAutoMode
                                    ? const Color.fromARGB(100, 74, 165, 207)
                                    : Colors.white.withAlpha(50),
                              ),
                              // glassContainsChild: true,
                              child: SizedBox(
                                width: constraints.maxWidth * 0.2,
                                height: constraints.maxHeight * 0.2,
                                child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Switch(
                                    value: isAutoMode,
                                    onChanged: (_) => onAutoToggle(),
                                    activeTrackColor: Colors.transparent,
                                    inactiveThumbColor: Colors.black,
                                    inactiveTrackColor: Colors.transparent,
                                    trackOutlineColor:
                                        WidgetStateProperty.all<Color>(
                                            Colors.transparent),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
