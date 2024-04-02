import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:water_saver/screens/signup_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key, required this.user});
  final User? user;
  var db = FirebaseFirestore.instance;
  final userdata = <String, dynamic>{
    "deviceSerialNo": null,
    "devicePassword": null,
    "appPin": null,
    "name": null,
    "phoneNumber": null,
    "email": null,
    "rooftop": null,
    "reservoir": null,
    "savingMode": null,
    "Motor": null,
  };

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _logout() async {
    try {
      await GoogleSignIn().disconnect();
    } catch (e) {
      print(e);
    }
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Center(
              child: Text(widget.user?.phoneNumber ?? 'No phone number found!'),
            ),
            Center(
              child: Text(widget.user?.displayName ?? 'No name found!'),
            ),
            Center(
              child: Text(widget.user?.uid ?? 'No tenant ID found!'),
            ),
            ElevatedButton(
              onPressed: () {
                _logout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                );
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
