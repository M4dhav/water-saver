import 'dart:developer';

import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:water_saver/controllers/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final AuthController _authController = AuthController();

  @override
  Widget build(BuildContext context) {
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
                  GoogleAuthButton(
                    onPressed: () async {
                      final user = await _authController.signInWithGoogle();
                      if (user != null) {
                        log(user.email ?? 'No email');
                        _authController
                            .checkIfUserExists(user.email ?? '')
                            .then((exists) {
                          if (!exists) {
                            // Navigate to personal info screen if user does not exist
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('User does not exist')),
                            );
                          } else {
                            // Navigate to home screen if user exists
                            GoRouter.of(context).go('/home');
                          }
                        });
                        // Navigate to the next screen or perform any action after successful login
                      } else {
                        // Handle the case where login failed
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Login failed')),
                        );
                      }
                    },
                    themeMode: ThemeMode.light,
                  ),
                  AppleAuthButton(
                    themeMode: ThemeMode.light,
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
