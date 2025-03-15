import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_saver/old_screens/homepage.dart';

class PasswordRegistrationScreen extends StatefulWidget {
  const PasswordRegistrationScreen({
    super.key,
  });

  @override
  State<PasswordRegistrationScreen> createState() =>
      _PasswordRegistrationScreenState();
}

class _PasswordRegistrationScreenState
    extends State<PasswordRegistrationScreen> {
  final db = FirebaseFirestore.instance;
  TextEditingController devicePassword = TextEditingController();
  TextEditingController reenterDevicePassword = TextEditingController();
  TextEditingController appPin = TextEditingController();
  TextEditingController reenterAppPin = TextEditingController();
  final SharedPreferences prefs = Get.find();

  String? deviceId;
  late DocumentSnapshot<Map<String, dynamic>> doc;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        deviceId = prefs.getString('device_id');
        log("this has been set$deviceId");
      });
      _fetchDocs();
    });
  }

  Future<void> _fetchDocs() async {
    doc = await db.collection("users").doc(deviceId).get();
    setState(() {
      doc = doc;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Password Registration")),
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
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1.0),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                  borderSide: BorderSide(
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
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1.0),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                  borderSide: BorderSide(
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
                                await db
                                    .collection('users')
                                    .doc(deviceId)
                                    .update({
                                  "devicePassword":
                                      devicePassword.text.toString()
                                });
                                await _fetchDocs();
                                if (doc.data()!['devicePassword'] != null &&
                                    doc.data()!['appPin'] != null) {
                                  Get.to(const HomeScreen());
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
                            child: const Text(
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
                const SizedBox(
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
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1.0),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                  borderSide: BorderSide(
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
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1.0),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                  borderSide: BorderSide(
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
                                await db
                                    .collection('users')
                                    .doc(deviceId)
                                    .update({"appPin": appPin.text.toString()});
                                await _fetchDocs();
                                if (doc.data()!['devicePassword'] != null &&
                                    doc.data()!['appPin'] != null) {
                                  Get.to(const HomeScreen());
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
                            child: const Text(
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
    );
  }
}
