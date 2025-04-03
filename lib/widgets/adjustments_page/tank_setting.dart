import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';
import 'package:water_saver/widgets/adjustments_page/custom_slider.dart';

class TankSettingsWidget extends StatelessWidget {
  final String title;
  final RxDouble motorOffValue;
  final RxDouble? motorOnValue;
  final RxBool? isError; 

  const TankSettingsWidget({
    super.key,
    required this.title,
    required this.motorOffValue,
    this.motorOnValue,
    this.isError, 
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
          Text(title,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
          SizedBox(height: 1.h),
          CustomSliderWidget(
              label: "Level Threshold: Motor Off", value: motorOffValue),
          if (motorOnValue != null)
            CustomSliderWidget(
                label: "Level Threshold: Motor On", value: motorOnValue!),
          if (isError != null)
            Obx(() => isError!.value
                ? Padding(
                    padding: EdgeInsets.only(top: 1.h),
                    child: Text(
                      "Level threshold Motor off > Level threshold Motor on",
                      style: TextStyle(color: Colors.red, fontSize: 14.sp),
                    ),
                  )
                : SizedBox.shrink()),
        ],
      ),
    );
  }
}
