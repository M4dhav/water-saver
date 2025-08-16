import 'package:water_saver/controllers/app_user_controller.dart';
import 'package:water_saver/models/app_user.dart';
import 'package:water_saver/models/firebase_model.dart';

class ToggleController {
  Future<bool> getAutoMode(AppUserController appUserController) {
    return appUserController.getAutoMode();
  }

  bool isConsentGiven(AppUser appUser) {
    return appUser.userDataReceive.autoToggleConsent == true;
  }

  Future<bool> canTurnMotorOn(AppUser appUser) async {
    final deviceId = appUser.deviceId;
    if (deviceId.isEmpty) return false;

    final now = DateTime.now();
    final threshold =
        now.subtract(const Duration(days: 1)).millisecondsSinceEpoch;

    final query = await FBCollections.userDataUpload
        .doc(deviceId)
        .collection('motorData')
        .where('time', isGreaterThan: threshold)
        .orderBy('time')
        .get();
  
    int onCount = 0;
    for (final d in query.docs) {
      final data = d.data();
      final isManual = (data['source'] ?? 'auto').toString() == 'manual';
      final motorOn =
          (data['motorOn'] ?? 'no').toString().toLowerCase() == 'yes';
      if (isManual && motorOn) onCount++;
    }
    return onCount < 3;
  }
}
