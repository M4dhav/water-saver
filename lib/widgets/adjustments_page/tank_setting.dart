import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:water_saver/providers/adjustment_controller_provider.dart';
import 'package:water_saver/widgets/adjustments_page/setup_slider.dart';

class TankSettingsWidget extends ConsumerWidget {
  final String title;
  final double motorOffValue;
  final double? motorOnValue;
  final bool? isError;
  final bool isReservoir;
  const TankSettingsWidget(
      {super.key,
      required this.title,
      required this.motorOffValue,
      this.motorOnValue,
      this.isError,
      this.isReservoir = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(adjustmentControllerProvider.notifier);
    final adjustmentsData = ref.watch(adjustmentControllerProvider);
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Level Threshold: Motor Off (${((isReservoir ? adjustmentsData.motorOffThresholdReservoir : adjustmentsData.motorOffThresholdTank - 0.1) * 75 / 1.13 + 35).toStringAsFixed(0)}%)",
                style: TextStyle(fontSize: 14.sp, color: Colors.blue),
              ),
              SizedBox(height: 1.h),
              GestureDetector(
                onHorizontalDragUpdate: (details) {
                  double newProgress =
                      (details.localPosition.dx / (80.w)).clamp(0.0, 1.0);
                  isReservoir
                      ? controller.updateMotorOffThresholdReservoir(
                          newProgress < 0.1 ? 0.1 : newProgress)
                      : controller.updateMotorOffThresholdTank(
                          newProgress < 0.1 ? 0.1 : newProgress);
                },
                child: CustomPaint(
                  size: Size(80.w, 3.h),
                  painter: CustomSliderPainter(
                      progress: isReservoir
                          ? adjustmentsData.motorOffThresholdReservoir
                          : adjustmentsData.motorOffThresholdTank),
                ),
              ),
            ],
          ),
          if (motorOnValue != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Level Threshold: Motor On (${((isReservoir ? adjustmentsData.motorOnThresholdReservoir : adjustmentsData.motorOnThresholdTank - 0.1) * 75 / 1.13 + 35).toStringAsFixed(0)}%)",
                  style: TextStyle(fontSize: 14.sp, color: Colors.blue),
                ),
                SizedBox(height: 1.h),
                GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    double newProgress =
                        (details.localPosition.dx / (80.w)).clamp(0.0, 1.0);
                    isReservoir
                        ? controller.updateMotorOnThresholdReservoir(
                            newProgress < 0.1 ? 0.1 : newProgress)
                        : controller.updateMotorOnThresholdTank(
                            newProgress < 0.1 ? 0.1 : newProgress);
                  },
                  child: CustomPaint(
                    size: Size(80.w, 3.h),
                    painter: CustomSliderPainter(
                        progress: isReservoir
                            ? adjustmentsData.motorOnThresholdReservoir
                            : adjustmentsData.motorOnThresholdTank),
                  ),
                ),
              ],
            ),
          if (isError != null)
            isError!
                ? Padding(
                    padding: EdgeInsets.only(top: 1.h),
                    child: Text(
                      "Level threshold Motor off > Level threshold Motor on",
                      style: TextStyle(color: Colors.red, fontSize: 14.sp),
                    ),
                  )
                : SizedBox.shrink(),
        ],
      ),
    );
  }
}
