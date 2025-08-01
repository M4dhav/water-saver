import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MotorControlsWidget extends StatelessWidget {
  final bool isMotorOn;
  final bool isAutoMode;
  final VoidCallback onMotorToggle;
  final VoidCallback onAutoToggle;
  final VoidCallback onMotorButtonPressed;

  const MotorControlsWidget({
    super.key,
    required this.isMotorOn,
    required this.isAutoMode,
    required this.onMotorToggle,
    required this.onAutoToggle,
    required this.onMotorButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: const Color(0xFF071526),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Motor',
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Switch(
                    value: isMotorOn,
                    onChanged: (_) => onMotorToggle(),
                    activeColor: const Color(0xFF4ADE80),
                    activeTrackColor: const Color(0xFF1E40AF),
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: Colors.grey[700],
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Auto',
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Switch(
                    value: isAutoMode,
                    onChanged: (_) => onAutoToggle(),
                    activeColor: const Color(0xFF4ADE80),
                    activeTrackColor: const Color(0xFF1E40AF),
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: Colors.grey[700],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 3.h),
          SizedBox(
            width: 60.w,
            child: ElevatedButton(
              onPressed: onMotorButtonPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E40AF),
                padding: EdgeInsets.symmetric(vertical: 2.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Motor-${isMotorOn ? 'ON' : 'OFF'}',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: isMotorOn ? const Color(0xFF4ADE80) : Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
