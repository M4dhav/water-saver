import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_saver/screens/homepage.dart';
import 'package:water_saver/screens/onboarding.dart';

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

  Future<UserCredential> signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  Future<dynamic> signInWithMicrosoft() async {
    try {
      final microsoftProvider = MicrosoftAuthProvider();

      return await FirebaseAuth.instance.signInWithProvider(microsoftProvider);
    } catch (e) {
      Get.snackbar('Error', e.toString());
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
      Get.snackbar('Error', e.toString());
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
              GoogleAuthButton(
                onPressed: () async {
                  try {
                    UserCredential user = await signInWithGoogle();
                    forwardScreen(user.user!);
                  } catch (e) {
                    Get.snackbar('Error', e.toString());
                  }
                },
                style: const AuthButtonStyle(
                  iconType: AuthIconType.outlined,
                ),
              ),
              FacebookAuthButton(
                onPressed: () async {
                  await signInWithFacebook().then((value) {
                    forwardScreen(value.user!);
                  });
                },
                style: const AuthButtonStyle(
                  iconType: AuthIconType.outlined,
                ),
              ),
              MicrosoftAuthButton(
                onPressed: () async {
                  try {
                    final UserCredential user = await signInWithMicrosoft();
                    forwardScreen(user.user!);
                  } catch (e) {
                    log(e.toString());
                  }
                },
                style: const AuthButtonStyle(
                  iconType: AuthIconType.outlined,
                ),
              ),
              AppleAuthButton(
                onPressed: () {},
                style: const AuthButtonStyle(
                  iconType: AuthIconType.outlined,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
