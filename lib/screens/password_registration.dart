import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:water_saver/screens/homepage.dart';
import 'package:water_saver/screens/onboarding.dart';

class passwordRegistrationScreen extends StatefulWidget {
  passwordRegistrationScreen({
    super.key,
    required this.user,
  });
  final User user;
  final db = FirebaseFirestore.instance;

  @override
  State<passwordRegistrationScreen> createState() =>
      _passwordRegistrationScreenState();
}

class _passwordRegistrationScreenState
    extends State<passwordRegistrationScreen> {
  TextEditingController devicePassword = TextEditingController();
  TextEditingController reenterDevicePassword = TextEditingController();
  TextEditingController appPin = TextEditingController();
  TextEditingController reenterAppPin = TextEditingController();
  late var doc;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchDocs();
    });
  }

  Future<void> _fetchDocs() async {
    doc = await widget.db.collection("users").doc(widget.user.uid).get();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: Text("Password Registration")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  elevation: 20,
                  shadowColor: Colors.grey,
                  borderRadius: BorderRadius.circular(25),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      color: Color.fromARGB(255, 49, 139, 175),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: TextField(
                              controller: devicePassword,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                suffixIconColor: Colors.black,
                                hintText: 'Enter Device Password',
                                hintStyle: TextStyle(color: Colors.black),
                                suffixIcon: Icon(Icons.lock),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 1.0),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 1.0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: TextField(
                              controller: reenterDevicePassword,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: 'Re-enter Device Password',
                                hintStyle: TextStyle(color: Colors.black),
                                suffixIcon: Icon(Icons.lock),
                                suffixIconColor: Colors.black,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 1.0),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 1.0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (devicePassword.text.toString() ==
                                  reenterDevicePassword.text.toString()) {
                                await widget.db
                                    .collection('users')
                                    .doc(widget.user.uid)
                                    .update({
                                  "devicePassword":
                                      devicePassword.text.toString()
                                });
                                await _fetchDocs();
                                if (doc.data()!['devicePassword'] != null &&
                                    doc.data()!['appPin'] != null) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            HomeScreen(user: widget.user)),
                                  );
                                }
                                return;
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Passwords do not match!'),
                                  ),
                                );
                              }
                            },
                            child: Text(
                              'Change Device Password',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Material(
                  elevation: 20,
                  shadowColor: Colors.grey,
                  borderRadius: BorderRadius.circular(25),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      color: Color.fromARGB(255, 49, 139, 175),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: TextField(
                              controller: appPin,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: 'Enter App Pin',
                                hintStyle: TextStyle(color: Colors.black),
                                suffixIcon: Icon(Icons.lock),
                                suffixIconColor: Colors.black,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 1.0),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 1.0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: TextField(
                              controller: reenterAppPin,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: 'Re-enter App Pin',
                                hintStyle: TextStyle(color: Colors.black),
                                suffixIcon: Icon(Icons.lock),
                                suffixIconColor: Colors.black,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 1.0),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 1.0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (appPin.text.toString() ==
                                  reenterAppPin.text.toString()) {
                                await widget.db
                                    .collection('users')
                                    .doc(widget.user.uid)
                                    .update({"appPin": appPin.text.toString()});
                                await _fetchDocs();
                                if (doc.data()!['devicePassword'] != null &&
                                    doc.data()!['appPin'] != null) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            HomeScreen(user: widget.user),
                                      ));
                                }
                                return;
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Passwords do not match!'),
                                  ),
                                );
                              }
                            },
                            child: Text(
                              'Change App Pin',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
