import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:water_saver/models/firebase_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 1));
    if (FirebaseAuth.instance.currentUser != null) {
      final storage = GetIt.I<FlutterSecureStorage>();
      final deviceId = await storage.read(key: 'deviceId') ?? '';
      if (deviceId.isEmpty) {
        context.go('/login');
        return;
      }

      try {
        final snap = await FBCollections.userDataReceive.doc(deviceId).get();
        final data = snap.data() as Map<String, dynamic>?;
        final calibDone =
            (data?['CALIB_DONE'] ?? 'no').toString().toLowerCase();
        if (calibDone == 'yes') {
          final isOnboardingComplete = bool.parse(
              await GetIt.I<FlutterSecureStorage>()
                      .read(key: "isOnboardingComplete") ??
                  'false');
          if (isOnboardingComplete) {
            context.go('/home');
          } else {
            context.go('/onboarding');
          }
        } else {
          context.go('/calibration');
        }
      } catch (e) {
        context.go('/home');
      }
    } else {
      bool isOnboardingComplete = bool.parse(
          await GetIt.I<FlutterSecureStorage>()
                  .read(key: "isOnboardingComplete") ??
              'false');

      if (isOnboardingComplete) {
        context.go('/login');
      } else {
        context.go('/onboarding');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF369FFF),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 2.w),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image(
                    image: const AssetImage("assets/images/logo_white.png"),
                    height: 40.h,
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
