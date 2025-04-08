import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HistoryPageController extends GetxController {
  var selectedDate = "2024-02-20".obs;
  var historyData = <String, List<Map<String, String>>>{}.obs;
  var totalLitersPerDate = <String, double>{}.obs;
  var isDropdownExpanded = false.obs;
  var currentMonthDates = <String>[].obs;
  var currentMonth = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
    fetchWaterHistory();
    calculateTotalLiters();
    updateMonthDates();
  }

  void fetchWaterHistory() {
    historyData.assignAll({
      "2024-02-16": [
        {"time": "8:00AM", "quantity": "550"},
        {"time": "1:00PM", "quantity": "100"},
      ],
      "2024-02-17": [
        {"time": "8:00AM", "quantity": "350"},
        {"time": "1:00PM", "quantity": "100"},
      ],
      "2024-02-18": [
        {"time": "8:00AM", "quantity": "650"},
        {"time": "1:00PM", "quantity": "700"},
      ],
      "2024-02-19": [
        {"time": "8:00AM", "quantity": "250"},
        {"time": "1:00PM", "quantity": "200"},
      ],
      "2024-02-20": [
        {"time": "10:00AM", "quantity": "300"},
        {"time": "3:00PM", "quantity": "150"},
        {"time": "6:00PM", "quantity": "400"},
      ],
    });
    calculateTotalLiters();
  }

  void calculateTotalLiters() {
    totalLitersPerDate.clear();
    historyData.forEach((date, records) {
      double totalLiters = records.fold(
          0, (sum, record) => sum + double.parse(record['quantity'] ?? "0"));
      totalLitersPerDate[date] = totalLiters;
    });
  }

  void updateSelectedDate(String date) {
    selectedDate.value = date;
  }

  void toggleDropdown() {
    isDropdownExpanded.value = !isDropdownExpanded.value;
  }

  void updateMonthDates() {
    currentMonthDates.value = getCurrentMonthDates();
  }

  List<String> getCurrentMonthDates() {
    DateTime now = currentMonth.value;
    int daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    return List.generate(daysInMonth, (index) {
      return "${now.year}-${now.month.toString().padLeft(2, '0')}-${(index + 1).toString().padLeft(2, '0')}";
    });
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
    currentMonth.value =
        DateTime(currentMonth.value.year, currentMonth.value.month - 1, 1);
    updateMonthDates();
  }

  void nextMonth() {
    currentMonth.value =
        DateTime(currentMonth.value.year, currentMonth.value.month + 1, 1);
    updateMonthDates();
  }

  String getCurrentMonthYear() {
    return DateFormat("MMMM yyyy").format(currentMonth.value);
  }

  void deleteHistoryEntry(String date, int index) {
    historyData[date]?.removeAt(index);
    if (historyData[date]?.isEmpty ?? true) {
      historyData.remove(date);
    }
    calculateTotalLiters();
  }

  void addHistoryEntry(String date, Map<String, String> entry) {
    if (historyData[date] == null) {
      historyData[date] = [];
    }
    historyData[date]?.add(entry);
    historyData.refresh();
  }
}
