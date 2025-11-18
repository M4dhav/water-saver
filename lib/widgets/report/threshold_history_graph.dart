import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:water_saver/controllers/graph_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:water_saver/models/graph_page_model.dart';

class ThresholdHistoryGraph extends StatelessWidget {
  final GraphController controller;
  final GraphPageModel pageData;

  const ThresholdHistoryGraph({
    super.key,
    required this.controller,
    required this.pageData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Threshold History',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          _buildFlLineChart(),
          SizedBox(height: 2.h),
          _buildLegend(),
        ],
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
        backgroundColor: Colors.grey.shade50,
        minX: 0,
        maxX: _getMaxX(),
        maxY: 100,
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
    int dayIndex = (x.toInt() - 1).clamp(0, 6);
    return days[dayIndex];
  }

  FlTitlesData get motorTitlesData => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: thresholdBottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: thresholdLeftTitles,
        ),
      );

  SideTitles get thresholdLeftTitles => SideTitles(
        getTitlesWidget: (double value, TitleMeta meta) {
          const style = TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontSize: 12,
          );
          String text;
          if (value % 2 == 0) {
            text = '${value.toInt()}';
          } else {
            return Container();
          }
          return Text(text, style: style, textAlign: TextAlign.center);
        },
        showTitles: true,
        interval: 10,
        reservedSize: 45,
      );

  SideTitles get thresholdBottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: _getBottomTitleInterval(),
        getTitlesWidget: (double value, TitleMeta meta) {
          const style = TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
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
        show: true,
        verticalInterval: 1,
        horizontalInterval: 2,
        drawHorizontalLine: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            dashArray: [3, 3],
            color: Colors.grey.withValues(alpha: .4),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            dashArray: [3, 3],
            color: Colors.grey.withValues(alpha: .4),
            strokeWidth: 1,
          );
        },
      );

  FlBorderData get motorBorderData => FlBorderData(
        show: true,
        border: Border.all(color: Colors.grey.shade400, width: 2),
      );
  List<LineChartBarData> get motorLineBarsData => [
        LineChartBarData(
          isCurved: false,
          color: Colors.green,
          barWidth: 4,
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
          spots: controller.returnFlSpotFromRFTLowerThreshold(),
        ),
        LineChartBarData(
          isCurved: false,
          color: Colors.red,
          barWidth: 4,
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
          spots: controller.returnFlSpotFromRFTUpperThreshold(),
        ),
      ];
  double _getMaxX() {
    switch (pageData.selectedPeriod) {
      case SelectedPeriod.week:
        return 7;
      case SelectedPeriod.fifteenDays:
        return 15;
      case SelectedPeriod.month:
        return 30;
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

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLegendItem('Lower Threshold', Colors.green),
        SizedBox(width: 6.w),
        _buildLegendItem('Upper Threshold', Colors.red),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 4.w,
          height: 0.5.h,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: 2.w),
        Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
