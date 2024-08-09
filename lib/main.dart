import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_saver/firebase_options.dart';
import 'package:water_saver/screens/homepage.dart';
import 'package:water_saver/screens/signup_screen.dart';

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
  const MainApp({
    super.key,
    required this.loggedIn,
  });
  final bool loggedIn;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Water Saver',
      home: loggedIn ? const HomeScreen() : const SignUpScreen(),
    );
  }
}
