import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';
import 'package:water_saver/widgets/adjustments_page/setup_slider.dart';

class CustomSliderWidget extends StatelessWidget {
  final String label;
  final RxDouble value;

  const CustomSliderWidget(
      {super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() => Text(
              "$label (${((value.value - 0.1) * 75 / 1.13 + 35).toStringAsFixed(0)}%)", 
              style: TextStyle(fontSize: 14.sp, color: Colors.blue),
            )),
        SizedBox(height: 1.h),
        GestureDetector(
          onHorizontalDragUpdate: (details) {
            double newProgress =
                (details.localPosition.dx / (80.w)).clamp(0.0, 1.0);
            value.value =
                newProgress < 0.1 ? 0.1 : newProgress; 
          },
          child: Obx(() => CustomPaint(
                size: Size(80.w, 3.h),
                painter: CustomSliderPainter(progress: value.value),
              )),
        ),
      ],
    );
  }
}
