import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:water_saver/widgets/login_page/custom_button.dart';
import 'package:water_saver/widgets/login_page/input_fields.dart';
import 'package:water_saver/controllers/auth_controller.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController _authController = AuthController();

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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome Back! 👋",
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 1.h),
            const Text(
              "Sign in to your account to continue your journey",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 5.h),
            const InputField(
              label: "Email",
              hintText: "Email",
              prefixIcon: Icons.email_outlined,
            ),
            SizedBox(height: 2.h),
            const InputField(
              label: "Password",
              hintText: "Password",
              prefixIcon: Icons.lock_outline,
              isPassword: true,
            ),
            SizedBox(height: 2.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: false,
                      onChanged: (value) {},
                      activeColor: Colors.blue,
                    ),
                    const Text("Remember me"),
                  ],
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Row(
              children: [
                const Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1.h),
                  child: const Text("or"),
                ),
                const Expanded(child: Divider()),
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
                  "Sign in",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
