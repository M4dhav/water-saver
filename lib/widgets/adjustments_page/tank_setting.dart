import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TankSettingsWidget extends ConsumerWidget {
  final String title;
  final double? motorOffValue;
  final double motorOnValue;
  final void Function(double)? onMotorOffChanged;
  final void Function(double) onMotorOnChanged;

  const TankSettingsWidget({
    super.key,
    required this.title,
    this.motorOffValue,
    required this.motorOnValue,
    this.onMotorOffChanged,
    required this.onMotorOnChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliderTheme(
      data: SliderThemeData(
          trackHeight: 20,
          padding: EdgeInsets.all(10),
          activeTrackColor: Colors.blue,
          inactiveTrackColor: Colors.grey.shade300,
          thumbShape: SliderComponentShape.noOverlay,
          valueIndicatorColor: Colors.blue,
          overlayShape: SliderComponentShape.noOverlay),
      child: Container(
        width: 100.w,
        padding: EdgeInsets.all(3.w),
        margin: EdgeInsets.only(bottom: 3.h),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 1.h),
            if (motorOffValue != null && onMotorOffChanged != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Level Threshold: Motor Off",
                    style: TextStyle(fontSize: 14.sp, color: Colors.blue),
                  ),
                  SizedBox(height: 1.h),
                  Slider(
                      value: motorOffValue ?? 0,
                      label: motorOffValue?.toStringAsFixed(0) ?? "0",
                      min: 0.0,
                      max: 100.0,
                      divisions: 100,
                      onChanged: (value) =>
                          onMotorOffChanged!(value < 2 ? 2 : value)),
                ],
              ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Level Threshold: Motor On ",
                  style: TextStyle(fontSize: 14.sp, color: Colors.blue),
                ),
                SizedBox(height: 1.h),
                Slider(
                    value: motorOnValue,
                    label: motorOnValue.toStringAsFixed(0),
                    min: 0.0,
                    max: 100.0,
                    divisions: 100,
                    onChanged: (value) =>
                        onMotorOnChanged(value < 1 ? 1 : value))
              ],
            ),
            if ((motorOffValue ?? 101) <= motorOnValue)
              Padding(
                padding: EdgeInsets.only(top: 1.h),
                child: Text(
                  "Motor off threshold must be greater than Motor on threshold",
                  style: TextStyle(color: Colors.red, fontSize: 14.sp),
                ),
              )
          ],
        ),
      ),
    );
  }
}
