import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:water_saver/models/app_user.dart';
import 'package:water_saver/models/firebase_model.dart';
import 'package:water_saver/models/user_data_receive.dart';
import 'package:water_saver/models/user_data_upload.dart';
import 'package:water_saver/models/user_profile.dart';

class AppUserController extends AsyncNotifier<AppUser> {
  StreamSubscription<DocumentSnapshot>? _userDataUploadSubscription;
  final prefs = GetIt.I<FlutterSecureStorage>();

  @override
  Future<AppUser> build() async {
    // Fetch user data from a data source (e.g., API, database)
    String deviceId = await prefs.read(key: 'deviceId') ?? '';
    final userProfile = await fetchUserProfile(deviceId);
    final userDataUpload = await fetchUserDataUpload(deviceId);
    final userDataReceive = await fetchUserDataReceive(deviceId);
    _startFirestoreListener(deviceId);
    return AppUser(
        deviceId,
        UserDataUpload.fromJson(userDataUpload),
        UserProfile.fromJson(userProfile),
        UserDataReceive.fromJson(userDataReceive));

    // Start listening to Firestore updates
  }

  void _startFirestoreListener(String deviceId) {
    _userDataUploadSubscription?.cancel();

    // Add a listener to cancel subscription when provider is disposed
    ref.onDispose(() {
      _userDataUploadSubscription?.cancel();
    });

    _userDataUploadSubscription =
        FBCollections.userDataUpload.doc(deviceId).snapshots().listen(
      (DocumentSnapshot snapshot) {
        if (snapshot.exists && state.hasValue) {
          try {
            final updatedData = snapshot.data() as Map<String, dynamic>;
            final currentAppUser = state.requireValue;

            // Update only the userDataUpload part
            final updatedAppUser = currentAppUser.copyWith(
              userDataUpload: UserDataUpload.fromJson(updatedData),
            );

            state = AsyncValue.data(updatedAppUser);
          } catch (error) {
            // Handle parsing errors gracefully
            log('Error updating from Firestore: $error');
          }
        }
      },
      onError: (error) {
        log('Firestore listener error: $error');
      },
    );
  }

  Future<Map<String, dynamic>> fetchUserProfile(String deviceId) async {
    DocumentSnapshot doc = await FBCollections.userProfile.doc(deviceId).get();
    return doc.data() as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> fetchUserDataUpload(String deviceId) async {
    DocumentSnapshot doc =
        await FBCollections.userDataUpload.doc(deviceId).get();
    return doc.data() as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> fetchUserDataReceive(String deviceId) async {
    DocumentSnapshot doc =
        await FBCollections.userDataReceive.doc(deviceId).get();
    return doc.data() as Map<String, dynamic>;
  }

  Future<void> updateMotorState(bool motorState,
      {MotorState source = MotorState.auto}) async {
    final deviceId = state.requireValue.deviceId;
    AppUser appUser = state.requireValue.copyWith(
        userDataUpload: state.requireValue.userDataUpload.copyWith(
            motorOn: motorState ? "yes" : "no",
            motorOff: motorState ? "no" : "yes"));
    await FBCollections.userDataUpload.doc(deviceId).update(
          appUser.userDataUpload.toJson(),
        );

    await FBCollections.userDataUpload
        .doc(deviceId)
        .collection('motorData')
        .add(appUser.userDataUpload.returnMotorState(
          source: source,
        ));

    state = AsyncValue.data(appUser);
  }

  void updateMotorOffThresholdTank(
    double value,
  ) {
    state = AsyncValue.data(state.requireValue.copyWith(
        userDataReceive: state.requireValue.userDataReceive
            .copyWith(rftThUpPercent: value.toString())));
  }

  void updateMotorOnThresholdTank(double value) {
    state = AsyncValue.data(state.requireValue.copyWith(
        userDataReceive: state.requireValue.userDataReceive
            .copyWith(rftThDnPercent: value.toString())));
  }

  void updateMotorOnThresholdReservoir(double value) {
    state = AsyncValue.data(state.requireValue.copyWith(
        userDataReceive: state.requireValue.userDataReceive
            .copyWith(rsvThDnPercent: value.toString())));
  }

  bool validateThresholds() {
    if (double.parse(state.requireValue.userDataReceive.rftThUpPercent) <=
        double.parse(state.requireValue.userDataReceive.rftThDnPercent)) {
      return false;
    }

    return true;
  }

  Future<void> saveAdjustments() async {
    final deviceId = state.requireValue.deviceId;
    FBCollections.userDataReceive
        .doc(deviceId)
        .update(state.requireValue.userDataReceive.toJson());
  }

  Future<void> acceptAutoToggleConsent() async {
    final deviceId = state.requireValue.deviceId;
    if (deviceId.isEmpty) return;

    try {
      await FBCollections.userDataReceive
          .doc(deviceId)
          .update({'Auto_toggle_consent': true});

      final current = state.requireValue;
      final updated = current.copyWith(
        userDataReceive:
            current.userDataReceive.copyWith(autoToggleConsent: true),
      );
      state = AsyncValue.data(updated);
    } catch (e) {
      log('Error updating auto toggle consent: $e');
    }
  }

  Future<bool> getAutoMode() async {
    final v = await prefs.read(key: 'autoMode');
    return v == null ? true : v.toLowerCase() == 'true';
  }

  Future<void> setAutoMode(bool value) async {
    await prefs.write(key: 'autoMode', value: value.toString());
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
