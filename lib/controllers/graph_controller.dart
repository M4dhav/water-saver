import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:water_saver/models/firebase_model.dart';
import 'package:water_saver/models/graph_page_model.dart';
import 'package:water_saver/models/motor_state_data.dart';

class GraphController extends AsyncNotifier<GraphPageModel> {
  @override
  Future<GraphPageModel> build() async {
    List<MotorStateData> motorStateData = await getMotorStateData();
    log(motorStateData.toString());

    return GraphPageModel(
        motorStateData: motorStateData,
        motorStateDataOff: filterMotorStateDataOff(motorStateData),
        motorStateDataOn: filterMotorStateDataOn(motorStateData));
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

  void changeSelectedPeriod(SelectedPeriod period) {
    state = AsyncValue.data(
      state.requireValue.copyWith(selectedPeriod: period),
    );
  }
}
