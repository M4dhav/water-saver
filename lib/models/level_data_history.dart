import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/level_data_history.freezed.dart';
part 'generated/level_data_history.g.dart';

DateTime dateTimeFromEpochMs(dynamic value) =>
    DateTime.fromMillisecondsSinceEpoch(value);

String dateTimeToEpochMs(DateTime date) =>
    date.millisecondsSinceEpoch.toString();

@freezed
abstract class LevelDataHistory with _$LevelDataHistory {
  factory LevelDataHistory({
    required double average,
    required List<int> levelData,
    @JsonKey(
        name: "timestamp",
        fromJson: dateTimeFromEpochMs,
        toJson: dateTimeToEpochMs)
    required DateTime timestamp,
  }) = _LevelDataHistory;

  factory LevelDataHistory.fromJson(Map<String, dynamic> json) =>
      _$LevelDataHistoryFromJson(json);
}
