import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_saver/screens/settings.dart';

class EnterPasswordScreen extends StatefulWidget {
  const EnterPasswordScreen({super.key, this.isAppPassword = false});
  final bool isAppPassword;

  @override
  State<EnterPasswordScreen> createState() => _EnterPasswordScreenState();
}

class _EnterPasswordScreenState extends State<EnterPasswordScreen> {
  final db = FirebaseFirestore.instance;
  TextEditingController devicePassword = TextEditingController();
  TextEditingController reenterDevicePassword = TextEditingController();
  TextEditingController appPin = TextEditingController();
  TextEditingController reenterAppPin = TextEditingController();
  final SharedPreferences prefs = Get.find();
  String? deviceId;
  late DocumentSnapshot<Map<String, dynamic>> doc;

  Future<void> _fetchDocs() async {
    doc = await db.collection("users").doc(deviceId).get();
    setState(() {
      doc = doc;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        deviceId = prefs.getString('device_id');
      });
      _fetchDocs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff081c5c),
      appBar: AppBar(
        title: Text(widget.isAppPassword
            ? 'Enter App Password'
            : 'Enter Device Password'),
        backgroundColor: const Color(0xff081c5c),
        foregroundColor: Colors.white,
      ),
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
                          ElevatedButton(
                            onPressed: () async {
                              if (doc.data()!['devicePassword'] ==
                                  devicePassword.text.toString()) {
                                Get.off(
                                  const SettingsPage(),
                                );
                                return;
                              } else {
                                Get.snackbar("Incorrect Password",
                                    "Passwords do not match");
                              }
                            },
                            child: const Text(
                              'Verify Device Password',
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
