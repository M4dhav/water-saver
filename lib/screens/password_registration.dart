import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_saver/screens/homepage.dart';

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
  final List<bool> obscureText = [true, true, true, true];

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
                              obscureText: obscureText[0],
                              controller: devicePassword,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: 'Enter Device Password',
                                hintStyle: const TextStyle(color: Colors.black),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        obscureText[0] = !obscureText[0];
                                      });
                                    },
                                    icon: Icon(
                                      Icons.remove_red_eye,
                                      size: 20.px,
                                      color: Colors.black,
                                    )),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1.0),
                                ),
                                border: const OutlineInputBorder(
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
                              obscureText: obscureText[1],
                              controller: reenterDevicePassword,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: 'Re-enter Device Password',
                                hintStyle: const TextStyle(color: Colors.black),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        obscureText[1] = !obscureText[1];
                                      });
                                    },
                                    icon: Icon(
                                      Icons.remove_red_eye,
                                      color: Colors.black,
                                      size: 20.px,
                                    )),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1.0),
                                ),
                                border: const OutlineInputBorder(
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
                                Get.snackbar('Password Changed',
                                    'Device Password was changed successfully');
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
                              obscureText: obscureText[2],
                              controller: appPin,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: 'Enter App Pin',
                                hintStyle: const TextStyle(color: Colors.black),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        obscureText[2] = !obscureText[2];
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.remove_red_eye,
                                      color: Colors.black,
                                    )),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1.0),
                                ),
                                border: const OutlineInputBorder(
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
                              obscureText: obscureText[3],
                              controller: reenterAppPin,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: 'Re-enter App Pin',
                                hintStyle: const TextStyle(color: Colors.black),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        obscureText[3] = !obscureText[3];
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.remove_red_eye,
                                      color: Colors.black,
                                    )),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1.0),
                                ),
                                border: const OutlineInputBorder(
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
                                Get.snackbar('Password Changed',
                                    'App Pin was changed successfully');
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
