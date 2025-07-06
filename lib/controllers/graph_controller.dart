import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class GraphController extends ChangeNotifier {
  List<MotorStateData> _motorStateData = [];
  bool _isLoading = false;
  String _selectedPeriod = 'Today';
  List<MotorStateData> get motorStateData => _motorStateData;
  bool get isLoading => _isLoading;
  String get selectedPeriod => _selectedPeriod;
  final List<String> availablePeriods = [
    'Today',
    'Week',
    '15days',
    'This Month'
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
      case 'Week':
        for (int i = 0; i < 7; i++) {
          DateTime day = now.subtract(Duration(days: now.weekday - 1 - i));
          bool isOn = _getRandomMotorState(i);
          data.add(MotorStateData(day, isOn));
        }
        break;
      case '15days':
        for (int i = 0; i < 15; i++) {
          DateTime day = now.subtract(Duration(days: i));
          bool isOn = _getRandomMotorState(i);
          data.add(MotorStateData(day, isOn));
        }
        break;
      case 'This Month':
        int daysInMonth = DateTime(now.year, now.month + 1, 0).day;
        for (int i = 1; i <= daysInMonth; i++) {
          DateTime day = DateTime(now.year, now.month, i);
          bool isOn = _getRandomMotorState(i);
          data.add(MotorStateData(day, isOn));
        }
        break;
    }

    return data;
  }

  //generates a random static motor state.
  //remove after firebase logic is implemented
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
        return 'HH:mm';
      case 'Week':
        return 'EEE';
      case '15days':
        return 'dd/MM';
      case 'This Month':
        return 'dd';
      default:
        return 'HH:mm';
    }
  }

  //get these from firebase
  //filter by date range based on _selectedPeriod
  List<FlSpot> getMotorOnSpots() {
    switch (_selectedPeriod) {
      case 'Today':
        return [
          FlSpot(1, 8), FlSpot(2, 10), FlSpot(3, 13), FlSpot(4, 15),
          FlSpot(5, 18),
          FlSpot(6, 20), 
        ];
      case 'Week':
        return [
          FlSpot(1, 13),
          FlSpot(2, 14),
          FlSpot(3, 12),
          FlSpot(4, 15),
          FlSpot(5, 13),
          FlSpot(6, 11),
          FlSpot(7, 16),
        ];
      case '15days':
        return List.generate(
            15,
            (index) =>
                FlSpot((index + 1).toDouble(), 12 + (index % 8).toDouble()));
      case 'This Month':
        return List.generate(
            30,
            (index) =>
                FlSpot((index + 1).toDouble(), 11 + (index % 10).toDouble()));
      default:
        return [FlSpot(1, 13)];
    }
  }

  //add the firebase logic here
  //filter by date range based on _selectedPeriod
  List<FlSpot> getMotorOffSpots() {
    switch (_selectedPeriod) {
      case 'Today':
        return [
          FlSpot(1, 8.5),
          FlSpot(2, 10.75),
          FlSpot(3, 13.5),
          FlSpot(4, 15.33),
          FlSpot(5, 18.25),
          FlSpot(6, 20.5),
        ];
      case 'Week':
        return [
          FlSpot(1, 13.5),
          FlSpot(2, 14.5),
          FlSpot(3, 12.75),
          FlSpot(4, 15.25),
          FlSpot(5, 13.55),
          FlSpot(6, 11.5),
          FlSpot(7, 16.55),
        ];
      case '15days':
        return List.generate(
            15,
            (index) =>
                FlSpot((index + 1).toDouble(), 12.5 + (index % 8).toDouble()));
      case 'This Month':
        return List.generate(
            30,
            (index) =>
                FlSpot((index + 1).toDouble(), 11.5 + (index % 10).toDouble()));
      default:
        return [FlSpot(1, 13.5)];
    }
  }

  String getTooltipTimeInfo(double x, double y) {
    switch (_selectedPeriod) {
      case 'Today':
        List<String> times = ['8AM', '10AM', '1PM', '3PM', '6PM', '8PM'];
        int index = (x.toInt() - 1).clamp(0, times.length - 1); //implemented clamping to keep the value in bounds
        final hour = y.floor();
        final minutes = ((y - hour) * 60).round();
        final time =
            '${hour.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
        return '${times[index]} at $time';
      case 'Week':
        final day = _getDayLabel(x);
        final hour = y.floor();
        final minutes = ((y - hour) * 60).round();
        final time =
            '${hour.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
        return '$day at $time';
      case '15days':
        final hour = y.floor();
        final minutes = ((y - hour) * 60).round();
        final time =
            '${hour.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
        return 'Day ${x.toInt()} at $time';
      case 'This Month':
        final hour = y.floor();
        final minutes = ((y - hour) * 60).round();
        final time =
            '${hour.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
        return 'Day ${x.toInt()} at $time';
      default:
        return 'Unknown time';
    }
  }
  
  String _getDayLabel(double x) {
    List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    int dayIndex = (x.toInt() - 1).clamp(0, 6);
    return days[dayIndex];
  }
}

class MotorStateData {
  final DateTime time;
  final bool isMotorOn;

  MotorStateData(this.time, this.isMotorOn);
  String getDisplayLabel(String period) {
    switch (period) {
      case 'Today':
        return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
      case 'Week':
        List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
        return days[time.weekday - 1];
      case '15days':
        return '${time.day.toString().padLeft(2, '0')}/${time.month.toString().padLeft(2, '0')}';
      case 'This Month':
        return time.day.toString();
      default:
        return '${time.hour}:${time.minute}';
    }
  }
}
