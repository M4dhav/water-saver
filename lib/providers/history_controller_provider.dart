import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:water_saver/controllers/history_page_controller.dart';
import 'package:water_saver/models/history_page_data.dart';

final historyPageControllerProvider =
    NotifierProvider<HistoryPageController, HistoryPageData>(() {
  return HistoryPageController();
});
