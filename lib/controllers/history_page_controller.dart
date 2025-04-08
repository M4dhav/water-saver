import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:water_saver/models/history_page_data.dart';

class HistoryPageController extends Notifier<HistoryPageData> {
  @override
  HistoryPageData build() {
    return HistoryPageData();
  }

  void updateSelectedDate(String date) {
    state = state.copyWith(selectedDate: date);
  }

  void toggleDropdown() {
    state = state.copyWith(isDropdownExpanded: !state.isDropdownExpanded);
  }

  void updateMonthDates() {
    state = state.copyWith(currentMonthDates: state.getCurrentMonthDates());
  }

  List<String> getCurrentWeekDates(List<String> allDates) {
    DateTime now = DateTime.now();
    int todayIndex = allDates.indexOf(
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}");

    int weekStart = (todayIndex ~/ 7) * 7;
    int weekEnd =
        (weekStart + 7 <= allDates.length) ? weekStart + 7 : allDates.length;

    return allDates.sublist(weekStart, weekEnd);
  }

  void previousMonth() {
    state = state.copyWith(
        currentMonth:
            DateTime(state.currentMonth.year, state.currentMonth.month - 1, 1));
    updateMonthDates();
  }

  void nextMonth() {
    state = state.copyWith(
        currentMonth:
            DateTime(state.currentMonth.year, state.currentMonth.month + 1, 1));
    updateMonthDates();
  }

  String getCurrentMonthYear() {
    return DateFormat("MMMM yyyy").format(state.currentMonth);
  }

  void addHistoryEntry(String date, Map<String, String> entry) {
    if (state.historyData[date] == null) {
      state = state.copyWith(historyData: {...state.historyData, date: []});
    }
    state = state.copyWith(historyData: {
      ...state.historyData,
      date: [...state.historyData[date] ?? [], entry]
    });
  }
}
