class HomeHistoryController {
  List<Map<String, String>> waterHistory = [];

  void fetchWaterHistory() {
    //call idhar api
    waterHistory = [
      {"time": "8:00AM", "quantity": "300 L"},
      {"time": "1:00PM", "quantity": "300 L"},
    ];
  }
}
