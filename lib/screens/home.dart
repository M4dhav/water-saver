import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:water_saver/controllers/app_user_controller.dart';
import 'package:water_saver/controllers/home_history_controller.dart';
import 'package:water_saver/models/app_user.dart';
import 'package:water_saver/providers/app_user_controller_provider.dart';
import 'package:water_saver/widgets/home_page/arc.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  Timer? _timer;

  int _currentIndex = 0;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startDataAnimation(List<int> rftData, List<int> rsvData) {
    _timer?.cancel();

    _currentIndex = 0;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_currentIndex >= rftData.length - 1) {
// Reset to start or stop

        _currentIndex = 0; // Loop back to start

        timer.cancel(); // Uncomment to stop after one cycle
      } else {
        _currentIndex++;
      }

      if (mounted) {
        setState(() {}); // Trigger rebuild with new index
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final appUserController = ref.watch(appUserControllerProvider.notifier);

    final appUser = ref.watch(appUserControllerProvider);

    return appUser.when(
        data: (appUser) => buildHomeBody(appUser, appUserController),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
        loading: () => Center(child: CircularProgressIndicator()));
  }

  Widget buildHomeBody(AppUser appUser, AppUserController appUserController) {
    final historyController = HomeHistoryController();

    final bool hasReservoir = true;
    final int reservoir = int.parse(appUser.userDataReceive.rsvHeight);
    final int tank = int.parse(appUser.userDataReceive.rftHeight);
    final List<int> rftData = appUser.userDataUpload.rftLevelData;

    final List<int> rsvData = appUser.userDataUpload.rsvLevelData;

    if (_timer == null || !_timer!.isActive) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _startDataAnimation(rftData, rsvData);
      });
    }

    final int currentTankLevel = rftData.isNotEmpty
        ? rftData[_currentIndex.clamp(0, rftData.length - 1)]
        : 0;

    final int currentReservoirLevel = rsvData.isNotEmpty
        ? rsvData[_currentIndex.clamp(0, rsvData.length - 1)]
        : 0;

    double arcProgress =
        (tank > 0) ? (currentTankLevel / tank).clamp(0.0, 1.0) : 0.0;
    double dropProgress = (reservoir > 0)
        ? (currentReservoirLevel / reservoir).clamp(0.0, 1.0)
        : 0.0;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Padding(
        padding: EdgeInsets.only(left: 4.5.w, top: 2.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Builder(
                builder: (context) {
                  final isLandscape = MediaQuery.of(context).orientation ==
                      Orientation.landscape;
                  final double arcHeight = isLandscape ? 70.h : 30.h;
                  final double arcWidth = isLandscape ? 85.w : 75.w;
                  final double dropWidth = isLandscape ? 18.w : 36.w;
                  final double dropHeight = isLandscape ? 50.h : 20.h;
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: 90.w,
                    child: Padding(
                      padding: EdgeInsets.only(top: 1.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              CustomPaint(
                                size: Size(arcHeight, arcWidth),
                                painter: WaterLevelArcPainter(
                                  progress: arcProgress,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(
                                width: dropWidth,
                                height: dropHeight,
                                child: Stack(
                                  fit: StackFit.expand,
                                  alignment: Alignment.center,
                                  children: [
                                    if ((hasReservoir && reservoir > 0) ||
                                        (!hasReservoir))
                                      Center(
                                        child: Text(
                                          '${(dropProgress * 100).toInt()}%',
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            shadows: [
                                              Shadow(
                                                blurRadius: 4,
                                                color: Colors.black26,
                                                offset: Offset(1, 1),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          if (isLandscape) SizedBox(height: 0.05.h),
                          Text(
                            '${(arcProgress * 100).toInt()}%',
                            style: TextStyle(
                                fontSize: 26.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                          Text(
                            '${currentTankLevel / 10} cm / ${tank / 10} cm',
                            style:
                                TextStyle(fontSize: 16.sp, color: Colors.grey),
                          ),
                          SizedBox(height: 3.h),
                          Padding(
                            padding: EdgeInsets.only(left: 6.w, bottom: 1.1.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 4.w, vertical: 1.h),
                                  decoration: BoxDecoration(
                                    color: appUser.userDataUpload.motorOn ==
                                            "yes"
                                        ? Colors.blue.withValues(alpha: 0.1)
                                        : Colors.grey.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                      color: appUser.userDataUpload.motorOn ==
                                              "yes"
                                          ? Colors.blue
                                          : Colors.grey,
                                      width: 2,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Motor: ${appUser.userDataUpload.motorOn == "yes" ? 'ON' : 'OFF'}',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color:
                                              appUser.userDataUpload.motorOn ==
                                                      "yes"
                                                  ? Colors.blue
                                                  : Colors.grey[700],
                                        ),
                                      ),
                                      SizedBox(width: 3.w),
                                      Switch(
                                        value: appUser.userDataUpload.motorOn ==
                                            "yes",
                                        onChanged: (bool value) async {
                                          appUserController
                                              .updateMotorState(value);
                                        },
                                        activeColor: Colors.blue,
                                        activeTrackColor:
                                            Colors.blue.withValues(alpha: 0.3),
                                        inactiveThumbColor: Colors.grey,
                                        inactiveTrackColor:
                                            Colors.grey.withValues(alpha: 0.3),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 4.w),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 2.h),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: EdgeInsets.only(right: 4.5.w, top: 1.h),
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "History",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            "View All →",
                            style:
                                TextStyle(fontSize: 16.sp, color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    Divider(
                        height: 1, thickness: 1, color: Colors.grey.shade300),
                    ListView.separated(
                      itemCount: historyController.waterHistory.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) => Divider(
                        height: 1,
                        thickness: 1,
                        color: Colors.grey.shade300,
                      ),
                      itemBuilder: (context, index) {
                        final record = historyController.waterHistory[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/tank.png',
                                width: 8.w,
                                height: 8.w,
                              ),
                              SizedBox(width: 3.w),
                              Expanded(
                                child: Text(
                                  record["time"]!,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                record["quantity"]!,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(width: 2.w),
                              const Icon(Icons.more_vert, color: Colors.black)
                            ],
                          ),
                        );
                      },
                    ),
                    Divider(
                        height: 1, thickness: 1, color: Colors.grey.shade300),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
