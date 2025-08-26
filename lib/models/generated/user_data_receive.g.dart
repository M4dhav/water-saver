// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../user_data_receive.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserDataReceive _$UserDataReceiveFromJson(Map<String, dynamic> json) =>
    _UserDataReceive(
      autoToggleConsent: json['Auto_toggle_consent'] as bool,
      motorOn: json['MOTOR_ON'] as String,
      calibrationRepeat: json['Calibration_repeat'] as String,
      rftCalibChkInt: json['RFT_CALIB_CHK_INT'] as String,
      rftConnChkInt: json['RFT_CONN_CHK_INT'] as String,
      rftHeight: json['RFT_height'] as String,
      rftThDnPercent: json['RFT_th_dn_percent'] as String,
      rftThUpPercent: json['RFT_th_up_percent'] as String,
      rsvConnChkInt: json['RSV_CONN_CHK_INT'] as String,
      rsvHeight: json['RSV_height'] as String,
      rsvThDnPercent: json['RSV_th_dn_percent'] as String,
    );

Map<String, dynamic> _$UserDataReceiveToJson(_UserDataReceive instance) =>
    <String, dynamic>{
      'Auto_toggle_consent': instance.autoToggleConsent,
      'MOTOR_ON': instance.motorOn,
      'Calibration_repeat': instance.calibrationRepeat,
      'RFT_CALIB_CHK_INT': instance.rftCalibChkInt,
      'RFT_CONN_CHK_INT': instance.rftConnChkInt,
      'RFT_height': instance.rftHeight,
      'RFT_th_dn_percent': instance.rftThDnPercent,
      'RFT_th_up_percent': instance.rftThUpPercent,
      'RSV_CONN_CHK_INT': instance.rsvConnChkInt,
      'RSV_height': instance.rsvHeight,
      'RSV_th_dn_percent': instance.rsvThDnPercent,
    };
