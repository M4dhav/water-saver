import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:water_saver/widgets/home_page/water_tank_shape.dart';

class WaterTankWidget extends StatelessWidget {
  final double fillPercentage;
  final double waterLevel;
  final double tankHeight;
  final int volume;

  const WaterTankWidget({
    super.key,
    required this.fillPercentage,
    required this.waterLevel,
    required this.tankHeight,
    required this.volume,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 4.w, left: 4.w),
      child: Column(
        children: [
          Column(
            children: [
              Text(
                '$volume L',
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'volume',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: const Color(0xFFE2E8F0),
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${waterLevel.toStringAsFixed(1)} m',
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'from the bottom',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xFFE2E8F0),
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      '${fillPercentage.toInt()} %',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'filled',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xFFE2E8F0),
                      ),
                    ),
                  ],
                ),
              ),
              LiquidCustomProgressIndicator(
                direction: Axis.vertical,
                value: fillPercentage / 100,
                valueColor: const AlwaysStoppedAnimation<Color>(
                    Color.fromARGB(255, 4, 167, 242)),
                backgroundColor: const Color(0xFF98D8F6),
                shapePath: buildWaterTankPath(size: Size(44.w, 27.h)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
