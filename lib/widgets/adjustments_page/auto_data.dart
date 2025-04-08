import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';
import 'package:water_saver/controllers/adjustment_controller.dart';
import 'package:water_saver/widgets/adjustments_page/toggle_widget.dart';

class AutoDataLogWidget extends StatelessWidget {
  final AdjustmentsController controller;

  const AutoDataLogWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(3.w),
            margin: EdgeInsets.only(right: 2.w),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Auto Data Log",
                    style: TextStyle(
                        fontSize: 16.sp, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    Obx(() => ToggleButtonWidget(
                        text: "Off",
                        isSelected: !controller.autoDataLog.value,
                        onTap: () {
                          controller.autoDataLog.value = false;
                        })),
                    Obx(() => ToggleButtonWidget(
                        text: "On",
                        isSelected: controller.autoDataLog.value,
                        onTap: () {
                          controller.autoDataLog.value = true;
                        })),
                  ],
                ),
              ],
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            controller.updateSettings();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            minimumSize: Size(20.w, 4.h),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          child: Text(
            "Update",
            style: TextStyle(fontSize: 16.sp, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
