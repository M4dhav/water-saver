import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/userdata.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      final user = userCredential.user;
      if (user != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('userId', user.uid);
        final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        if (!doc.exists) {
          await createUserData(
            userId: user.uid,
            name: user.displayName ?? '',
            email: user.email ?? '',
            reservoir: 0,
            tank: 0,
          );
        }
        await handlePostLogin(context, user.uid);
      }

      return userCredential.user;
    } catch (e) {
      print('Error during Google Sign-In: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  Future<void> handlePostLogin(BuildContext context, String userId) async {
    final doc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (doc.exists && doc.data()?['onboardingComplete'] == true) {
      GoRouter.of(context).go('/home');
    } else {
      GoRouter.of(context).go('/onboarding1');
    }
  }

  Future<void> createUserData({
    required String userId,
    required String name,
    required String email,
    required int reservoir,
    required int tank,
  }) async {
    final userData = UserData(
      name: name,
      email: email,
      reservoir: reservoir,
      tank: tank,
      onboardingComplete: false,
    );
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set(userData.toMap());
  }
}
