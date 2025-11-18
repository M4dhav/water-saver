import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:water_saver/providers/app_user_controller_provider.dart';
import 'package:water_saver/widgets/adjustments_page/tank_setting.dart';

class AdjustmentsPage extends ConsumerWidget {
  const AdjustmentsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(appUserControllerProvider.notifier);
    final appUserData = ref.watch(appUserControllerProvider);

    return Scaffold(
      backgroundColor: Color(0xFF071526),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(1.5.h),
                child: Text(
                  "Kindly fill the required details below",
                  style: TextStyle(fontSize: 18.sp, color: Colors.white70),
                ),
              ),
              SizedBox(height: 2.h),
              TankSettingsWidget(
                title: "Roof Top Tank",
                motorOffValue: double.parse(
                    appUserData.requireValue.userDataReceive.rftThUpPercent),
                motorOnValue: double.parse(
                    appUserData.requireValue.userDataReceive.rftThDnPercent),
                onMotorOffChanged: controller.updateMotorOffThresholdTank,
                onMotorOnChanged: controller.updateMotorOnThresholdTank,
              ),
              TankSettingsWidget(
                title: "Reservoir",
                motorOffValue: null,
                motorOnValue: double.parse(
                    appUserData.requireValue.userDataReceive.rsvThDnPercent),
                onMotorOnChanged: controller.updateMotorOnThresholdReservoir,
                onMotorOffChanged: null,
              ),
              SizedBox(height: 3.h),
              ElevatedButton(
                onPressed: () async {
                  if (!controller.validateThresholds()) {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (BuildContext context) {
                        return Container(
                          margin: EdgeInsets.all(2.h),
                          padding: EdgeInsets.symmetric(
                              vertical: 3.h, horizontal: 4.w),
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
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Icon(Icons.error,
                                            color: Colors.red, size: 18.sp),
                                        SizedBox(width: 2.w),
                                        Flexible(
                                          child: Text(
                                            "Saving Unsuccessful!",
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
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
                            ],
                          ),
                        );
                      },
                    );
                    return;
                  }
                  await controller.saveAdjustments();
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (BuildContext context) {
                      return Container(
                        margin: EdgeInsets.all(2.h),
                        padding: EdgeInsets.symmetric(
                            vertical: 3.h, horizontal: 4.w),
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
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Icon(Icons.check_circle,
                                          color: Colors.blue, size: 18.sp),
                                      SizedBox(width: 2.w),
                                      Flexible(
                                        child: Text(
                                          "Saved Successfully!",
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
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
      ),
    );
  }
}
