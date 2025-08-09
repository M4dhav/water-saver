import 'package:flutter/material.dart';
import 'package:water_saver/controllers/app_user_controller.dart';
import 'package:water_saver/models/app_user.dart';
import 'package:water_saver/models/firebase_model.dart';

class ToggleController {
  Future<bool> getAutoMode(AppUserController appUserController) {
    return appUserController.getAutoMode();
  }

  Future<bool> handleAutoToggle({
    required BuildContext context,
    required bool currentAutoMode,
    required AppUser appUser,
    required AppUserController appUserController,
  }) async {
    if (currentAutoMode) {
      final consentGiven =
          appUser.userDataReceive.toggleConsent.toLowerCase() == 'yes';
      if (!consentGiven) {
        final gotConsent =
            await _showConsentDialog(context, appUser.userProfile.name);
        if (gotConsent == true) {
          await appUserController.acceptAutoToggleConsent();
        } else {
          return true;
        }
      }
      final confirm = await _confirmAutoOff(context);
      if (confirm == true) {
        await appUserController.setAutoMode(false);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Auto Mode turned OFF')));
        return false;
      }
      return true;
    } else {
      await appUserController.setAutoMode(true);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Auto Mode turned ON')));
      return true;
    }
  }

  Future<void> handleMotorToggle({
    required BuildContext context,
    required bool isAutoMode,
    required bool currentMotorOn,
    required AppUser appUser,
    required AppUserController appUserController,
  }) async {
    if (isAutoMode) {
      _showAutoModeRestriction(context);
      return;
    }

    final turningOn = !currentMotorOn;
    if (turningOn) {
      final allowed = await _canTurnMotorOn(appUser);
      if (!allowed) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content:
                  Text('Manual ON limit reached (3 times/24h). Try later.')),
        );
        return;
      }
    }

    await appUserController.updateMotorState(turningOn, manual: true);
  }

  Future<void> handleMotorButtonPressed({
    required BuildContext context,
    required bool isAutoMode,
    required bool currentMotorOn,
    required AppUser appUser,
    required AppUserController appUserController,
  }) async {
    return handleMotorToggle(
      context: context,
      isAutoMode: isAutoMode,
      currentMotorOn: currentMotorOn,
      appUser: appUser,
      appUserController: appUserController,
    );
  }

  Future<bool> _canTurnMotorOn(AppUser appUser) async {
    final deviceId = appUser.deviceId;
    if (deviceId.isEmpty) return false;

    final now = DateTime.now().millisecondsSinceEpoch;
    final threshold = now - 24 * 60 * 60 * 1000;

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

  Future<bool?> _showConsentDialog(
      BuildContext context, String userName) async {
    bool checked = false;
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return StatefulBuilder(builder: (ctx, setState) {
          return AlertDialog(
            backgroundColor: const Color(0xFF0F1C2E),
            title: const Text('Warning', style: TextStyle(color: Colors.white)),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Your're trying to disable the auto mode which may result in imbalanced performance which may ultimately result in circuit board faliure.\nWe suggest you to change the Threshhold values in the adjustments page according to your desired needs.",
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: checked,
                        onChanged: (v) => setState(() => checked = v ?? false),
                        activeColor: const Color(0xFF4ADE80),
                        side: const BorderSide(color: Colors.white),
                      ),
                      Expanded(
                        child: Text(
                          'I($userName) i will take the responsibilty of the damages that may occur from turning auto mode off.',
                          style: const TextStyle(color: Color(0xFFEF4444)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF4ADE80),
                ),
                onPressed: () => Navigator.of(ctx).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFFEF4444),
                ),
                onPressed: checked ? () => Navigator.of(ctx).pop(true) : null,
                child: const Text('Save'),
              ),
            ],
          );
        });
      },
    );
  }

  Future<bool?> _confirmAutoOff(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF0F1C2E),
        title: const Text('Confirm', style: TextStyle(color: Colors.white)),
        content: const Text('Do you really want to turn Auto Mode off',
            style: TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF4ADE80),
            ),
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFFEF4444),
            ),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  void _showAutoModeRestriction(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF0F1C2E),
        title: const Text('Not Allowed', style: TextStyle(color: Colors.white)),
        content: const Text('This action cannot be performed in Auto mode.',
            style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF4ADE80),
            ),
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }
}
