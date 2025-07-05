import 'package:flutter/material.dart';

class GraphController extends ChangeNotifier {
  List<MotorStateData> _motorStateData = [];
  bool _isLoading = false;
  String _selectedPeriod = 'Today';
  List<MotorStateData> get motorStateData => _motorStateData;
  bool get isLoading => _isLoading;
  String get selectedPeriod => _selectedPeriod;
  final List<String> availablePeriods = [
    'Today',
    'Yesterday',
    'This Week',
    'Last Week'
  ];

  GraphController() {
    loadGraphData();
  }
  Future<void> loadGraphData() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 800));
    _motorStateData = _generateSampleMotorData();

    _isLoading = false;
    notifyListeners();
  }
  void changePeriod(String period) {
    if (_selectedPeriod != period) {
      _selectedPeriod = period;
      loadGraphData();
    }
  }
  List<MotorStateData> _generateSampleMotorData() {
    List<MotorStateData> data = [];
    DateTime now = DateTime.now();

    switch (_selectedPeriod) {
      case 'Today':
        for (int i = 0; i < 12; i++) {
          DateTime time = DateTime(now.year, now.month, now.day)
              .add(Duration(hours: i * 2));
          bool isOn = _getRandomMotorState(i);
          data.add(MotorStateData(time, isOn));
        }
        break;
      case 'Yesterday':
        DateTime yesterday = now.subtract(const Duration(days: 1));
        for (int i = 0; i < 12; i++) {
          DateTime time =
              DateTime(yesterday.year, yesterday.month, yesterday.day)
                  .add(Duration(hours: i * 2));
          bool isOn = _getRandomMotorState(i);
          data.add(MotorStateData(time, isOn));
        }
        break;
      case 'This Week':
        for (int i = 0; i < 7; i++) {
          DateTime day = now.subtract(Duration(days: now.weekday - 1 - i));
          bool isOn = _getRandomMotorState(i);
          data.add(MotorStateData(day, isOn));
        }
        break;
      case 'Last Week':
        for (int i = 0; i < 7; i++) {
          DateTime day = now.subtract(Duration(days: now.weekday + 6 - i));
          bool isOn = _getRandomMotorState(i);
          data.add(MotorStateData(day, isOn));
        }
        break;
    }

    return data;
  }
  bool _getRandomMotorState(int index) {
    List<bool> patterns = [
      false,
      true,
      true,
      false,
      true,
      false,
      true,
      false,
      true,
      true,
      false,
      false
    ];
    return patterns[index % patterns.length];
  }

  String getTimeFormat() {
    switch (_selectedPeriod) {
      case 'Today':
      case 'Yesterday':
        return 'HH:mm';
      case 'This Week':
      case 'Last Week':
        return 'EEE';
      default:
        return 'HH:mm';
    }
  }
}
class MotorStateData {
  final DateTime time;
  final bool isMotorOn;

  MotorStateData(this.time, this.isMotorOn);
  String getDisplayLabel(String period) {
    switch (period) {
      case 'Today':
      case 'Yesterday':
        return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
      case 'This Week':
      case 'Last Week':
        List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
        return days[time.weekday - 1];
      default:
        return '${time.hour}:${time.minute}';
    }
  }
}
