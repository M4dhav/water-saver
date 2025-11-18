import 'dart:math';

import 'package:flutter/material.dart';
import 'package:inner_shadow_container/inner_shadow_container.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:water_saver/models/app_themes.dart';

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
          child: Container(
            color: Theme.of(context).cardColor,
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
                      animatedTexts: [
                        ColorizeAnimatedText(
                          fadeInOnStart: false,
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
                        vertical: constraints.maxHeight * 0.05),
                    margin: EdgeInsets.symmetric(
                        vertical: constraints.maxHeight * 0.02),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(constraints.maxWidth * 0.03),
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
                              fadeInOnStart: false,
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
                        Container(
                          width: constraints.maxWidth * 0.2,
                          height: constraints.maxHeight * 0.2,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(40),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: 0,
                                  blurRadius: 10,
                                  offset: Offset(1, 5),
                                )
                              ]),
                          child: InnerShadowContainer(
                            isShadowTopLeft: true,
                            isShadowTopRight: true,
                            backgroundColor: isMotorOn
                                ? Color.fromARGB(255, 145, 232, 244)
                                : Colors.white,
                            borderRadius: 40,
                            offset: Offset(4, -2),
                            child: Transform.scale(
                              scale: 1.2,
                              child: Switch(
                                value: isMotorOn,
                                onChanged: (_) => onMotorToggle(),
                                activeTrackColor: Colors.transparent,
                                inactiveThumbColor:
                                    const Color.fromARGB(255, 169, 169, 169),
                                activeThumbColor:
                                    AppColors.primaryGradient.colors.first,
                                inactiveTrackColor: Colors.transparent,
                                trackOutlineColor:
                                    WidgetStateProperty.all<Color>(
                                        Colors.transparent),
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
                        vertical: constraints.maxHeight * 0.05),
                    margin: EdgeInsets.symmetric(
                        vertical: constraints.maxHeight * 0.02),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(constraints.maxWidth * 0.03),
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
                              fadeInOnStart: false,
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
                        Container(
                          width: constraints.maxWidth * 0.2,
                          height: constraints.maxHeight * 0.2,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(40),
                              //TODO
                              color: Color.fromARGB(255, 145, 232, 244),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: 0,
                                  blurRadius: 10,
                                  offset: Offset(1, 5),
                                )
                              ]),
                          child: InnerShadowContainer(
                            isShadowTopLeft: true,
                            isShadowTopRight: true,
                            backgroundColor: isAutoMode
                                ? Color.fromARGB(255, 145, 232, 244)
                                : Colors.white,
                            borderRadius: 40,
                            offset: Offset(4, -2),
                            child: Transform.scale(
                              scale: 1.2,
                              child: Switch(
                                value: isAutoMode,
                                onChanged: (_) => onAutoToggle(),
                                activeTrackColor: Colors.transparent,
                                inactiveThumbColor: Colors.black,
                                inactiveTrackColor: Colors.transparent,
                                activeThumbColor:
                                    AppColors.primaryGradient.colors.first,
                                trackOutlineColor:
                                    WidgetStateProperty.all<Color>(
                                        Colors.transparent),
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
      );
    });
  }
}
