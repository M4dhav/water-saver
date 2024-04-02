import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:water_saver/screens/homepage.dart';
import 'package:water_saver/screens/onboarding.dart';
import 'package:water_saver/screens/signup_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.verificationId});
  final String verificationId;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otpController = TextEditingController();
  var db = FirebaseFirestore.instance;

  void forwardScreen(User user) async {
    var doc = await db.collection("users").doc(user.uid).get();
    if (doc.exists &&
        (doc.data()!['name'] != null || doc.data()!['name'] != "")) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomeScreen(
                  user: user,
                )),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => onboardingScreen(user: user)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification'),
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
              PhoneAuthCredential cred = await PhoneAuthProvider.credential(
                verificationId: widget.verificationId,
                smsCode: otpController.text.toString(),
              );
              FirebaseAuth.instance.signInWithCredential(cred).then((value) {
                print(value.user?.phoneNumber);
                forwardScreen(
                  value.user!,
                );
              });
            } catch (ex) {}
          },
          child: const Text('Verify'),
        ),
      ]),
    ));
  }
}
