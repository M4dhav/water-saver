import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:water_saver/firebase_options.dart';
import 'package:water_saver/models/app_themes.dart';
import 'package:water_saver/screens/login_screen.dart';
import 'package:water_saver/screens/onboarding_screens.dart';
import 'package:water_saver/screens/personal_info.dart';
import 'package:water_saver/screens/settings.dart';
import 'package:water_saver/screens/splash.dart';
import 'package:water_saver/screens/wifi_config.dart';
import 'package:water_saver/widgets/nav_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:water_saver/screens/calibration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetIt.I.registerSingleton<FlutterSecureStorage>(FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  ));

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  final GoRouter _router;

  MainApp({
    super.key,
  }) : _router = GoRouter(
          initialLocation: '/splash',
          routes: [
            GoRoute(
              path: '/splash',
              builder: (context, state) => const SplashScreen(),
            ),
            GoRoute(
              path: '/login',
              builder: (context, state) => LoginScreen(),
            ),
            GoRoute(
              path: '/home',
              builder: (context, state) => const BottomNavBar(),
            ),
            GoRoute(
              path: '/onboarding',
              builder: (context, state) => const OnboardingScreens(),
            ),
            GoRoute(
              path: '/settings',
              builder: (context, state) => const SettingsPage(),
            ),
            GoRoute(
              path: '/calibration',
              builder: (context, state) => const CalibrationScreen(),
            ),
            GoRoute(
                path: '/wifiConfig',
                builder: (context, state) => const WifiConfigScreen()),
            GoRoute(
              path: '/personalInfo',
              builder: (context, state) => const PersonalInfoScreen(),
            )
          ],
        );

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: ResponsiveSizer(builder: (context, orientation, screenType) {
        return MaterialApp.router(
          routerConfig: _router,
          debugShowCheckedModeBanner: false,
          theme: AppColors.lightTheme,
          darkTheme: AppColors.darkTheme,
        );
      }),
    );
  }
}
