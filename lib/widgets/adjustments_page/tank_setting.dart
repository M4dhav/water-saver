import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';
import 'package:water_saver/widgets/adjustments_page/custom_slider.dart';

class TankSettingsWidget extends StatelessWidget {
  final String title;
  final RxDouble motorOffValue;
  final RxDouble motorOnValue;

  const TankSettingsWidget({super.key, 
    required this.title,
    required this.motorOffValue,
    required this.motorOnValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Text(title, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
          SizedBox(height: 1.h),
          CustomSliderWidget(label: "Level Threshold: Motor Off", value: motorOffValue),
          CustomSliderWidget(label: "Level Threshold: Motor On", value: motorOnValue),
        ],
      ),
    );
  }
}
