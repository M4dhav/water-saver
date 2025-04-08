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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(await SharedPreferences.getInstance());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  bool loggedIn = false;
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    loggedIn = true;
  }
  runApp(MainApp(
    loggedIn: loggedIn,
  ));
}

class MainApp extends StatelessWidget {
  final GoRouter _router;

  MainApp({
    super.key,
    required this.loggedIn,
  }) : _router = GoRouter(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) =>
                  loggedIn ? const BottomNavBar() : const SplashScreen(),
            ),
            GoRoute(
              path: '/login',
              builder: (context, state) => LoginScreen1(),
            ),
            GoRoute(
              path: '/home',
              builder: (context, state) => const BottomNavBar(),
            ),
          ],
        );

  final bool loggedIn;

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: _router,
      );
    });
  }
}
