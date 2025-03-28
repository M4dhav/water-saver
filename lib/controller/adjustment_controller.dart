import 'package:get/get.dart';

class AdjustmentsController extends GetxController {
  var motorOffThresholdTank = 0.5.obs;
  var motorOnThresholdTank = 0.2.obs;

  var motorOffThresholdReservoir = 0.5.obs;
  var motorOnThresholdReservoir = 0.2.obs;
  RxBool autoDataLog = false.obs;
  RxBool isThresholdError = false.obs; // Add observable for error state

  bool get isReservoirMotorOnRequired => false;

  bool validateThresholds() {
    if (motorOffThresholdTank.value <= motorOnThresholdTank.value) {
      // Switched condition
      isThresholdError.value = true; // Set error state
      return false;
    }
    isThresholdError.value = false; // Clear error state
    return true;
  }

  void updateSettings() {
    // Logic to update settings
    print("Auto Data Log: ${autoDataLog.value}");
  }

  void saveAdjustments() {
    if (!validateThresholds()) {
      print(
          "Saving Unsuccessful: Level threshold Motor off > Level threshold Motor on");
      return;
    }
    // Logic to save slider values
    print("Roof Top Tank - Motor Off: ${motorOffThresholdTank.value}");
    print("Roof Top Tank - Motor On: ${motorOnThresholdTank.value}");
    print("Reservoir - Motor Off: ${motorOffThresholdReservoir.value}");
    print("Reservoir - Motor On: ${motorOnThresholdReservoir.value}");
    print("Adjustments saved!");
  }
}
