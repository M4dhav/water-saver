import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:water_saver/providers/adjustment_controller_provider.dart';
import 'package:water_saver/widgets/adjustments_page/auto_data.dart';
import 'package:water_saver/widgets/adjustments_page/tank_setting.dart';

class AdjustmentsPage extends ConsumerWidget {
  const AdjustmentsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(adjustmentControllerProvider.notifier);
    final adjustmentsData = ref.watch(adjustmentControllerProvider);
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
              motorOffValue: adjustmentsData.motorOffThresholdTank,
              motorOnValue: adjustmentsData.motorOnThresholdTank,
              isError: adjustmentsData.isThresholdError,
              isReservoir: false,
            ),
            adjustmentsData.isReservoirMotorOnRequired
                ? TankSettingsWidget(
                    title: "Reservoir",
                    motorOffValue: adjustmentsData.motorOffThresholdReservoir,
                    motorOnValue: adjustmentsData.motorOnThresholdReservoir,
                    isReservoir: true,
                  )
                : TankSettingsWidget(
                    title: "Reservoir",
                    motorOffValue: adjustmentsData.motorOffThresholdReservoir,
                    motorOnValue: null,
                    isReservoir: true,
                  ),
            AutoDataLogWidget(),
            SizedBox(height: 3.h),
            ElevatedButton(
              onPressed: () {
                if (!controller.validateThresholds()) {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    isDismissible: false,
                    builder: (BuildContext context) {
                      Future.delayed(const Duration(seconds: 3), () {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      });
                      return Container(
                        margin: EdgeInsets.all(4.h),
                        padding: EdgeInsets.symmetric(
                            vertical: 5.h, horizontal: 9.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.error,
                                    color: Colors.red, size: 18.sp),
                                SizedBox(width: 2.h),
                                Text(
                                  "Saving Unsuccessful!",
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "OK",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                  return;
                }
                controller.saveAdjustments();
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  isDismissible: false,
                  builder: (BuildContext context) {
                    Future.delayed(const Duration(seconds: 3), () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    });
                    return Container(
                      margin: EdgeInsets.all(4.h),
                      padding:
                          EdgeInsets.symmetric(vertical: 5.h, horizontal: 9.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.check_circle,
                                  color: Colors.blue, size: 18.sp),
                              SizedBox(width: 2.h),
                              Text(
                                "Saved Successfully!",
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "OK",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: Size(80.w, 6.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              child: Text(
                "Save",
                style: TextStyle(fontSize: 16.sp, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
