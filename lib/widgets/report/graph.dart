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
        child: CircularProgressIndicator(),
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
        maxX: 7,
        maxY: 23,
        minY: 0,
      );

  LineTouchData get motorLineTouchData => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (touchedSpot) =>
              Colors.blueGrey.withValues(alpha: 0.8),
          getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
            return touchedBarSpots.map((barSpot) {
              final day = _getDayLabel(barSpot.x);
              final hour = barSpot.y.floor();
              final minutes = ((barSpot.y - hour) * 60).round();
              final time =
                  '${hour.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
              final isMotorOn = barSpot.barIndex == 0;
              final status = isMotorOn ? 'Motor ON' : 'Motor OFF';
              return LineTooltipItem(
                '$status\n$day at $time',
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
        interval: 1,
        getTitlesWidget: (double value, TitleMeta meta) {
          const style = TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontSize: 12,
          );

          String text = _getDayLabel(value);
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
          spots: _getMotorOnSpots(),
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
          spots: _getMotorOffSpots(),
        ),
      ];
  List<FlSpot> _getMotorOnSpots() {
    return [
      FlSpot(1, 13),
      FlSpot(2, 14),
      FlSpot(3, 12),
      FlSpot(4, 15),
      FlSpot(5, 13),
      FlSpot(6, 11),
      FlSpot(7, 16),
    ];
  }

  List<FlSpot> _getMotorOffSpots() {
    return [
      FlSpot(1, 13.5),
      FlSpot(2, 14.5),
      FlSpot(3, 12.75),
      FlSpot(4, 15.25),
      FlSpot(5, 13.55),
      FlSpot(6, 11.5),
      FlSpot(7, 16.55),
    ];
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
