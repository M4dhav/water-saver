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
      // padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: const Color(0xFF071526),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: const Color(0xFF1E3A8A),
                    borderRadius: BorderRadius.circular(12)),
                width: 40.w,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.gas_meter,
                        color: Colors.white,
                      ),
                      Text(
                        'Motor',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Tooltip(
                        message: isAutoMode ? 'Disabled in Auto mode' : '',
                        triggerMode: TooltipTriggerMode.tap,
                        child: Switch(
                          value: isMotorOn,
                          onChanged: (_) => onMotorToggle(),
                          activeColor: Color.fromARGB(255, 152, 216, 246),
                          activeTrackColor: Color.fromARGB(255, 54, 159, 208),
                          inactiveThumbColor:
                              Color.fromARGB(255, 152, 216, 246),
                          inactiveTrackColor: Colors.grey[700],
                        ),
                      ),
                    ]),
              ),
              Container(
                decoration: BoxDecoration(
                    color: const Color(0xFF1E3A8A),
                    borderRadius: BorderRadius.circular(12)),
                width: 40.w,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.auto_mode,
                        color: Colors.white,
                      ),
                      Text(
                        isAutoMode ? 'Auto' : 'Manual',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Switch(
                        value: isAutoMode,
                        onChanged: (_) => onAutoToggle(),
                        activeColor: Color.fromARGB(255, 152, 216, 246),
                        activeTrackColor: Color.fromARGB(255, 54, 159, 208),
                        inactiveThumbColor: Color.fromARGB(255, 152, 216, 246),
                        inactiveTrackColor: Colors.grey[700],
                        padding: EdgeInsets.zero,
                      ),
                    ]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
