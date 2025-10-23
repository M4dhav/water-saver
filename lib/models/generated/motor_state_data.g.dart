// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../motor_state_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MotorStateData _$MotorStateDataFromJson(Map<String, dynamic> json) =>
    _MotorStateData(
      time: dateTimeFromEpochMs(json['time']),
      motorOn: json['motorOn'] as String,
      motorOff: json['motorOff'] as String,
      source: json['source'] as String,
    );

Map<String, dynamic> _$MotorStateDataToJson(_MotorStateData instance) =>
    <String, dynamic>{
      'time': dateTimeToEpochMs(instance.time),
      'motorOn': instance.motorOn,
      'motorOff': instance.motorOff,
      'source': instance.source,
    };
