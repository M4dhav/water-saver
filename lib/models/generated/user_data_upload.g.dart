// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../user_data_upload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserDataUpload _$UserDataUploadFromJson(Map<String, dynamic> json) =>
    _UserDataUpload(
      json['ACPowerFail'] as String,
      (json['ACPowerFailDuration'] as num).toInt(),
      (json['CalibDuration'] as num).toInt(),
      json['MotorOff'] as String,
      json['MotorOn'] as String,
      (json['MotorOnDuration'] as num).toInt(),
      json['RFT_sens_connect'] as String,
      json['RSV_sens_connect'] as String,
      json['RSVEmpty'] as String,
      (json['RSV_level_change_at_calib'] as num).toInt(),
      (json['RFT_level_data'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      (json['RSV_level_data'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      (json['avg_calib'] as num).toInt(),
      (json['calib_t0'] as num).toInt(),
      (json['calib_t1'] as num).toInt(),
      (json['calib_t2'] as num).toInt(),
    );

Map<String, dynamic> _$UserDataUploadToJson(_UserDataUpload instance) =>
    <String, dynamic>{
      'ACPowerFail': instance.acPowerFail,
      'ACPowerFailDuration': instance.acPowerFailDuration,
      'CalibDuration': instance.calibDuration,
      'MotorOff': instance.motorOff,
      'MotorOn': instance.motorOn,
      'MotorOnDuration': instance.motorOnDuration,
      'RFT_sens_connect': instance.rftSensConnect,
      'RSV_sens_connect': instance.rsvSensConnect,
      'RSVEmpty': instance.rsvEmpty,
      'RSV_level_change_at_calib': instance.rsvLevelChangeAtCalib,
      'RFT_level_data': instance.rftLevelData,
      'RSV_level_data': instance.rsvLevelData,
      'avg_calib': instance.avgCalib,
      'calib_t0': instance.calibT0,
      'calib_t1': instance.calibT1,
      'calib_t2': instance.calibT2,
    };
