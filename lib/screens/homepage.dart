import 'dart:developer';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_saver/screens/enter_password.dart';
import 'package:water_saver/screens/signup_screen.dart';
import 'package:water_saver/screens/graph.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SharedPreferences prefs = Get.find();
  late String? deviceId = prefs.getString('device_id');
  User? user = FirebaseAuth.instance.currentUser;
  Map<String, dynamic> userdata = {};
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(deviceId)
          .get();

      setState(() {
        userdata = doc.data() as Map<String, dynamic>;
      });
    });
    listenToChangeOfCategories();
  }

  void listenToChangeOfCategories() {
    // collection we are going to listen
    final document =
        FirebaseFirestore.instance.collection('users').doc(deviceId);
    // start to listen
    document.snapshots().listen((change) async {
      setState(() {
        userdata = change.data() as Map<String, dynamic>;
      });
    });
  }

  void _logout() async {
    try {
      await GoogleSignIn().disconnect();
    } catch (e) {
      log(e.toString());
    }
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return userdata.isEmpty
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text('Home'),
              centerTitle: true,
              actions: [
                ElevatedButton(
                  onPressed: () {
                    _logout();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpScreen()),
                    );
                  },
                  child: const Text('Logout'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      userdata['isFetching'] = true;
                    });
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(deviceId)
                        .update(userdata);
                  },
                  child: const Text('Fetch Data'),
                ),
              ],
            ),
            body: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TopBarButton(
                        icon: Icons.auto_graph,
                        buttonText: 'Usage Data',
                        onTap: () {
                          Get.to(const LineChartPage(isShowingMainData: true));
                        },
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      TopBarButton(
                        icon: Icons.settings,
                        buttonText: "Device Settings",
                        onTap: () {
                          Get.to(const EnterPasswordScreen());
                        },
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      TopBarButton(
                          icon: Icons.calendar_today,
                          buttonText: "Calendar",
                          onTap: () {})
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TankWidget(
                  userdata: userdata,
                  tankName: "Rooftop",
                ),
                TankWidget(
                  userdata: userdata,
                  tankName: "Reservoir",
                ),
                SettingsToggleWidget(
                    settingName: "Saving Mode",
                    toggleState: userdata['savingMode'],
                    onChanged: (value) async {
                      setState(() {
                        userdata['savingMode'] = value;
                      });
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(deviceId)
                          .update(userdata);
                    }),
                SettingsToggleWidget(
                    settingName: "Motor",
                    toggleState: userdata['Motor'],
                    onChanged: (value) async {
                      setState(() {
                        userdata['Motor'] = value;
                      });
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(deviceId)
                          .update(userdata);
                    }),
                SettingsToggleWidget(
                    settingName: "Indicator LED",
                    toggleState: userdata['ledMode'],
                    onChanged: (value) async {
                      setState(() {
                        userdata['ledMode'] = value;
                      });
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(deviceId)
                          .update(userdata);
                    }),
              ],
            ),
          );
  }
}

class SettingsToggleWidget extends StatelessWidget {
  const SettingsToggleWidget({
    super.key,
    required this.toggleState,
    required this.onChanged,
    required this.settingName,
  });

  final bool toggleState;
  final Function(bool)? onChanged;
  final String settingName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 10),
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                settingName,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              AnimatedToggleSwitch<bool>.rolling(
                current: toggleState,
                values: const [false, true],
                onChanged: onChanged,
                iconList: const [Text('Off'), Text('On')],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TankWidget extends StatelessWidget {
  const TankWidget({
    super.key,
    required this.userdata,
    required this.tankName,
  });

  final Map<String, dynamic> userdata;
  final String tankName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 10),
      child: Container(
          width: double.infinity,
          height: 160,
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(20)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    tankName,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Icon(
                    Icons.water,
                    size: 60,
                  )
                ],
              ),
              const Text(
                "Tank Fill",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                "${((userdata[tankName.toLowerCase()] / 4095) * 100).toInt()}%",
                style:
                    const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              )
            ],
          )),
    );
  }
}

class TopBarButton extends StatelessWidget {
  const TopBarButton(
      {super.key,
      required this.icon,
      required this.buttonText,
      required this.onTap});
  final IconData icon;
  final String buttonText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 100,
          width: 100,
          //color: Colors.black,
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
              ),
              Text(
                buttonText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )),
    );
  }
}
