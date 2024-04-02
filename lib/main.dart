import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:water_saver/firebase_options.dart';
import 'package:water_saver/screens/homepage.dart';
import 'package:water_saver/screens/otp_screen.dart';
import 'package:water_saver/screens/password_registration.dart';
import 'package:water_saver/screens/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  bool loggedIn = false;
  User? user = await FirebaseAuth.instance.currentUser;
  if (user != null) {
    loggedIn = true;
  }
  runApp(MainApp(
    loggedIn: loggedIn,
    user: user,
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.loggedIn, required this.user});
  final bool loggedIn;
  final User? user;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: loggedIn
          ? HomeScreen(
              user: user,
            )
          : SignUpScreen(),
    );
  }
}
