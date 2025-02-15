import 'package:flutter/material.dart';

class HistoryController extends ChangeNotifier {
  List<String> _history = ['8:00AM 300L', '1:00PM 300L'];

  List<String> get history => _history;

  void addHistory(String entry) {
    _history.add(entry);
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
