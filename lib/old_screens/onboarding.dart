import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_saver/old_screens/password_registration.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({
    super.key,
  });

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final User user = FirebaseAuth.instance.currentUser!;
  var db = FirebaseFirestore.instance;
  late TextEditingController phoneNumberController;
  late TextEditingController nameController;
  late TextEditingController emailController;
  TextEditingController deviceSerialNo = TextEditingController();
  late DocumentSnapshot doc;
  final ref = FirebaseDatabase.instance.ref();
  final SharedPreferences prefs = Get.find();

  late DataSnapshot snapshot;

  @override
  void initState() {
    super.initState();
    phoneNumberController = TextEditingController(text: user.phoneNumber);
    nameController = TextEditingController(text: user.displayName);
    emailController = TextEditingController(text: user.email);
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("User Onboarding"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: deviceSerialNo,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter Device Serial No',
                suffixIcon: Icon(Icons.device_unknown),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: nameController,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                hintText: 'Enter Name',
                suffixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: 'Enter Phone Number',
                suffixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Enter Email Address',
                suffixIcon: Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  snapshot =
                      await ref.child(deviceSerialNo.text.toString()).get();
                  if (emailController.text.isEmpty ||
                      nameController.text.isEmpty ||
                      phoneNumberController.text.isEmpty) {
                    Get.snackbar("Empty Fields", "Please fill all the details");
                    return;
                  }
                  if (snapshot.exists) {
                    if (snapshot.value.toString().toLowerCase() ==
                        nameController.text.toString().toLowerCase()) {
                      await prefs.setString('device_id', deviceSerialNo.text);
                      final userdata = <String, dynamic>{
                        "uid": user.uid,
                        "deviceSerialNo": deviceSerialNo.text.toString(),
                        "devicePassword": null,
                        "appPin": null,
                        "name": nameController.text.toString(),
                        "phoneNumber": phoneNumberController.text,
                        "email": emailController.text.toString(),
                        "rooftop": 0,
                        "reservoir": 0,
                        "savingMode": false,
                        "Motor": false,
                        "isFetching": false,
                        "ledMode": false,
                      };
                      await db
                          .collection('users')
                          .doc(deviceSerialNo.text.toString())
                          .set(userdata);
                      Get.to(const PasswordRegistrationScreen());
                      return;
                    }
                  }
                  Get.snackbar("Invalid Details",
                      "The Device ID is invalid, please try again!");
                },
                child: const Text('Next')),
          ],
        ),
      ),
    ));
  }
}
