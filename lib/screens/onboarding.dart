import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:water_saver/screens/password_registration.dart';

class onboardingScreen extends StatefulWidget {
  onboardingScreen({super.key, required this.user});
  final User user;
  var db = FirebaseFirestore.instance;

  @override
  State<onboardingScreen> createState() => _onboardingScreenState();
}

class _onboardingScreenState extends State<onboardingScreen> {
  late TextEditingController phoneNumberController;
  late TextEditingController nameController;
  late TextEditingController emailController;
  TextEditingController deviceSerialNo = TextEditingController();
  late var doc;
  final ref = FirebaseDatabase.instance.ref();
  late var snapshot;

  @override
  void initState() {
    super.initState();
    phoneNumberController =
        TextEditingController(text: widget.user.phoneNumber);
    nameController = TextEditingController(text: widget.user.displayName);
    emailController = TextEditingController(text: widget.user.email);
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
      appBar: AppBar(
        title: Text("User Onboarding"),
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
            SizedBox(
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
            SizedBox(
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
            SizedBox(
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
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  snapshot =
                      await ref.child(deviceSerialNo.text.toString()).get();
                  if (emailController.text.isEmpty ||
                      nameController.text.isEmpty ||
                      phoneNumberController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Please fill all the fields!'),
                    ));
                    return;
                  }
                  if (snapshot.exists) {
                    if (snapshot.value.toString().toLowerCase() ==
                        nameController.text.toString().toLowerCase()) {
                      final userdata = <String, dynamic>{
                        "deviceSerialNo": deviceSerialNo.text.toString(),
                        "devicePassword": null,
                        "appPin": null,
                        "name": nameController.text.toString(),
                        "phoneNumber": phoneNumberController.text,
                        "email": emailController.text.toString(),
                        "rooftop": null,
                        "reservoir": null,
                        "savingMode": null,
                        "Motor": null,
                      };
                      await widget.db
                          .collection('users')
                          .doc(widget.user.uid)
                          .set(userdata);
                      await ref.update({
                        deviceSerialNo.text.toString():
                            widget.user.uid.toString()
                      });
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => passwordRegistrationScreen(
                                    user: widget.user,
                                  )));
                      return;
                    }
                  }
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content:
                        Text('The Device ID is invalid, please try again!'),
                  ));
                },
                child: Text('Next')),
          ],
        ),
      ),
    ));
  }
}
