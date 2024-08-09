import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_saver/screens/homepage.dart';
import 'package:water_saver/screens/onboarding.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.verificationId});
  final String verificationId;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final SharedPreferences prefs = Get.find();
  TextEditingController otpController = TextEditingController();
  var db = FirebaseFirestore.instance;

  void forwardScreen(User user) async {
    final String? deviceId = prefs.getString('device_id');
    var doc = await db.collection("users").doc(deviceId).get();
    if (doc.exists &&
        (doc.data()!['name'] != null || doc.data()!['name'] != "")) {
      Get.to(const HomeScreen());
    } else {
      Get.to(const OnboardingScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
        centerTitle: true,
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: TextField(
            controller: otpController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              hintText: 'Enter OTP',
              suffixIcon: Icon(Icons.lock),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () async {
            try {
              PhoneAuthCredential cred = PhoneAuthProvider.credential(
                verificationId: widget.verificationId,
                smsCode: otpController.text.toString(),
              );
              FirebaseAuth.instance.signInWithCredential(cred).then((value) {
                log(value.user!.phoneNumber.toString());
                forwardScreen(
                  value.user!,
                );
              });
            } catch (ex) {
              log(ex.toString());
            }
          },
          child: const Text('Verify'),
        ),
      ]),
    ));
  }
}
