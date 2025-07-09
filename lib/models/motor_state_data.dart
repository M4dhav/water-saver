import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/motor_state_data.freezed.dart';
part 'generated/motor_state_data.g.dart';

DateTime dateTimeFromEpochMs(dynamic value) =>
    DateTime.fromMillisecondsSinceEpoch(value);

String dateTimeToEpochMs(DateTime date) =>
    date.millisecondsSinceEpoch.toString();

@freezed
abstract class MotorStateData with _$MotorStateData {
  factory MotorStateData({
    @JsonKey(
        name: "time", fromJson: dateTimeFromEpochMs, toJson: dateTimeToEpochMs)
    required DateTime time,
    @JsonKey(name: "motorOn") required String motorOn,
    @JsonKey(name: "motorOff") required String motorOff,
  }) = _MotorStateData;

  factory MotorStateData.fromJson(Map<String, dynamic> json) =>
      _$MotorStateDataFromJson(json);
}
