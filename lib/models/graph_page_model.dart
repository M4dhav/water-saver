import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:water_saver/models/level_data_history.dart';
import 'package:water_saver/models/motor_state_data.dart';
import 'package:water_saver/models/threshold_data_history.dart';

part 'generated/graph_page_model.freezed.dart';

enum SelectedPeriod {
  week('Past Week'),
  fifteenDays('Past 15 Days'),
  month('Past Month');

  final String label;
  const SelectedPeriod(this.label);
}

@freezed
abstract class GraphPageModel with _$GraphPageModel {
  factory GraphPageModel({
    required List<MotorStateData> motorStateData,
    required List<MotorStateData> motorStateDataOn,
    required List<MotorStateData> motorStateDataOff,
    required List<LevelDataHistory> rftLevelData,
    required List<LevelDataHistory> rsvLevelData,
    required List<ThresholdDataHistory> thresholdDataHistory,
    @Default(SelectedPeriod.week) SelectedPeriod selectedPeriod,
  }) = _GraphPageModel;
}
