import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:water_saver/screens/password_registration.dart';
import 'package:water_saver/screens/signup_screen.dart';
import 'package:water_saver/screens/graph.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key, required this.user});
  final User? user;
  var db = FirebaseFirestore.instance;
  Map<String, dynamic> userdata = {};
  int error = 0;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.user!.uid)
          .get();
      widget.userdata = doc.data() as Map<String, dynamic>;
      if (await FlutterBluePlus.isSupported == false) {
        print("Bluetooth not supported by this device");
        return;
      }
      listenToChangeOfCategories();
    });
  }

  listenToChangeOfCategories() {
    print('listening just started......');
    // collection we are going to listen
    final document =
        FirebaseFirestore.instance.collection('users').doc(widget.user!.uid);
    // start to listen
    final listener = document.snapshots().listen((change) async {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.user!.uid)
          .get();
      widget.userdata = doc.data() as Map<String, dynamic>;
      if (widget.userdata['reservoir'] < 0) {
        setState(() {
          widget.error = 1;
        });
      } else {
        setState(() {
          widget.error = 0;
        });
      }
    });
    // if listener implemented its job then cancel
    listener.onDone(() {
      listener.cancel();
    });
  }

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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                LineChartPage(isShowingMainData: true),
                          ));
                    },
                    child: Container(
                        height: 150,
                        width: 150,
                        //color: Colors.black,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.auto_graph,
                              size: 75,
                            ),
                            Text(
                              'Usage Data',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                passwordRegistrationScreen(user: widget.user!)),
                      );
                    },
                    child: Container(
                        height: 150,
                        width: 150,
                        //color: Colors.black,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.settings,
                              size: 75,
                            ),
                            Text(
                              'Device Settings',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                  width: double.infinity,
                  height: 160,
                  //color: Colors.grey,
                  decoration: BoxDecoration(
                      color: widget.error == 0 ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          "Current Value ${widget.userdata['reservoir']}",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )),
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
