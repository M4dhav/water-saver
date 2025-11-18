import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/threshold_data_history.freezed.dart';
part 'generated/threshold_data_history.g.dart';

DateTime dateTimeFromEpochMs(dynamic value) =>
    DateTime.fromMillisecondsSinceEpoch(value);

String dateTimeToEpochMs(DateTime date) =>
    date.millisecondsSinceEpoch.toString();

@freezed
abstract class ThresholdDataHistory with _$ThresholdDataHistory {
  factory ThresholdDataHistory({
    @JsonKey(name: "RSV_th_dn_percent") required String rsvThDnPercent,
    @JsonKey(name: "RFT_th_dn_percent") required String rftThDnPercent,
    @JsonKey(name: "RFT_th_up_percent") required String rftThUpPercent,
    @JsonKey(
        name: "timestamp",
        fromJson: dateTimeFromEpochMs,
        toJson: dateTimeToEpochMs)
    required DateTime timestamp,
  }) = _ThresholdDataHistory;

  factory ThresholdDataHistory.fromJson(Map<String, dynamic> json) =>
      _$ThresholdDataHistoryFromJson(json);
}
