import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GraphPage extends StatefulWidget {
  const GraphPage({super.key});

  @override
  State<GraphPage> createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  final SharedPreferences prefs = Get.find();
  late String? deviceId = prefs.getString('device_id');
  User? user = FirebaseAuth.instance.currentUser;
  Map<String, dynamic> userData = {};
  List<Map<String, dynamic>> motorData = [];
  List<Map<String, dynamic>> filteredData = [];
  List<FlSpot> trueSpots = [];
  List<FlSpot> falseSpots = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(deviceId)
          .get();
      setState(() {
        userData = doc.data() as Map<String, dynamic>;
      });

      QuerySnapshot query = await FirebaseFirestore.instance
          .collection('users')
          .doc(deviceId)
          .collection('motorData')
          .get();

      setState(() {
        for (var doc in query.docs) {
          motorData.add(doc.data() as Map<String, dynamic>);
        }
      });
      filter7Days();
      getSpots();
    });
  }

  void filter7Days() {
    for (var element in motorData) {
      DateTime date =
          DateTime.fromMillisecondsSinceEpoch(element['time'].toInt());
      if (DateTime.now().difference(date).inDays <= 7) {
        filteredData.add(element);
      }
    }

    setState(() {
      filteredData = filteredData;
    });
    log(filteredData.toString());
  }

  void getSpots() {
    for (var element in filteredData) {
      DateTime date =
          DateTime.fromMillisecondsSinceEpoch(element['time'].toInt());
      if (element['motorState'] == true) {
        trueSpots.add(FlSpot(date.weekday.toDouble(), date.hour.toDouble()));
      } else {
        falseSpots
            .add(FlSpot(date.weekday.toDouble(), date.hour.toDouble() - 1));
      }
    }
    setState(() {
      trueSpots = trueSpots;
      falseSpots = falseSpots;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff081c5c),
      appBar: AppBar(
        backgroundColor: const Color(0xff081c5c),
        title: const Text('Data'),
        foregroundColor: Colors.white,
      ),
      body: falseSpots.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: SizedBox(
                      height: 45.h,
                      width: 90.w,
                      child: LineChart(
                        sampleData1,
                        duration: const Duration(milliseconds: 250),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 7.h,
                        width: 70.w,
                        child: LiquidLinearProgressIndicator(
                          value: userData['rooftop'] / 4095,
                          // Defaults to 0.5.
                          valueColor: AlwaysStoppedAnimation(userData[
                                          'rooftop'] /
                                      4095 <
                                  0.1
                              ? Colors.pink
                              : userData['rooftop'] / 4095 > 0.6
                                  ? Colors.green
                                  : Colors
                                      .yellow), // Defaults to the current Theme's accentColor.
                          backgroundColor: Colors
                              .white, // Defaults to the current Theme's backgroundColor.
                          borderColor: Colors.red,
                          borderWidth: 5.0,
                          borderRadius: 12.0,
                          direction: Axis
                              .horizontal, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.horizontal.
                        ),
                      ),
                      Text(
                        'Roof Top\n${((userData['rooftop'] / 4095) * 100).toStringAsFixed(0)}%',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 7.h,
                        width: 70.w,
                        child: LiquidLinearProgressIndicator(
                          value:
                              userData['reservoir'] / 4095, // Defaults to 0.5.
                          valueColor: const AlwaysStoppedAnimation(Colors
                              .pink), // Defaults to the current Theme's accentColor.
                          backgroundColor: Colors
                              .white, // Defaults to the current Theme's backgroundColor.
                          borderColor: Colors.red,
                          borderWidth: 5.0,
                          borderRadius: 12.0,
                          direction: Axis
                              .horizontal, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.horizontal.
                        ),
                      ),
                      Text(
                        'Reservoir\n${((userData['reservoir'] / 4095) * 100).toStringAsFixed(0)}%',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  LineChartData get sampleData1 => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        backgroundColor: const Color(0xff083464),
        minX: 0,
        maxX: 8,
        maxY: 25,
        minY: 0,
      );
  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (touchedSpot) => Colors.blueGrey.withOpacity(0.8),
        ),
      );
  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );
  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
        lineChartBarData1_2,
      ];
  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '00:00';
        break;
      case 2:
        text = '01:00';
        break;
      case 3:
        text = '02:00';
        break;
      case 4:
        text = '03:00';
        break;
      case 5:
        text = '04:00';
        break;
      case 6:
        text = '05:00';
        break;
      case 7:
        text = '06:00';
        break;
      case 8:
        text = '07:00';
        break;
      case 9:
        text = '08:00';
        break;
      case 10:
        text = '09:00';
        break;
      case 11:
        text = '10:00';
        break;
      case 12:
        text = '11:00';
        break;
      case 13:
        text = '12:00';
        break;
      case 14:
        text = '13:00';
        break;
      case 15:
        text = '14:00';
        break;
      case 16:
        text = '15:00';
        break;
      case 17:
        text = '16:00';
        break;
      case 18:
        text = '17:00';
        break;
      case 19:
        text = '18:00';
        break;
      case 20:
        text = '19:00';
        break;
      case 21:
        text = '20:00';
        break;
      case 22:
        text = '21:00';
        break;
      case 23:
        text = '22:00';
        break;
      case 24:
        text = '23:00';
        break;
      default:
        return Container();
    }
    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 3,
        reservedSize: 40,
      );
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    String text;
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 14,
    );
    switch (value.toInt()) {
      case 1:
        text = 'Mon';
        break;
      case 2:
        text = 'Tue';
        break;
      case 3:
        text = 'Wed';
        break;
      case 4:
        text = 'Thu';
        break;
      case 5:
        text = 'Fri';
        break;
      case 6:
        text = 'Sat';
        break;
      case 7:
        text = 'Sun';
        break;
      default:
        text = '';
        break;
    }
    return Text(text, style: style).paddingOnly(
      top: meta.axisSide == AxisSide.bottom ? 10 : 0,
      bottom: meta.axisSide == AxisSide.top ? 10 : 0,
      left: meta.axisSide == AxisSide.right ? 10 : 0,
      right: meta.axisSide == AxisSide.left ? 10 : 0,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => FlGridData(
        show: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        drawHorizontalLine: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            dashArray: [3, 3],
            color: Colors.grey.withOpacity(0.5),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            dashArray: [3, 3],
            color: Colors.grey.withOpacity(0.5),
            strokeWidth: 1,
          );
        },
      );

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Color(0xff0daa96), width: 4),
          left: BorderSide(color: Color(0xff0daa96), width: 4),
          right: BorderSide(color: Color(0xff0daa96), width: 4),
          top: BorderSide(color: Color(0xff0daa96), width: 4),
        ),
      );

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
      isCurved: true,
      color: Colors.yellow,
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: true),
      belowBarData: BarAreaData(show: false),
      spots: trueSpots);

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
      isCurved: true,
      color: Colors.pink,
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: true),
      spots: falseSpots);
}
