import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_saver/firebase_options.dart';
import 'package:water_saver/screens/login_screen_1.dart';
import 'package:water_saver/screens/splash.dart';
import 'package:water_saver/widgets/nav_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:water_saver/screens/onboarding_screen_1.dart';
import 'package:water_saver/screens/onboarding_screen_2.dart';
import 'package:water_saver/screens/onboarding_screen_3.dart';
import 'package:water_saver/screens/onboarding_screen_4.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  Get.put(prefs);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  bool loggedIn = false;
  bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    loggedIn = true;
  }
  runApp(MainApp(
    loggedIn: loggedIn,
    isFirstTime: isFirstTime,
  ));
}

class MainApp extends StatelessWidget {
  final GoRouter _router;

  MainApp({
    super.key,
    required this.loggedIn,
    required this.isFirstTime,
  }) : _router = GoRouter(
          initialLocation: '/splash',
          routes: [
            GoRoute(
              path: '/splash',
              builder: (context, state) => const SplashScreen(),
            ),
            GoRoute(
              path: '/login',
              builder: (context, state) => LoginScreen1(),
            ),
            GoRoute(
              path: '/home',
              builder: (context, state) => const BottomNavBar(),
            ),
            GoRoute(
              path: '/onboarding1',
              builder: (context, state) => const OnboardingScreen1(),
            ),
            GoRoute(
              path: '/onboarding2',
              builder: (context, state) => const OnboardingScreen2(),
            ),
            GoRoute(
              path: '/onboarding3',
              builder: (context, state) => const OnboardingScreen3(),
            ),
            GoRoute(
              path: '/onboarding4',
              builder: (context, state) => const OnboardingScreen4(),
            ),
          ],
        );

  final bool loggedIn;
  final bool isFirstTime;

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return MaterialApp.router(
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
      );
    });
  }
}
