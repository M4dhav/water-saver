import 'dart:developer';

import 'package:auth_button_kit/auth_button_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:water_saver/controllers/auth_controller.dart';
import 'package:water_saver/providers/app_user_controller_provider.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  final AuthController _authController = AuthController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFF071526),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 7.w),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Image(
                  image: AssetImage("assets/images/logo_white.png"),
                  height: 15.h),
              SizedBox(height: 5.w),
              Text(
                "Let's Get Started!",
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Let's dive in into your account",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 2.h),
              Column(
                children: [
                  AuthButton(
                    onPressed: (Method method) async {
                      if (method == Method.google) {
                        final router = GoRouter.of(context);
                        final messenger = ScaffoldMessenger.of(context);
                        final user = await _authController.signInWithGoogle();
                        if (user != null) {
                          log(user.email ?? 'No email');
                          _authController
                              .checkIfUserExists(user.email ?? '')
                              .then((exists) async {
                            if (!exists) {
                              messenger.showSnackBar(
                                const SnackBar(
                                    content: Text('User does not exist')),
                              );
                            } else {
                              try {
                                final appUser = await ref
                                    .read(appUserControllerProvider.future);
                                final userDataUpload = appUser.userDataUpload;
                                final userDataReceive = appUser.userDataReceive;
                                if (userDataUpload.calibDone == 'yes') {
                                  if (userDataReceive.wifiConfig == 'true') {
                                    router.go('/home');
                                  } else {
                                    router.go('/wifiConfig');
                                  }
                                } else {
                                  if (userDataReceive.wifiConfig == 'true') {
                                    router.go('/calibration');
                                  } else {
                                    router.go('/wifiConfig');
                                  }
                                }
                              } catch (e) {
                                log('Error checking user data for navigation: $e');
                                router.go('/wifiConfig');
                              }
                            }
                          });
                        } else {
                          messenger.showSnackBar(
                            const SnackBar(content: Text('Login failed')),
                          );
                        }
                      }
                    },
                    brand: Method.google,
                  ),
                  AuthButton(
                    brand: Method.apple,
                    onPressed: (Method method) async {},
                  ),
                ],
              ),
              const Spacer(),
              const Text(
                "Privacy Policy  ·  Terms of Service",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white54,
                ),
              ),
              SizedBox(height: 1.h),
            ],
          ),
        ),
      ),
    );
  }
}
