import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:water_saver/providers/app_user_controller_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenRefactoredState();
}

class _SplashScreenRefactoredState extends ConsumerState<SplashScreen> {
  bool _isInitializing = false;
  bool _isUserLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    setState(() {
      _isInitializing = true;
    });

    // Add minimum splash delay for better UX
    await Future.delayed(const Duration(seconds: 1));

    // Step 1: Check if user is logged in
    final User? currentUser = FirebaseAuth.instance.currentUser;
    _isUserLoggedIn = currentUser != null;

    if (_isUserLoggedIn) {
      // Step 2: If user is logged in, instantiate appUserControllerProvider
      try {
        log('User is logged in, initializing appUserControllerProvider...');
        // This will trigger the build method of AppUserController
        await ref.read(appUserControllerProvider.future);
        log('appUserControllerProvider initialized successfully');
      } catch (e) {
        log('Error initializing appUserControllerProvider: $e');
        // Continue with routing even if provider initialization fails
      }
    }

    // Step 3: Use routing logic based on login status
    if (mounted) {
      await _performRouting(_isUserLoggedIn);
    }

    setState(() {
      _isInitializing = false;
    });
  }

  Future<void> _performRouting(bool isLoggedIn) async {
    final router = GoRouter.of(context);

    if (isLoggedIn) {
      // User is logged in - check device and calibration status
      final storage = GetIt.I<FlutterSecureStorage>();
      final deviceId = await storage.read(key: 'deviceId') ?? '';

      if (deviceId.isEmpty) {
        router.go('/login');
        return;
      }

      try {
        final appUser = ref.read(appUserControllerProvider);

        if (appUser.requireValue.userDataUpload.calibDone == 'yes') {
          router.go('/home');
        } else {
          router.go('/wifiConfig');
        }
      } catch (e) {
        log('Error checking calibration status: $e');
        router.go('/home');
      }
    } else {
      // User is not logged in - check onboarding status
      bool isOnboardingComplete = bool.parse(
          await GetIt.I<FlutterSecureStorage>()
                  .read(key: "isOnboardingComplete") ??
              'false');

      if (isOnboardingComplete) {
        router.go('/login');
      } else {
        router.go('/onboarding');
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
                  if (_isInitializing && _isUserLoggedIn) ...[
                    SizedBox(height: 3.h),
                    Text(
                      'Initializing user data...',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
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
