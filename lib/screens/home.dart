import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:water_saver/controllers/app_user_controller.dart';
import 'package:water_saver/models/app_user.dart';
import 'package:water_saver/providers/app_user_controller_provider.dart';
import 'package:water_saver/widgets/home_page/tank_widget.dart';
import 'package:water_saver/widgets/home_page/motor_controls.dart';
import 'package:water_saver/widgets/home_page/insights.dart';

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
        error: (error, stackTrace) => Scaffold(
              backgroundColor: const Color(0xFF071526),
              body: Center(
                child: Text(
                  'Error: $error',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
        loading: () => Scaffold(
              backgroundColor: const Color(0xFF071526),
              body: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ));
  }

  Widget buildHomeBody(AppUser appUser, AppUserController appUserController) {
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
    double fillPercentage =
        (tank > 0) ? ((currentTankLevel / tank) * 100).clamp(0.0, 100.0) : 0.0;
    double waterLevel = currentTankLevel / 100.0;
    int volume = ((currentTankLevel / tank) * 492).round();
    int buckets = (volume / 2).floor();
    int washingMachines = (volume / 20).floor();

    return Scaffold(
      backgroundColor: const Color(0xFF071526),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: const Color(0xFF071526),
                borderRadius: BorderRadius.circular(20),
              ),
              child: WaterTankWidget(
                fillPercentage: fillPercentage,
                waterLevel: waterLevel,
                tankHeight: tank / 100.0,
                volume: volume,
              ),
            ),
            MotorControlsWidget(
              isMotorOn: appUser.userDataUpload.motorOn == "yes",
              isAutoMode: true,
              onMotorToggle: () {
                appUserController.updateMotorState(
                    !(appUser.userDataUpload.motorOn == "yes"));
              },
              onAutoToggle: () {
                // auto mode toggle
              },
              onMotorButtonPressed: () {
                appUserController.updateMotorState(
                    !(appUser.userDataUpload.motorOn == "yes"));
              },
            ),
            SizedBox(height: 2.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
              decoration: const BoxDecoration(
                color: Color(0xFF1E3A8A),
              ),
              child: Text(
                'Insights',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 2.h),
            UsageStatsWidget(
              buckets: buckets,
              washingMachines: washingMachines,
            ),
          ],
        ),
      ),
    );
  }
}
