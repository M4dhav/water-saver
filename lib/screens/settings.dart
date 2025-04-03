import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interactive_slider/interactive_slider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController rooftopTankHeightController =
      TextEditingController();
  final SharedPreferences prefs = Get.find();
  late String? deviceId = prefs.getString('device_id');
  final TextEditingController reservoirTankHeightController =
      TextEditingController();
  final TextEditingController cableLengthController = TextEditingController();
  List<dynamic> roofTopThreshold = [100, 0];
  List<dynamic> reservoirThreshold = [100, 0];
  List<int> rooftopTankHeights = [
    1,
    2,
    3,
    4,
  ];
  List<int> cableLengths = [15, 20, 25, 30];
  List<int> reservoirTankHeights = [4, 5, 6, 7, 8];
  Map<String, dynamic> userData = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(deviceId)
          .get();

      setState(() {
        userData = doc.data() as Map<String, dynamic>;
        roofTopThreshold = userData['rooftopThreshold'] as List<int>;
        reservoirThreshold = userData['reservoirThreshold'] as List<int>;
      });
      rooftopTankHeightController.text = userData['rooftopHeight'].toString();
      reservoirTankHeightController.text =
          userData['reservoirHeight'].toString();
      cableLengthController.text = userData['cableLength'].toString();
      log('rooftop: ${rooftopTankHeightController.text}, reservoir ${reservoirTankHeightController.text}, cable ${cableLengthController.text}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff081c5c),
        appBar: AppBar(
          title: const Text("Device Settings"),
          backgroundColor: const Color(0xff081c5c),
          foregroundColor: Colors.white,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
          child: Column(
            children: [
              DropdownSettingsWidget(
                paramText: "Rooftop Tank Height",
                textController: rooftopTankHeightController,
                hintText: "Rooftop Height",
                dropdownMenuEntries:
                    rooftopTankHeights.map<DropdownMenuEntry<int>>((int value) {
                  return DropdownMenuEntry(value: value, label: "$value m");
                }).toList(),
              ),
              DropdownSettingsWidget(
                paramText: "Reservoir Tank Height",
                textController: reservoirTankHeightController,
                hintText: "Reservoir Height",
                dropdownMenuEntries: reservoirTankHeights
                    .map<DropdownMenuEntry<int>>((int value) {
                  return DropdownMenuEntry(value: value, label: "$value m");
                }).toList(),
              ),
              DropdownSettingsWidget(
                paramText: "Cable Length",
                textController: cableLengthController,
                hintText: "Cable Length",
                dropdownMenuEntries:
                    cableLengths.map<DropdownMenuEntry<int>>((int value) {
                  return DropdownMenuEntry(value: value, label: "$value m");
                }).toList(),
              ),
              SliderSettingsWidget(
                tankThreshold: roofTopThreshold,
                tankName: "Rooftop",
                onChangedOff: (value) =>
                    setState(() => roofTopThreshold[0] = value.toInt()),
                onChangedOn: (value) =>
                    setState(() => roofTopThreshold[1] = value.toInt()),
              ),
              SliderSettingsWidget(
                tankThreshold: reservoirThreshold,
                tankName: "Reservoir",
                onChangedOff: (value) =>
                    setState(() => reservoirThreshold[0] = value.toInt()),
                onChangedOn: (value) =>
                    setState(() => reservoirThreshold[1] = value.toInt()),
              ),
              ElevatedButton(
                onPressed: () async {
                  log(rooftopTankHeightController.text);
                  log(reservoirTankHeightController.text);
                  log(cableLengthController.text);
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(deviceId)
                      .update({
                    'rooftopThreshold': roofTopThreshold,
                    'reservoirThreshold': reservoirThreshold,
                    'rooftopHeight':
                        int.parse(rooftopTankHeightController.text),
                    'reservoirHeight':
                        int.parse(reservoirTankHeightController.text),
                    'cableLength': int.parse(cableLengthController.text),
                  });
                  Get.snackbar('Success',
                      "Device Settings have been updated successfully");
                  Get.back();
                },
                child: const Text("Save Settings"),
              )
            ],
          ),
        ));
  }
}

class SliderSettingsWidget extends StatelessWidget {
  const SliderSettingsWidget({
    super.key,
    required this.tankThreshold,
    required this.tankName,
    required this.onChangedOff,
    required this.onChangedOn,
  });

  final List<dynamic> tankThreshold;
  final String tankName;
  final void Function(double) onChangedOff;
  final void Function(double) onChangedOn;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 2.w),
      child: Container(
        height: 26.h,
        width: double.infinity,
        //  color: Colors.blue,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey),
            color: const Color(0xff083464)),
        child: Column(
          children: [
            Text(
              tankName,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.px,
                  color: Colors.white),
            ),
            Text("Level Threshold: Motor OFF",
                style: TextStyle(fontSize: 17.px, color: Colors.white)),
            Row(
              children: [
                Expanded(
                  child: InteractiveSlider(
                    initialProgress: tankThreshold[0].toDouble(),
                    unfocusedHeight: 3.h,
                    focusedHeight: 4.h,
                    endIcon: Text(
                      "${tankThreshold[0].toInt()}%",
                    ),
                    min: 1.0,
                    max: 100.0,
                    onChanged: onChangedOff,
                    endIconBuilder: (context, value, child) => Text(
                      "${tankThreshold[0].toInt()}%",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 15.px),
                    ),
                    backgroundColor: const Color(0xffffccac),
                    unfocusedOpacity: 1.0,
                    foregroundColor: Colors.green,
                  ),
                )
              ],
            ),
            Text("Level Threshold: Motor ON",
                style: TextStyle(fontSize: 17.px, color: Colors.white)),
            Row(
              children: [
                Expanded(
                  child: InteractiveSlider(
                    initialProgress: tankThreshold[1].toDouble(),
                    unfocusedHeight: 3.h,
                    focusedHeight: 4.h,
                    endIcon: Text(
                      "${tankThreshold[1].toInt()}%",
                    ),
                    endIconBuilder: (context, value, child) => Text(
                      "${tankThreshold[1].toInt()}%",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 15.px),
                    ),
                    min: 1.0,
                    max: 100.0,
                    onChanged: onChangedOn,
                    backgroundColor: const Color(0xffffccac),
                    unfocusedOpacity: 1.0,
                    foregroundColor: Colors.green,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DropdownSettingsWidget extends StatelessWidget {
  const DropdownSettingsWidget({
    super.key,
    required this.textController,
    required this.hintText,
    required this.paramText,
    required this.dropdownMenuEntries,
  });

  final TextEditingController textController;
  final String hintText;
  final String paramText;
  final List<DropdownMenuEntry<int>> dropdownMenuEntries;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
      child: Container(
        height: 8.h,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          color: const Color(0xff083464),
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 1.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                paramText,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20.px,
                    color: Colors.white),
              ),
              DropdownMenu<int>(
                //initialSelection: int.parse(textController.text),
                dropdownMenuEntries: dropdownMenuEntries,
                controller: textController,
                textStyle: const TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
