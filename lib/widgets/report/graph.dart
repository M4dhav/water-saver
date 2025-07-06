import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:water_saver/controllers/graph_controller.dart';
import 'package:fl_chart/fl_chart.dart';

class MotorStateGraph extends StatelessWidget {
  final GraphController controller;

  const MotorStateGraph({
    super.key,
    required this.controller,
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
                'Motor Activity',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              _buildPeriodDropdown(),
            ],
          ),
          SizedBox(height: 2.h),
          if (controller.isLoading)
            _buildLoadingIndicator()
          else
            _buildFlLineChart(),
          SizedBox(height: 2.h),
          _buildLegend(),
        ],
      ),
    );
  }

  Widget _buildPeriodDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: controller.selectedPeriod,
          dropdownColor: Colors.white,
          items: controller.availablePeriods.map((String period) {
            return DropdownMenuItem<String>(
              value: period,
              child: Text(
                period,
                style: TextStyle(fontSize: 14.sp),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              controller.changePeriod(newValue);
            }
          },
          icon: Icon(Icons.keyboard_arrow_down, size: 5.w),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return SizedBox(
      height: 35.h,
      child: const Center(
        child: CircularProgressIndicator(
          strokeWidth: 6.0,
          color: Colors.blue,
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
        backgroundColor: Colors.grey.shade50,
        minX: 1,
        maxX: _getMaxX(),
        maxY: _getMaxY(),
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
              String timeInfo =
                  controller.getTooltipTimeInfo(barSpot.x, barSpot.y);
              return LineTooltipItem(
                '$status\n$timeInfo',
                const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              );
            }).toList();
          },
        ),
      );

  String _getDayLabel(double x) {
    List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    int dayIndex = (x.toInt() - 1).clamp(0, 6);
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
          const style = TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontSize: 12,
          );
          String text;
          if (value % 2 == 0) {
            text = '${value.toInt().toString().padLeft(2, '0')}:00';
          } else {
            return Container();
          }
          return Text(text, style: style, textAlign: TextAlign.center);
        },
        showTitles: true,
        interval: 2,
        reservedSize: 45,
      );

  SideTitles get motorBottomTitles => SideTitles(
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
        verticalInterval: _getVerticalGridInterval(),
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
          spots: controller.getMotorOnSpots(),
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
          spots: controller.getMotorOffSpots(),
        ),
      ];
  double _getMaxX() {
    switch (controller.selectedPeriod) {
      case 'Today':
        return 6;
      case 'Week':
        return 7;
      case '15days':
        return 15;
      case 'This Month':
        return 30;
      default:
        return 7;
    }
  }

  double _getMaxY() {
    switch (controller.selectedPeriod) {
      case 'Today':
        return 23;
      case 'Week':
        return 23;
      case '15days':
        return 23;
      case 'This Month':
        return 23;
      default:
        return 23;
    }
  }

  double _getBottomTitleInterval() {
    switch (controller.selectedPeriod) {
      case 'Today':
        return 1;
      case 'Week':
        return 1;
      case '15days':
        return 3;
      case 'This Month':
        return 5;
      default:
        return 1;
    }
  }

  String _getBottomTitleText(double value) {
    switch (controller.selectedPeriod) {
      case 'Today':
        List<String> times = ['8AM', '10AM', '1PM', '3PM', '6PM', '8PM'];
        int index = (value.toInt() - 1).clamp(0, times.length - 1);
        return times[index];
      case 'Week':
        return _getDayLabel(value);
      case '15days':
        return 'Day ${value.toInt()}';
      case 'This Month':
        return '${value.toInt()}';
      default:
        return _getDayLabel(value);
    }
  }

  double _getVerticalGridInterval() {
    switch (controller.selectedPeriod) {
      case 'Today':
        return 1;
      case 'Week':
        return 1;
      case '15days':
        return 3;
      case 'This Month':
        return 5;
      default:
        return 1;
    }
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLegendItem('Motor ON', Colors.green),
        SizedBox(width: 6.w),
        _buildLegendItem('Motor OFF', Colors.red),
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
