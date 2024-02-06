import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.user});
  final User? user;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          ],
        ),
      ),
    );
  }
}
