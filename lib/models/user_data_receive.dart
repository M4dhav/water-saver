import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/user_data_receive.freezed.dart';
part 'generated/user_data_receive.g.dart';

@freezed
abstract class UserDataReceive with _$UserDataReceive {
  factory UserDataReceive({
    @JsonKey(name: 'Auto_toggle_consent') required bool autoToggleConsent,
    @JsonKey(name: 'MOTOR_ON') required String motorOn,
    @JsonKey(name: 'Calibration_repeat') required String calibrationRepeat,
    @JsonKey(name: "RFT_CALIB_CHK_INT") required String rftCalibChkInt,
    @JsonKey(name: "RFT_CONN_CHK_INT") required String rftConnChkInt,
    @JsonKey(name: "RFT_height") required String rftHeight,
    @JsonKey(name: "RFT_th_dn_percent") required String rftThDnPercent,
    @JsonKey(name: "RFT_th_up_percent") required String rftThUpPercent,
    @JsonKey(name: "RSV_CONN_CHK_INT") required String rsvConnChkInt,
    @JsonKey(name: "RSV_height") required String rsvHeight,
    @JsonKey(name: "RSV_th_dn_percent") required String rsvThDnPercent,
  }) = _UserDataReceive;

  factory UserDataReceive.fromJson(Map<String, dynamic> json) =>
      _$UserDataReceiveFromJson(json);
}
