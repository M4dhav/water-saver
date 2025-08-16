import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/user_data_upload.freezed.dart';
part 'generated/user_data_upload.g.dart';

enum MotorState { manual, auto }

@freezed
abstract class UserDataUpload with _$UserDataUpload {
  const factory UserDataUpload(
    @JsonKey(name: 'ACPowerFail') String acPowerFail,
    @JsonKey(name: 'ACPowerFailDuration') int acPowerFailDuration,
    @JsonKey(name: 'CalibDuration') int calibDuration,
    @JsonKey(name: 'MotorOff') String motorOff,
    @JsonKey(name: 'MotorOn') String motorOn,
    @JsonKey(name: 'MotorOnDuration') int motorOnDuration,
    @JsonKey(name: 'RFT_sens_connect') String rftSensConnect,
    @JsonKey(name: 'RSV_sens_connect') String rsvSensConnect,
    @JsonKey(name: 'RSVEmpty') String rsvEmpty,
    @JsonKey(name: "RSV_level_change_at_calib") int rsvLevelChangeAtCalib,
    @JsonKey(name: "RFT_level_data") List<int> rftLevelData,
    @JsonKey(name: "RSV_level_data") List<int> rsvLevelData,
    @JsonKey(name: 'avg_calib') int avgCalib,
    @JsonKey(name: 'calib_t0') int calibT0,
    @JsonKey(name: 'calib_t1') int calibT1,
    @JsonKey(name: 'calib_t2') int calibT2,
  ) = _UserDataUpload;

  factory UserDataUpload.fromJson(Map<String, dynamic> json) =>
      _$UserDataUploadFromJson(json);

  const UserDataUpload._();

  Map<String, dynamic> returnMotorState({MotorState source = MotorState.auto}) {
    return {
      'time': DateTime.now().millisecondsSinceEpoch,
      'motorOn': motorOn,
      'motorOff': motorOff,
      'source': source == MotorState.manual ? 'manual' : 'auto',
    };
  }
}
