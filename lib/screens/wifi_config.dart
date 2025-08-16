import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:water_saver/controllers/wifi_smartconfig_controller.dart';
import 'package:water_saver/models/connection_model.dart';
import 'package:water_saver/providers/wifi_smartconfig_controller_provider.dart';

class WifiConfigScreen extends ConsumerWidget {
  const WifiConfigScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectionModel = ref.watch(wifiSmartConfigProvider);
    final smartConfigController = ref.watch(wifiSmartConfigProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text('Configure Wi-Fi Network for Device'),
        actions: [
          IconButton(
              onPressed: () async => await smartConfigController
                  .refreshConnectionDetails(set: true),
              icon: Icon(Icons.refresh))
        ],
      ),
      body: connectionModel.when(
          data: (connectionModel) {
            if (connectionModel.name == null) {
              return buildWifiErrorPage();
            }
            return buildPageBody(connectionModel, smartConfigController);
          },
          error: (error, stackTrace) {
            if (error.toString() == 'Exception: Location permission denied') {
              return buildWifiErrorPage();
            } else if (error.toString() == 'Exception: No WiFi connection') {
              return buildWiFiOffPage();
            }
            return Scaffold(body: Center(child: Text('Error: $error')));
          },
          loading: () => Center(child: CircularProgressIndicator())),
    );
  }

  Widget buildPageBody(
      ConnectionModel model, WifiSmartConfigController controller) {
    final passwordController = TextEditingController();
    return SizedBox(
      height: 100.h,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Name: " + (model.name ?? '')),
          Text("BSSID: " + (model.bssid ?? '')),
          SizedBox(
            width: 60.w,
            child: TextField(
              controller: passwordController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              )),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final password = passwordController.text;
              if (password.isNotEmpty) {
                controller.startProvisioning(password);
              }
            },
            child: Text('Broadcast'),
          ),
        ],
      ),
    );
  }

  Widget buildWifiErrorPage() {
    return SizedBox(
      height: 100.h,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
              'You need to grant precise location permission to the App to configure Wi-Fi Networks. Please press the button below to enter App Settings and provide the permissions'),
          ElevatedButton(
            child: Text('Open Settings'),
            onPressed: () async => await openAppSettings(),
          ),
        ],
      ),
    );
  }

  Widget buildWiFiOffPage() {
    return SizedBox(
      height: 100.h,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
              'Your Wi-Fi is currently turned off. Please turn it on to configure the device.'),
        ],
      ),
    );
  }
}
