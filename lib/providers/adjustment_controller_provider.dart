import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:water_saver/controller/adjustment_controller.dart';
import 'package:water_saver/models/adjustments_page_data.dart';

final adjustmentControllerProvider =
    NotifierProvider<AdjustmentController, AdjustmentsPageData>(() {
  return AdjustmentController();
});
