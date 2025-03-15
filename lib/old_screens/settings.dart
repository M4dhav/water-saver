import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:interactive_slider/interactive_slider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController rooftopTankHeightController =
      TextEditingController();
  final TextEditingController reservoirTankHeightController =
      TextEditingController();
  final TextEditingController cableLengthController = TextEditingController();
  List<int> roofTopThreshold = [100, 0];
  List<int> reservoirThreshold = [100, 0];
  List<double> rooftopTankHeights = [
    1.0,
    2.0,
    3.0,
    4.0,
  ];
  List<double> cableLengths = [15, 20, 25, 30];
  List<double> reservoirTankHeights = [4.0, 5.0, 6.0, 7.0, 8.0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Device Settings"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              DropdownSettingsWidget(
                paramText: "Rooftop Tank Height",
                textController: rooftopTankHeightController,
                hintText: "Rooftop Height",
                dropdownMenuEntries: rooftopTankHeights
                    .map<DropdownMenuEntry<double>>((double value) {
                  return DropdownMenuEntry(value: value, label: "$value m");
                }).toList(),
              ),
              DropdownSettingsWidget(
                paramText: "Reservoir Tank Height",
                textController: reservoirTankHeightController,
                hintText: "Reservoir Height",
                dropdownMenuEntries: reservoirTankHeights
                    .map<DropdownMenuEntry<double>>((double value) {
                  return DropdownMenuEntry(value: value, label: "$value m");
                }).toList(),
              ),
              DropdownSettingsWidget(
                paramText: "Cable Length",
                textController: cableLengthController,
                hintText: "Cable Length",
                dropdownMenuEntries:
                    cableLengths.map<DropdownMenuEntry<double>>((double value) {
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
                onPressed: () {
                  log(rooftopTankHeightController.text);
                  log(reservoirTankHeightController.text);
                  log(cableLengthController.text);
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

  final List<int> tankThreshold;
  final String tankName;
  final void Function(double) onChangedOff;
  final void Function(double) onChangedOn;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 220,
        width: double.infinity,
        //  color: Colors.blue,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.blue.shade900),
            color: Colors.blue.shade100),
        child: Column(
          children: [
            Text(
              tankName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const Text("Level Threshold: Motor OFF",
                style: TextStyle(fontSize: 20)),
            Row(
              children: [
                Expanded(
                  child: InteractiveSlider(
                    initialProgress: tankThreshold[0].toDouble(),
                    unfocusedHeight: 25,
                    focusedHeight: 30,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 15),
                    endIcon: Text(
                      "${tankThreshold[0].toInt()}%",
                    ),
                    min: 1.0,
                    max: 100.0,
                    onChanged: onChangedOff,
                    backgroundColor: Colors.blue.shade300,
                  ),
                )
              ],
            ),
            const Text("Level Threshold: Motor ON",
                style: TextStyle(fontSize: 20)),
            Row(
              children: [
                Expanded(
                  child: InteractiveSlider(
                    initialProgress: tankThreshold[1].toDouble(),
                    unfocusedHeight: 25,
                    focusedHeight: 30,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 15),
                    endIcon: Text(
                      "${tankThreshold[1].toInt()}%",
                    ),
                    min: 1.0,
                    max: 100.0,
                    onChanged: onChangedOn,
                    backgroundColor: Colors.blue.shade300,
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
  final List<DropdownMenuEntry<double>> dropdownMenuEntries;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 6),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue.shade900),
          color: Colors.blue.shade100,
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                paramText,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              DropdownMenu<double>(
                dropdownMenuEntries: dropdownMenuEntries,
                controller: textController,
              )
            ],
          ),
        ),
      ),
    );
  }
}
