import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:water_saver/firebase_options.dart';
import 'package:water_saver/screens/otp_screen.dart';
import 'package:water_saver/screens/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: SignUpScreen(),
    );
  }
}
