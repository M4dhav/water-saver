import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:water_saver/controllers/graph_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:water_saver/models/app_themes.dart';
import 'package:water_saver/models/graph_page_model.dart';

class MotorStateGraph extends StatelessWidget {
  final GraphController controller;
  final GraphPageModel pageData;

  const MotorStateGraph({
    super.key,
    required this.controller,
    required this.pageData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).cardColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pump Activity',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textGradientColors.last,
              ),
            ),
            SizedBox(height: 2.h),
            _buildFlLineChart(),
          ],
        ),
      ),
    );
  }

  Widget _buildFlLineChart() {
    return SizedBox(
      height: 35.h,
      child: LineChart(
        motorStateLineChartData,
        duration: const Duration(milliseconds: 250),
      ),
    );
  }

  LineChartData get motorStateLineChartData => LineChartData(
        lineTouchData: motorLineTouchData,
        gridData: motorGridData,
        titlesData: motorTitlesData,
        borderData: motorBorderData,
        lineBarsData: motorLineBarsData,
        backgroundColor: Colors.transparent,
        minX: 0,
        maxX: _getMaxX(),
        maxY: 24,
        minY: 0,
      );

  LineTouchData get motorLineTouchData => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (touchedSpot) =>
              Colors.blueGrey.withValues(alpha: 0.8),
          getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
            return touchedBarSpots.map((barSpot) {
              final isMotorOn = barSpot.barIndex == 0;
              final status = isMotorOn ? 'Motor ON' : 'Motor OFF';

              return LineTooltipItem(
                '$status\n${barSpot.x}, ${barSpot.y}',
                const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              );
            }).toList();
          },
        ),
      );

  String _getDayLabel(double x) {
    // Get the last 7 days labels ending with today (e.g., ['Tue', 'Wed', ..., 'Mon'] if today is Mon)
    List<String> days = List.generate(7, (index) {
      final date = DateTime.now().subtract(Duration(days: 6 - index));
      // Use DateFormat if you want localized/short names, but for simplicity:
      const weekdayLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      // DateTime.weekday: 1=Mon, ..., 7=Sun
      return weekdayLabels[date.weekday - 1];
    });
    int dayIndex = (x.toInt()).clamp(0, 6);
    return days[dayIndex];
  }

  FlTitlesData get motorTitlesData => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: motorBottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: motorLeftTitles,
        ),
      );

  SideTitles get motorLeftTitles => SideTitles(
        getTitlesWidget: (double value, TitleMeta meta) {
          TextStyle style = TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textGradientColors.last,
            fontSize: 12,
          );
          String text = '${value.toInt().toString().padLeft(2, '0')}:00';
          return Text(
            text,
            style: style,
            textAlign: TextAlign.center,
          );
        },
        showTitles: true,
        interval: 6,
        reservedSize: 45,
      );

  SideTitles get motorBottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: _getBottomTitleInterval(),
        getTitlesWidget: (double value, TitleMeta meta) {
          TextStyle style = TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textGradientColors.last,
            fontSize: 12,
          );

          String text = _getBottomTitleText(value);
          return Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(text, style: style),
          );
        },
      );

  FlGridData get motorGridData => FlGridData(
        show: false,
      );

  FlBorderData get motorBorderData => FlBorderData(
        show: false,
      );
  List<LineChartBarData> get motorLineBarsData => [
        LineChartBarData(
          barWidth: 0,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, barData, index) {
              return FlDotCirclePainter(
                radius: 6,
                color: Colors.green,
                strokeWidth: 2,
                strokeColor: Colors.white,
              );
            },
          ),
          belowBarData: BarAreaData(show: false),
          spots: controller.returnFlSpotFromMotorStateDataOn(),
        ),
        LineChartBarData(
          barWidth: 0,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, barData, index) {
              return FlDotCirclePainter(
                radius: 6,
                color: Colors.red,
                strokeWidth: 2,
                strokeColor: Colors.white,
              );
            },
          ),
          belowBarData: BarAreaData(show: false),
          spots: controller.returnFlSpotFromMotorStateDataOff(),
        ),
      ];
  double _getMaxX() {
    switch (pageData.selectedPeriod) {
      case SelectedPeriod.week:
        return 6;
      case SelectedPeriod.fifteenDays:
        return 14;
      case SelectedPeriod.month:
        return 29;
    }
  }

  double _getBottomTitleInterval() {
    switch (pageData.selectedPeriod) {
      case SelectedPeriod.week:
        return 1;
      case SelectedPeriod.fifteenDays:
        return 3;
      case SelectedPeriod.month:
        return 5;
    }
  }

  String _getBottomTitleText(double value) {
    switch (pageData.selectedPeriod) {
      case SelectedPeriod.week:
        return _getDayLabel(value);
      case SelectedPeriod.fifteenDays:
        return '${value.toInt()}';
      case SelectedPeriod.month:
        return '${value.toInt()}';
    }
  }
}
