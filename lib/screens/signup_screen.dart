import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:water_saver/widgets/login_page/custom_button.dart';
import 'package:water_saver/widgets/login_page/input_fields.dart';
import 'package:water_saver/controllers/auth_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _LoginScreen2State createState() => _LoginScreen2State();
}

class _LoginScreen2State extends State<SignUpScreen> {
  final AuthController _authController = AuthController();
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 5.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "JOIN OSTS TODAY ✨",
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 1.h),
              const Text(
                "Create an account to track your water tank",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 5.h),
              InputField(
                label: "Email",
                hintText: "Email",
                prefixIcon: Icons.email_outlined,
              ),
              SizedBox(height: 2.h),
              InputField(
                label: "Password",
                hintText: "Password",
                prefixIcon: Icons.lock_outline,
                isPassword: true,
              ),
              SizedBox(height: 2.h),
              Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                    activeColor: Colors.blue,
                  ),
                  const Text("I agree to OSTS "),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      "Terms & Conditions",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              Center(
                child: GestureDetector(
                  onTap: () {},
                  child: const Text.rich(
                    TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: "Sign in",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              const Row(
                children: const [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("or"),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              SizedBox(height: 2.h),
              Column(
                children: [
                  CustomButton(
                    text: "Continue with Google",
                    icon: FontAwesomeIcons.google,
                    color: Colors.red,
                    height: 6,
                    width: double.infinity,
                    borderRadius: 10,
                    onTap: () async {
                      await _authController.signInWithGoogle(context);
                    },
                  ),
                  SizedBox(height: 10),
                  CustomButton(
                    text: "Continue with Apple",
                    icon: Icons.apple,
                    color: Colors.black,
                    height: 6,
                    width: double.infinity,
                    borderRadius: 10,
                    onTap: () {},
                  ),
                ],
              ),
              SizedBox(height: 6.h),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Sign up",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
