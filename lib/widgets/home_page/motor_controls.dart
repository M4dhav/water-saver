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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 2, 37, 133),
                  borderRadius: BorderRadius.circular(20),
                ),
                width: 41.w,
                child: Padding(
                  padding: EdgeInsets.all(1.w),
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
                            activeColor: const Color(0xFF98D8F6),
                            activeTrackColor:
                                const Color.fromARGB(255, 74, 165, 207),
                            inactiveThumbColor: const Color(0xFF98D8F6),
                            inactiveTrackColor: Colors.grey[700],
                          ),
                        ),
                      ]),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 2, 37, 133),
                  borderRadius: BorderRadius.circular(20),
                ),
                width: 40.w,
                child: Padding(
                  padding: EdgeInsets.all(1.w),
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
                          activeColor: const Color(0xFF98D8F6),
                          activeTrackColor: Color.fromARGB(255, 74, 165, 207),
                          inactiveThumbColor: const Color(0xFF98D8F6),
                          inactiveTrackColor: Colors.grey[700],
                          padding: EdgeInsets.zero,
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
