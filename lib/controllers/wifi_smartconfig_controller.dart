import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:esp_smartconfig/esp_smartconfig.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:water_saver/models/connection_model.dart';

class WifiSmartConfigController extends AsyncNotifier<ConnectionModel> {
  final provisioner = Provisioner.espTouch();
  @override
  FutureOr<ConnectionModel> build() async {
    await requestLocationPermission();
    await checkConnectivity();
    final connectionModel = await refreshConnectionDetails();

    return connectionModel;
  }

  Future<void> requestLocationPermission() async {
    await Permission.location.onDeniedCallback(() {
      throw Exception('Location permission denied');
    }).onLimitedCallback(() {
      throw Exception('Location permission limited');
    }).onProvisionalCallback(() {
      throw Exception('Location permission provisional');
    }).onPermanentlyDeniedCallback(() {
      throw Exception('Location permission denied');
    }).request();
  }

  Future<void> checkConnectivity() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.wifi)) {
      return;
    }
    throw Exception('No WiFi connection');
  }

  Future<ConnectionModel> refreshConnectionDetails() async {
    state = AsyncValue.loading();
    try {
      await checkConnectivity();
      final info = NetworkInfo();

      final wifiName = await info.getWifiName();
      final wifiBSSID = await info.getWifiBSSID();

      log('Wi-Fi Name: $wifiName');
      log('Wi-Fi BSSID: $wifiBSSID');

      state = AsyncValue.data(ConnectionModel(
        bssid: wifiBSSID,
        name: wifiName,
      ));
      return state.requireValue;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      return ConnectionModel(
        bssid: '',
        name: '',
      );
    }
  }

  void startProvisioning(String password) {
    state = AsyncValue.data(ConnectionModel(
        bssid: state.requireValue.bssid,
        name: state.requireValue.name,
        password: password));
    provisioner.start(ProvisioningRequest.fromStrings(
        ssid: state.requireValue.name!,
        bssid: state.requireValue.bssid!,
        password: state.requireValue.password));
  }
}
