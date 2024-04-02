import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:water_saver/firebase_options.dart';
import 'package:water_saver/screens/homepage.dart';
import 'package:water_saver/screens/onboarding.dart';
import 'package:water_saver/screens/otp_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:water_saver/main.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    super.key,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController phoneController = TextEditingController();
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
      print('exception->$e');
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
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen(
                                      user: value.user,
                                    )),
                          );
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
                child: Text('Sign Up'),
              ),
              GoogleAuthButton(
                onPressed: () async {
                  try {
                    UserCredential user = await signInWithGoogle();
                    forwardScreen(user.user!);
                  } catch (e) {
                    print(e);
                  }
                },
                style: const AuthButtonStyle(
                  iconType: AuthIconType.outlined,
                ),
              ),
              MicrosoftAuthButton(
                onPressed: () {
                  signOutFromGoogle();
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
