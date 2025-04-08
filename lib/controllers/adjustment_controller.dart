import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:water_saver/models/adjustments_page_data.dart';

class AdjustmentController extends Notifier<AdjustmentsPageData> {
  @override
  AdjustmentsPageData build() {
    return AdjustmentsPageData();
  }

  bool validateThresholds() {
    if (state.motorOffThresholdTank <= state.motorOnThresholdTank) {
      // Switched condition
      state = state.copyWith(isThresholdError: true); // Set error state
      return false;
    }
    state = state.copyWith(isThresholdError: false); // Clear error state
    return true;
  }

  void updateSettings() {
    // Logic to update settings
    log("Auto Data Log: ${state.autoDataLog}");
  }

  void toggleAutoDataLog(bool value) {
    state = state.copyWith(autoDataLog: value);
    log("Auto Data Log toggled: ${state.autoDataLog}");
  }

  void updateMotorOffThresholdTank(
    double value,
  ) {
    state = state.copyWith(motorOffThresholdTank: value);
    log("Roof Top Tank - Motor Off Threshold: ${state.motorOffThresholdTank}");
  }

  void updateMotorOnThresholdTank(double value) {
    state = state.copyWith(motorOnThresholdTank: value);
    log("Roof Top Tank - Motor On Threshold: ${state.motorOnThresholdTank}");
  }

  void updateMotorOffThresholdReservoir(double value) {
    state = state.copyWith(motorOffThresholdReservoir: value);
    log("Reservoir - Motor Off Threshold: ${state.motorOffThresholdReservoir}");
  }

  void updateMotorOnThresholdReservoir(double value) {
    state = state.copyWith(motorOnThresholdReservoir: value);
    log("Reservoir - Motor On Threshold: ${state.motorOnThresholdReservoir}");
  }

  void saveAdjustments() {
    if (!validateThresholds()) {
      log("Saving Unsuccessful: Level threshold Motor off > Level threshold Motor on");
      return;
    }
    // Logic to save slider values
    log("Roof Top Tank - Motor Off: ${state.motorOffThresholdTank}");
    log("Roof Top Tank - Motor On: ${state.motorOnThresholdTank}");
    log("Reservoir - Motor Off: ${state.motorOffThresholdReservoir}");
    log("Reservoir - Motor On: ${state.motorOnThresholdReservoir}");
    log("Adjustments saved!");
  }
}
