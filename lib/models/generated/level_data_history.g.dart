// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../level_data_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LevelDataHistory _$LevelDataHistoryFromJson(Map<String, dynamic> json) =>
    _LevelDataHistory(
      average: (json['average'] as num).toDouble(),
      levelData: (json['levelData'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      timestamp: dateTimeFromEpochMs(json['timestamp']),
    );

Map<String, dynamic> _$LevelDataHistoryToJson(_LevelDataHistory instance) =>
    <String, dynamic>{
      'average': instance.average,
      'levelData': instance.levelData,
      'timestamp': dateTimeToEpochMs(instance.timestamp),
    };
