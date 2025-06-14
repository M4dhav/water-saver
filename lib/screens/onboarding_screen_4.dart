import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OnboardingScreen4 extends StatefulWidget {
  const OnboardingScreen4({super.key});

  @override
  State<OnboardingScreen4> createState() => _OnboardingScreen4State();
}

class _OnboardingScreen4State extends State<OnboardingScreen4> {
  final TextEditingController _controller = TextEditingController();
  bool isEditing = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onSavePressed() async {
    final value = _controller.text.trim();
    if (value.isEmpty) return;
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    if (userId != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'tank': int.parse(value), 'onboardingComplete': true});
    }
    GoRouter.of(context).go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 3.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => GoRouter.of(context).pop(),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: LinearProgressIndicator(
                        value: 1.0,
                        backgroundColor: Colors.grey[300],
                        color: const Color(0xFF21A5FD),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 4.w),
                    child: Text('2 / 2',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.sp)),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Text(
                'Specify Your Tank Size',
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 6.h),
              Icon(Icons.local_drink, size: 10.h, color: Color(0xFF21A5FD)),
              SizedBox(height: 2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 40.w,
                    child: TextField(
                      controller: _controller,
                      enabled: isEditing || _controller.text.isEmpty,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                          fontSize: 32.sp, fontWeight: FontWeight.bold),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '0',
                        contentPadding: EdgeInsets.zero,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 1.5.h, left: 2.w),
                    child: Text('L',
                        style: TextStyle(fontSize: 25.sp, color: Colors.grey)),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
                child: ElevatedButton(
                  onPressed: _onSavePressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF21A5FD),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    minimumSize: Size.fromHeight(6.5.h),
                  ),
                  child: Text('SAVE',
                      style: TextStyle(fontSize: 17.sp, letterSpacing: 1.5)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
