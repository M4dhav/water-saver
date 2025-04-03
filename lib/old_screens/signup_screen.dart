import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_saver/old_screens/homepage.dart';
import 'package:water_saver/old_screens/onboarding.dart';
import 'package:water_saver/old_screens/otp_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    super.key,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SharedPreferences prefs = Get.find();
  TextEditingController phoneController = TextEditingController();
  var db = FirebaseFirestore.instance;
  void forwardScreen(User user) async {
    final String? deviceId = prefs.getString('device_id');
    var doc = await db.collection("users").doc(deviceId).get();
    if (doc.exists &&
        (doc.data()!['name'] != null || doc.data()!['name'] != "") &&
        (doc.data()!['appPin'] != null || doc.data()!['appPin'] != "")) {
      Get.to(const HomeScreen());
    } else {
      Get.to(const OnboardingScreen());
    }
  }

  Future<bool> signOutFromGoogle() async {
    try {
      await GoogleSignIn().disconnect();
      await FirebaseAuth.instance.signOut();
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  Future<dynamic> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on Exception catch (e) {
      log('exception->$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Enter your phone number',
                    suffixIcon: const Icon(Icons.phone),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.verifyPhoneNumber(
                    verificationCompleted: (PhoneAuthCredential cred) {
                      FirebaseAuth.instance.signInWithCredential(cred).then(
                        (value) {
                          Get.to(const HomeScreen());
                        },
                      );
                    },
                    verificationFailed: (FirebaseAuthException e) {},
                    codeSent: (String verificationId, int? resendToken) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OtpScreen(
                            verificationId: verificationId,
                          ),
                        ),
                      );
                    },
                    codeAutoRetrievalTimeout: (
                      String verificationId,
                    ) {},
                    phoneNumber: "+91${phoneController.text}",
                    timeout: const Duration(seconds: 60),
                  );
                },
                child: const Text('Sign Up'),
              ),
              GoogleAuthButton(
                onPressed: () async {
                  try {
                    UserCredential user = await signInWithGoogle();
                    forwardScreen(user.user!);
                  } catch (e) {
                    log(e.toString());
                  }
                },
                style: const AuthButtonStyle(
                  iconType: AuthIconType.outlined,
                ),
              ),
            ],
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
