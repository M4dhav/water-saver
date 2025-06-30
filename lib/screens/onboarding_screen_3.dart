import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OnboardingScreen3 extends StatefulWidget {
  final bool showProgressBar;
  final bool isFromProfile;

  const OnboardingScreen3({
    super.key,
    this.showProgressBar = true,
    this.isFromProfile = false,
  });

  @override
  State<OnboardingScreen3> createState() => _OnboardingScreen3State();
}

class _OnboardingScreen3State extends State<OnboardingScreen3> {
  bool showInput = false;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.isFromProfile) {
      showInput = true; 
      _loadCurrentReservoirSize();
    }
  }

  Future<void> _loadCurrentReservoirSize() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    if (userId != null) {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (doc.exists && doc.data()?['reservoir'] != null) {
        _controller.text = doc.data()!['reservoir'].toString();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onOkPressed() async {
    if (!widget.isFromProfile) {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');
      if (userId != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .update({'hasReservoir': true});
      }
    }
    setState(() {
      showInput = true;
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      FocusScope.of(context).requestFocus(_focusNode);
    });
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
              if (widget.showProgressBar) ...[
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
                          value: 0.5,
                          backgroundColor: Colors.grey[300],
                          color: const Color(0xFF21A5FD),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 4.w),
                      child: Text('1 / 2',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.sp)),
                    ),
                  ],
                ),
                SizedBox(height: 3.h),
                Text(
                  'Do You Have a Reservoir',
                  style:
                      TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ] else ...[
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => GoRouter.of(context).pop(),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Text(
                  'Update Reservoir Size',
                  style:
                      TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ],
              SizedBox(height: 4.h),
              if (!showInput && !widget.isFromProfile)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        final userId = prefs.getString('userId');
                        if (userId != null) {
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(userId)
                              .update({'hasReservoir': false});
                        }
                        GoRouter.of(context).go('/onboarding4');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF5FAFF),
                        foregroundColor: const Color(0xFF21A5FD),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                        elevation: 0,
                        minimumSize: Size(36.w, 6.5.h),
                      ),
                      child: Text('NO', style: TextStyle(fontSize: 17.sp)),
                    ),
                    SizedBox(width: 4.w),
                    ElevatedButton(
                      onPressed: _onOkPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF21A5FD),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                        minimumSize: Size(36.w, 6.5.h),
                      ),
                      child: Text('YES', style: TextStyle(fontSize: 17.sp)),
                    ),
                  ],
                ),
              if (showInput) ...[
                SizedBox(height: widget.isFromProfile ? 4.h : 8.h),
                Text(
                  widget.isFromProfile
                      ? 'Update Your Reservoir Size'
                      : 'Kindly Specify Your Reservoir Size',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 3.h),
                Icon(Icons.local_drink, size: 8.h, color: Color(0xFF21A5FD)),
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 40.w,
                      child: TextField(
                        controller: _controller,
                        focusNode: _focusNode,
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
                          style:
                              TextStyle(fontSize: 25.sp, color: Colors.grey)),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: ElevatedButton(
                    onPressed: () async {
                      final value = _controller.text.trim();
                      if (value.isEmpty) return;
                      final prefs = await SharedPreferences.getInstance();
                      final userId = prefs.getString('userId');
                      if (userId != null) {
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(userId)
                            .update({'reservoir': int.parse(value)});
                      }
                      if (widget.isFromProfile) {
                        GoRouter.of(context).pop(); 
                      } else {
                        GoRouter.of(context).go('/onboarding4');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF21A5FD),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      minimumSize: Size.fromHeight(6.5.h),
                    ),
                    child: Text(widget.isFromProfile ? 'UPDATE' : 'Continue',
                        style: TextStyle(fontSize: 17.sp)),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
