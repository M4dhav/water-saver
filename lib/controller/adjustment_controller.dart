import 'package:get/get.dart';

class AdjustmentsController extends GetxController {
  var motorOffThresholdTank = 0.5.obs;
  var motorOnThresholdTank = 0.2.obs;

  var motorOffThresholdReservoir = 0.5.obs;
  var motorOnThresholdReservoir = 0.2.obs;
  RxBool autoDataLog = false.obs;

  void updateSettings() {
    // Logic to update settings
    print("Auto Data Log: ${autoDataLog.value}");
  }

  void saveAdjustments() {
    // Store in backend
    print("Adjustments saved!");
  }
}
