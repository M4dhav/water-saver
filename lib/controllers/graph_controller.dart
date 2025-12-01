import 'dart:developer';
import 'dart:math' hide log;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:water_saver/models/firebase_model.dart';
import 'package:water_saver/models/graph_page_model.dart';
import 'package:water_saver/models/level_data_history.dart';
import 'package:water_saver/models/motor_state_data.dart';
import 'package:water_saver/models/threshold_data_history.dart';

class GraphController extends AsyncNotifier<GraphPageModel> {
  @override
  Future<GraphPageModel> build() async {
    List<MotorStateData> motorStateData = await getMotorStateData();
    List<LevelDataHistory> rftLevelData = await getRftLevelData();
    List<LevelDataHistory> rsvLevelData = await getRsvLevelData();
    List<ThresholdDataHistory> thresholdHistoryData =
        await getThresholdHistoryData();

    return GraphPageModel(
        motorStateData: motorStateData,
        motorStateDataOff: filterMotorStateDataOff(motorStateData),
        motorStateDataOn: filterMotorStateDataOn(motorStateData),
        thresholdDataHistory: thresholdHistoryData,
        rftLevelData: rftLevelData,
        rsvLevelData: rsvLevelData);
  }

  List<MotorStateData> filterMotorStateDataOn(List<MotorStateData> allData) {
    return allData
        .where((data) => data.motorOn == "yes" && data.motorOff == "no")
        .toList();
  }

  List<MotorStateData> filterMotorStateDataOff(List<MotorStateData> allData) {
    return allData
        .where((data) => data.motorOn == "no" && data.motorOff == "yes")
        .toList();
  }

  Future<List<MotorStateData>> getMotorStateData() async {
    String deviceId =
        await GetIt.I<FlutterSecureStorage>().read(key: 'deviceId') ?? "";

    CollectionReference motorStateCollection =
        FBCollections.userDataUpload.doc(deviceId).collection('motorData');

    QuerySnapshot snapshot = await motorStateCollection.get();

    List<MotorStateData> motorStateData = [];

    for (var doc in snapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      motorStateData.add(MotorStateData.fromJson(data));
    }

    return motorStateData;
  }

  Future<List<LevelDataHistory>> getRftLevelData() async {
    String deviceId =
        await GetIt.I<FlutterSecureStorage>().read(key: 'deviceId') ?? "";

    CollectionReference rftLevelDataHistoryCollection =
        FBCollections.userDataUpload.doc(deviceId).collection('rftLevelData');

    QuerySnapshot snapshot = await rftLevelDataHistoryCollection.get();

    List<LevelDataHistory> rftLevelData = [];

    for (var doc in snapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      rftLevelData.add(LevelDataHistory.fromJson(data));
    }

    return rftLevelData;
  }

  Future<List<LevelDataHistory>> getRsvLevelData() async {
    String deviceId =
        await GetIt.I<FlutterSecureStorage>().read(key: 'deviceId') ?? "";

    CollectionReference rsvLevelDataHistoryCollection =
        FBCollections.userDataUpload.doc(deviceId).collection('rsvLevelData');

    QuerySnapshot snapshot = await rsvLevelDataHistoryCollection.get();

    List<LevelDataHistory> rsvLevelData = [];

    for (var doc in snapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      rsvLevelData.add(LevelDataHistory.fromJson(data));
    }

    return rsvLevelData;
  }

  Future<List<ThresholdDataHistory>> getThresholdHistoryData() async {
    String deviceId =
        await GetIt.I<FlutterSecureStorage>().read(key: 'deviceId') ?? "";

    CollectionReference thresholdHistoryDataCollection = FBCollections
        .userDataReceive
        .doc(deviceId)
        .collection('thresholdHistoryData');

    QuerySnapshot snapshot = await thresholdHistoryDataCollection.get();

    List<ThresholdDataHistory> thresholdHistoryData = [];

    for (var doc in snapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      thresholdHistoryData.add(ThresholdDataHistory.fromJson(data));
    }
    log(thresholdHistoryData.toString());

    return thresholdHistoryData;
  }

  List<FlSpot> returnFlSpotFromMotorStateDataOn() {
    List<MotorStateData> motorStateDataOn = state.requireValue.motorStateDataOn;
    switch (state.requireValue.selectedPeriod) {
      case (SelectedPeriod.week):
        motorStateDataOn = motorStateDataOn
            .where((data) =>
                data.time.isAfter(DateTime.now().subtract(Duration(days: 7))))
            .toList();
      case (SelectedPeriod.fifteenDays):
        motorStateDataOn = motorStateDataOn
            .where((data) =>
                data.time.isAfter(DateTime.now().subtract(Duration(days: 15))))
            .toList();
      case (SelectedPeriod.month):
        motorStateDataOn = motorStateDataOn
            .where((data) =>
                data.time.isAfter(DateTime.now().subtract(Duration(days: 30))))
            .toList();
    }
    final now = DateTime.now();
    int range;
    switch (state.requireValue.selectedPeriod) {
      case SelectedPeriod.week:
        range = 7;
        break;
      case SelectedPeriod.fifteenDays:
        range = 15;
        break;
      case SelectedPeriod.month:
        range = 30;
        break;
    }
    return motorStateDataOn
        .map((data) {
          // Calculate X: days ago (0 = N days ago, N-1 = today)
          final daysAgo = now
              .difference(
                  DateTime(data.time.year, data.time.month, data.time.day))
              .inDays;
          final x = (range - 1) - daysAgo; // (range-1) = today, 0 = N days ago
          // Calculate Y: hour + fraction of hour
          final y = data.time.hour + (data.time.minute / 60);
          return FlSpot(x.toDouble(), y);
        })
        .where((spot) => spot.x >= 0 && spot.x < range)
        .toList();
  }

  List<FlSpot> returnFlSpotFromRFTUpperThreshold() {
    List<ThresholdDataHistory> rftUpperThreshold =
        state.requireValue.thresholdDataHistory;
    switch (state.requireValue.selectedPeriod) {
      case (SelectedPeriod.week):
        rftUpperThreshold = rftUpperThreshold
            .where((data) => data.timestamp
                .isAfter(DateTime.now().subtract(Duration(days: 7))))
            .toList();
      case (SelectedPeriod.fifteenDays):
        rftUpperThreshold = rftUpperThreshold
            .where((data) => data.timestamp
                .isAfter(DateTime.now().subtract(Duration(days: 15))))
            .toList();
      case (SelectedPeriod.month):
        rftUpperThreshold = rftUpperThreshold
            .where((data) => data.timestamp
                .isAfter(DateTime.now().subtract(Duration(days: 30))))
            .toList();
    }
    final now = DateTime.now();
    int range;
    switch (state.requireValue.selectedPeriod) {
      case SelectedPeriod.week:
        range = 7;
        break;
      case SelectedPeriod.fifteenDays:
        range = 15;
        break;
      case SelectedPeriod.month:
        range = 30;
        break;
    }
    return rftUpperThreshold
        .map((data) {
          // Calculate X: days ago (0 = N days ago, N-1 = today)
          final daysAgo = now
              .difference(DateTime(data.timestamp.year, data.timestamp.month,
                  data.timestamp.day))
              .inDays;
          final x = (range - 1) - daysAgo; // (range-1) = today, 0 = N days ago

          return FlSpot(x.toDouble(), double.parse(data.rftThUpPercent));
        })
        .where((spot) => spot.x >= 0 && spot.x < range)
        .toList();
  }

  List<FlSpot> returnFlSpotFromRFTLowerThreshold() {
    List<ThresholdDataHistory> rftLowerThreshold =
        state.requireValue.thresholdDataHistory;
    switch (state.requireValue.selectedPeriod) {
      case (SelectedPeriod.week):
        rftLowerThreshold = rftLowerThreshold
            .where((data) => data.timestamp
                .isAfter(DateTime.now().subtract(Duration(days: 7))))
            .toList();
      case (SelectedPeriod.fifteenDays):
        rftLowerThreshold = rftLowerThreshold
            .where((data) => data.timestamp
                .isAfter(DateTime.now().subtract(Duration(days: 15))))
            .toList();
      case (SelectedPeriod.month):
        rftLowerThreshold = rftLowerThreshold
            .where((data) => data.timestamp
                .isAfter(DateTime.now().subtract(Duration(days: 30))))
            .toList();
    }
    final now = DateTime.now();
    int range;
    switch (state.requireValue.selectedPeriod) {
      case SelectedPeriod.week:
        range = 7;
        break;
      case SelectedPeriod.fifteenDays:
        range = 15;
        break;
      case SelectedPeriod.month:
        range = 30;
        break;
    }
    return rftLowerThreshold
        .map((data) {
          // Calculate X: days ago (0 = N days ago, N-1 = today)
          final daysAgo = now
              .difference(DateTime(data.timestamp.year, data.timestamp.month,
                  data.timestamp.day))
              .inDays;
          final x = (range - 1) - daysAgo; // (range-1) = today, 0 = N days ago

          return FlSpot(x.toDouble(), double.parse(data.rftThDnPercent));
        })
        .where((spot) => spot.x >= 0 && spot.x < range)
        .toList();
  }

  List<FlSpot> returnFlSpotFromMotorStateDataOff() {
    List<MotorStateData> motorStateDataOff =
        state.requireValue.motorStateDataOff;
    switch (state.requireValue.selectedPeriod) {
      case (SelectedPeriod.week):
        motorStateDataOff = motorStateDataOff
            .where((data) =>
                data.time.isAfter(DateTime.now().subtract(Duration(days: 7))))
            .toList();
      case (SelectedPeriod.fifteenDays):
        motorStateDataOff = motorStateDataOff
            .where((data) =>
                data.time.isAfter(DateTime.now().subtract(Duration(days: 15))))
            .toList();
      case (SelectedPeriod.month):
        motorStateDataOff = motorStateDataOff
            .where((data) =>
                data.time.isAfter(DateTime.now().subtract(Duration(days: 30))))
            .toList();
    }
    final now = DateTime.now();
    int range;
    switch (state.requireValue.selectedPeriod) {
      case SelectedPeriod.week:
        range = 7;
        break;
      case SelectedPeriod.fifteenDays:
        range = 15;
        break;
      case SelectedPeriod.month:
        range = 30;
        break;
    }
    return motorStateDataOff
        .map((data) {
          // Calculate X: days ago (0 = N days ago, N-1 = today)
          final daysAgo = now
              .difference(
                  DateTime(data.time.year, data.time.month, data.time.day))
              .inDays;
          final x = (range - 1) - daysAgo; // (range-1) = today, 0 = N days ago
          // Calculate Y: hour + fraction of hour
          final y = data.time.hour + (data.time.minute / 60);
          return FlSpot(x.toDouble(), y);
        })
        .where((spot) => spot.x >= 0 && spot.x < range)
        .toList();
  }

  List<BarChartGroupData> getWaterConsumptionBars() {
    log("Checking water consumption");
    List<LevelDataHistory> rftLevelData = state.requireValue.rftLevelData;
    List<LevelDataHistory> rsvLevelData = state.requireValue.rsvLevelData;

    // Determine the period range
    int range;
    DateTime startDate;
    // final now = DateTime.now();
    final now = DateTime(2025, 8, 26);

    switch (state.requireValue.selectedPeriod) {
      case SelectedPeriod.week:
        range = 7;
        startDate = now.subtract(const Duration(days: 7));
        break;
      case SelectedPeriod.fifteenDays:
        range = 15;
        startDate = now.subtract(const Duration(days: 15));
        break;
      case SelectedPeriod.month:
        range = 30;
        startDate = now.subtract(const Duration(days: 30));
        break;
    }

    // Filter data within the selected period
    rftLevelData = rftLevelData
        .where((data) => data.timestamp.isAfter(startDate))
        .toList();
    rsvLevelData = rsvLevelData
        .where((data) => data.timestamp.isAfter(startDate))
        .toList();

    // Sort data chronologically
    rftLevelData.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    rsvLevelData.sort((a, b) => a.timestamp.compareTo(b.timestamp));

    // Calculate daily consumption
    Map<int, double> rftDailyConsumption = {};
    Map<int, double> rsvDailyConsumption = {};

    // Initialize all days with 0 consumption
    for (int i = 0; i < range; i++) {
      rftDailyConsumption[i] = 0.0;
      rsvDailyConsumption[i] = 0.0;
    }

    // Calculate consumption for RFT (Roof Tank)
    _calculateConsumption(rftLevelData, rftDailyConsumption, range, now);
    // Calculate consumption for RSV (Reservoir)
    _calculateConsumption(rsvLevelData, rsvDailyConsumption, range, now);

    // Generate bar chart groups
    List<BarChartGroupData> barGroups = [];
    for (int i = 0; i < range; i++) {
      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: rftDailyConsumption[i] ?? 0.0,
              color: const Color(0xFF4ADE80),
              width: 16,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(6),
                topRight: Radius.circular(6),
              ),
            ),
            BarChartRodData(
              toY: rsvDailyConsumption[i] ?? 0.0,
              color: Colors.red,
              width: 16,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(6),
                topRight: Radius.circular(6),
              ),
            ),
          ],
        ),
      );
    }

    return barGroups;
  }

  void _calculateConsumption(
    List<LevelDataHistory> levelData,
    Map<int, double> dailyConsumption,
    int range,
    DateTime now,
  ) {
    // Group data by day
    Map<int, List<LevelDataHistory>> dataByDay = {};
// pi*((1.2^2)/4)*(H-L)*1000
    const double tankDiameterMeters = 1.2;
    const double tankRadiusMeters = tankDiameterMeters / 2.0;
    final double crossSectionAreaM2 = pi * tankRadiusMeters * tankRadiusMeters;
    // 1 meter increase in empty height = 1 meter * area m² * 1000 L/m³
    final double litresPerMeterHeight = crossSectionAreaM2 * 1000.0;

    for (var data in levelData) {
      final daysAgo = now
          .difference(DateTime(
              data.timestamp.year, data.timestamp.month, data.timestamp.day))
          .inDays;
      final dayIndex = (range - 1) - daysAgo;

      if (dayIndex >= 0 && dayIndex < range) {
        dataByDay.putIfAbsent(dayIndex, () => []);
        dataByDay[dayIndex]!.add(data);
      }
    }

    // Calculate consumption for each day
    dataByDay.forEach((dayIndex, dayData) {
      dayData.sort((a, b) => a.timestamp.compareTo(b.timestamp));

      double dayConsumption = 0.0;

      // Iterate through consecutive measurements
      for (int i = 1; i < dayData.length; i++) {
        final previousLevel = dayData[i - 1].average;
        final currentLevel = dayData[i].average;

        // Calculate the difference (consumption)
        // C_total = Σ max(0, v_{i-1} - v_i)
        final consumption = (currentLevel - previousLevel).toDouble();

        // Only add positive values (actual consumption, not refills)
        if (consumption > 0) {
          dayConsumption += consumption;
        }
      }
      final dayConsumptionLitres = dayConsumption * litresPerMeterHeight;
      // Add to the existing consumption for this day
      dailyConsumption[dayIndex] =
          (dailyConsumption[dayIndex] ?? 0.0) + dayConsumptionLitres;
    });
  }

  void changeSelectedPeriod(SelectedPeriod period) {
    state = AsyncValue.data(
      state.requireValue.copyWith(selectedPeriod: period),
    );
  }
}
