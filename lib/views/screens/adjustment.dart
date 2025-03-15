import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';
import 'package:water_saver/controller/adjustment_controller.dart';
import 'package:water_saver/widgets/adjustments_page/auto_data.dart';
import 'package:water_saver/widgets/adjustments_page/tank_setting.dart';

class AdjustmentsPage extends StatelessWidget {
  final AdjustmentsController controller = Get.put(AdjustmentsController());

   AdjustmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.opacity, color: Colors.blue),
          onPressed: () {},
        ),
        title: Padding(
          padding: EdgeInsets.only(top: 2.h),
          child: Text(
            'Setup',
            style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(1.5.h),
              child: Text(
                "Kindly fill the required details below",
                style: TextStyle(fontSize: 18.sp, color: Colors.grey),
              ),
            ),
            SizedBox(height: 2.h),
            TankSettingsWidget(
                title: "Roof Top Tank",
                motorOffValue: controller.motorOffThresholdTank,
                motorOnValue: controller.motorOnThresholdTank),
            TankSettingsWidget(
                title: "Reservoir",
                motorOffValue: controller.motorOffThresholdReservoir,
                motorOnValue: controller.motorOnThresholdReservoir),
            AutoDataLogWidget(controller: controller),
            SizedBox(height: 3.h),
            ElevatedButton(
              onPressed: () {
                controller.saveAdjustments();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: Size(80.w, 6.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              child: Text(
                "Continue",
                style: TextStyle(fontSize: 16.sp, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
