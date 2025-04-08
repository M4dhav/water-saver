import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:water_saver/controllers/auth_controller.dart';
import 'package:water_saver/screens/signin_screen.dart';
import 'package:water_saver/widgets/login_page/custom_button.dart';
import 'package:water_saver/screens/signup_screen.dart';

class LoginScreen1 extends StatelessWidget {
  LoginScreen1({Key? key}) : super(key: key);

  final AuthController _authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 7.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Image(
                image: AssetImage("assets/images/logo_blue.png"), height: 15.h),
            SizedBox(height: 5.w),
            Text(
              "Let's Get Started!",
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Let's dive in into your account",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
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
                SizedBox(height: 2.h),
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
            SizedBox(height: 5.h),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const SignUpScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Center(
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 2.h),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const SignInScreen()),
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.lightBlue[100],
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Center(
                child: Text(
                  "Sign In",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            const Spacer(),
            const Text(
              "Privacy Policy  ·  Terms of Service",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
