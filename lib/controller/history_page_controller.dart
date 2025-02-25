import 'package:get/get.dart';

class HistoryPageController extends GetxController {
  var selectedDate = "2024-02-20".obs;
  var historyData = <String, List<Map<String, String>>>{}.obs;
  var totalLitersPerDate =
      <String, double>{}.obs; // Stores total refilled liters per date

  @override
  void onInit() {
    super.onInit();
    fetchWaterHistory();
    calculateTotalLiters(); // Compute total liters per date
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
      "2024-02-21": [
        {"time": "7:00AM", "quantity": "350"},
        {"time": "12:00PM", "quantity": "500"},
        {"time": "5:00PM", "quantity": "200"},
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
    if (historyData.containsKey(date)) {
      selectedDate.value = date;
    }
  }
}
