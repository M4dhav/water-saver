import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:water_saver/screens/homepage.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.verificationId});
  final String verificationId;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification'),
        centerTitle: true,
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: TextField(
            controller: otpController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              hintText: 'Enter OTP',
              suffixIcon: Icon(Icons.lock),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () async {
            try {
              PhoneAuthCredential cred = await PhoneAuthProvider.credential(
                verificationId: widget.verificationId,
                smsCode: otpController.text.toString(),
              );
              FirebaseAuth.instance.signInWithCredential(cred).then((value) {
                print(value.user?.phoneNumber);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeScreen(
                            user: value.user,
                          )),
                );
              });
            } catch (ex) {}
          },
          child: const Text('Verify'),
        ),
      ]),
    ));
  }
}
