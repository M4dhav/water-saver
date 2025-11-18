// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../threshold_data_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ThresholdDataHistory _$ThresholdDataHistoryFromJson(
        Map<String, dynamic> json) =>
    _ThresholdDataHistory(
      rsvThDnPercent: json['RSV_th_dn_percent'] as String,
      rftThDnPercent: json['RFT_th_dn_percent'] as String,
      rftThUpPercent: json['RFT_th_up_percent'] as String,
      timestamp: dateTimeFromEpochMs(json['timestamp']),
    );

Map<String, dynamic> _$ThresholdDataHistoryToJson(
        _ThresholdDataHistory instance) =>
    <String, dynamic>{
      'RSV_th_dn_percent': instance.rsvThDnPercent,
      'RFT_th_dn_percent': instance.rftThDnPercent,
      'RFT_th_up_percent': instance.rftThUpPercent,
      'timestamp': dateTimeToEpochMs(instance.timestamp),
    };
