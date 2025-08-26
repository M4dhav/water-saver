import 'dart:developer';

import 'package:esp_smartconfig/esp_smartconfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
      backgroundColor: const Color(0xFF071526),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F1C2E),
        title: const Text(
          'Configure Wi-Fi Network',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
              onPressed: () async =>
                  await smartConfigController.refreshConnectionDetails(),
              icon: const Icon(Icons.refresh, color: Colors.white))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xFF071526),
          child: connectionModel.when(
              data: (connectionModel) {
                if (connectionModel.name == null) {
                  return buildWifiErrorPage(context);
                }
                return buildPageBody(
                    connectionModel, smartConfigController, context);
              },
              error: (error, stackTrace) {
                log('Error recieved here');
                if (error.toString() ==
                    'Exception: Location permission denied') {
                  return buildWifiErrorPage(context);
                } else if (error.toString() ==
                    'Exception: No WiFi connection') {
                  return buildWiFiOffPage();
                }
                return Scaffold(
                  backgroundColor: const Color(0xFF071526),
                  body: Center(
                    child: Text(
                      'Error: $error',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
              loading: () => const Center(
                      child: CircularProgressIndicator(
                    color: Color(0xFF4FC3F7),
                  ))),
        ),
      ),
    );
  }

  Widget buildPageBody(ConnectionModel model,
      WifiSmartConfigController controller, BuildContext context) {
    final passwordController = TextEditingController();
    final router = GoRouter.of(context);
    return Container(
      height: 100.h,
      width: double.infinity,
      color: const Color(0xFF071526),
      child: Padding(
        padding: EdgeInsets.all(6.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: const Color(0xFF0F1C2E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    "Wi-Fi Network Details",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      const Icon(Icons.wifi, color: Color(0xFF4FC3F7)),
                      SizedBox(width: 2.w),
                      Text(
                        "Name: ${model.name ?? 'Unknown'}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      const Icon(Icons.router, color: Color(0xFF4FC3F7)),
                      SizedBox(width: 2.w),
                      Text(
                        "BSSID: ${model.bssid ?? 'Unknown'}",
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Text(
                  "Enter Wi-Fi Password",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 2.h),
                SizedBox(
                  width: 80.w,
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Enter password",
                      hintStyle: const TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: const Color(0xFF0F1C2E),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFF4FC3F7)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFF4FC3F7)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            color: Color(0xFF4FC3F7), width: 2),
                      ),
                      prefixIcon:
                          const Icon(Icons.lock, color: Color(0xFF4FC3F7)),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  width: 80.w,
                  height: 6.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4FC3F7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      final password = passwordController.text;
                      if (password.isNotEmpty) {
                        if (password.length < 8) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Password must be at least 8 characters long'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }
                        controller.startProvisioning(password);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Configuring device...'),
                            backgroundColor: Color(0xFF4ADE80),
                          ),
                        );
                        controller.provisioner.listen((response) async {
                          buildConnectedDevicePopup(
                              response, context, controller);
                          // Navigate to the next screen
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter Wi-Fi password'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    child: Text(
                      'Configure Device',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () => context.pushReplacement('/home'),
                    child: const Text('Go to Home'))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildWifiErrorPage(BuildContext context) {
    return Container(
      height: 100.h,
      width: double.infinity,
      color: const Color(0xFF071526),
      child: Padding(
        padding: EdgeInsets.all(6.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: const Color(0xFF0F1C2E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.location_off,
                    color: Color(0xFFEF4444),
                    size: 64,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Location Permission Required',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'To configure Wi-Fi networks for your device, we need precise location permission.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                SizedBox(
                  width: 80.w,
                  height: 6.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4FC3F7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () async => await openAppSettings(),
                    child: Text(
                      'Open Settings',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildWiFiOffPage() {
    return Container(
      height: 100.h,
      width: double.infinity,
      color: const Color(0xFF071526),
      child: Padding(
        padding: EdgeInsets.all(6.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: const Color(0xFF0F1C2E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.wifi_off,
                    color: Color(0xFFEF4444),
                    size: 64,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Wi-Fi is Turned Off',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Please turn on Wi-Fi to configure your device.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildConnectedDevicePopup(ProvisioningResponse response,
      BuildContext context, WifiSmartConfigController controller) {
    return AlertDialog(
      content: Text("Device ${response.bssidText} is connected to the Wi-Fi"),
      actions: [
        TextButton(
          onPressed: () {
            controller.provisioner.stop();

            context.pushReplacement('/calibration');
          },
          child: const Text("OK"),
        ),
      ],
    );
  }
}
