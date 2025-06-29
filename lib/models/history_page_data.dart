class HistoryPageData {
  String selectedDate = DateTime.now().toIso8601String().substring(0, 10);
  Map<String, List<Map<String, String>>> historyData = {};
  Map<String, double> totalLitersPerDate = {};
  bool isDropdownExpanded = false;
  List<String> currentMonthDates = [];
  DateTime currentMonth = DateTime.now();

  HistoryPageData({
    String? selectedDate,
    Map<String, List<Map<String, String>>>? historyData,
    Map<String, double>? totalLitersPerDate,
    this.isDropdownExpanded = false,
    List<String>? currentMonthDates,
    DateTime? currentMonth,
  })  : selectedDate =
            selectedDate ?? DateTime.now().toIso8601String().substring(0, 10),
        historyData = historyData ?? {},
        totalLitersPerDate = totalLitersPerDate ?? {},
        currentMonthDates = currentMonthDates ?? [],
        currentMonth = currentMonth ?? DateTime.now() {
    fetchWaterHistory();
    calculateTotalLiters();
    updateMonthDates();
  }

  void fetchWaterHistory() {
    historyData = ({
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

  void updateMonthDates() {
    currentMonthDates = getCurrentMonthDates();
  }

  HistoryPageData copyWith({
    String? selectedDate,
    Map<String, List<Map<String, String>>>? historyData,
    Map<String, double>? totalLitersPerDate,
    bool? isDropdownExpanded,
    List<String>? currentMonthDates,
    DateTime? currentMonth,
  }) {
    return HistoryPageData(
      selectedDate: selectedDate ?? this.selectedDate,
      historyData: historyData ?? this.historyData,
      totalLitersPerDate: totalLitersPerDate ?? this.totalLitersPerDate,
      isDropdownExpanded: isDropdownExpanded ?? this.isDropdownExpanded,
      currentMonthDates: currentMonthDates ?? this.currentMonthDates,
      currentMonth: currentMonth ?? this.currentMonth,
    );
  }

  List<String> getCurrentMonthDates() {
    DateTime now = currentMonth;
    int daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    return List.generate(daysInMonth, (index) {
      return "${now.year}-${now.month.toString().padLeft(2, '0')}-${(index + 1).toString().padLeft(2, '0')}";
    });
  }
}
