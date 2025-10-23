// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../level_data_history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LevelDataHistory {
  double get average;
  List<int> get levelData;
  @JsonKey(
      name: "timestamp",
      fromJson: dateTimeFromEpochMs,
      toJson: dateTimeToEpochMs)
  DateTime get timestamp;

  /// Create a copy of LevelDataHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LevelDataHistoryCopyWith<LevelDataHistory> get copyWith =>
      _$LevelDataHistoryCopyWithImpl<LevelDataHistory>(
          this as LevelDataHistory, _$identity);

  /// Serializes this LevelDataHistory to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LevelDataHistory &&
            (identical(other.average, average) || other.average == average) &&
            const DeepCollectionEquality().equals(other.levelData, levelData) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, average,
      const DeepCollectionEquality().hash(levelData), timestamp);

  @override
  String toString() {
    return 'LevelDataHistory(average: $average, levelData: $levelData, timestamp: $timestamp)';
  }
}

/// @nodoc
abstract mixin class $LevelDataHistoryCopyWith<$Res> {
  factory $LevelDataHistoryCopyWith(
          LevelDataHistory value, $Res Function(LevelDataHistory) _then) =
      _$LevelDataHistoryCopyWithImpl;
  @useResult
  $Res call(
      {double average,
      List<int> levelData,
      @JsonKey(
          name: "timestamp",
          fromJson: dateTimeFromEpochMs,
          toJson: dateTimeToEpochMs)
      DateTime timestamp});
}

/// @nodoc
class _$LevelDataHistoryCopyWithImpl<$Res>
    implements $LevelDataHistoryCopyWith<$Res> {
  _$LevelDataHistoryCopyWithImpl(this._self, this._then);

  final LevelDataHistory _self;
  final $Res Function(LevelDataHistory) _then;

  /// Create a copy of LevelDataHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? average = null,
    Object? levelData = null,
    Object? timestamp = null,
  }) {
    return _then(_self.copyWith(
      average: null == average
          ? _self.average
          : average // ignore: cast_nullable_to_non_nullable
              as double,
      levelData: null == levelData
          ? _self.levelData
          : levelData // ignore: cast_nullable_to_non_nullable
              as List<int>,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [LevelDataHistory].
extension LevelDataHistoryPatterns on LevelDataHistory {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_LevelDataHistory value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LevelDataHistory() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_LevelDataHistory value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LevelDataHistory():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_LevelDataHistory value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LevelDataHistory() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            double average,
            List<int> levelData,
            @JsonKey(
                name: "timestamp",
                fromJson: dateTimeFromEpochMs,
                toJson: dateTimeToEpochMs)
            DateTime timestamp)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LevelDataHistory() when $default != null:
        return $default(_that.average, _that.levelData, _that.timestamp);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            double average,
            List<int> levelData,
            @JsonKey(
                name: "timestamp",
                fromJson: dateTimeFromEpochMs,
                toJson: dateTimeToEpochMs)
            DateTime timestamp)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LevelDataHistory():
        return $default(_that.average, _that.levelData, _that.timestamp);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            double average,
            List<int> levelData,
            @JsonKey(
                name: "timestamp",
                fromJson: dateTimeFromEpochMs,
                toJson: dateTimeToEpochMs)
            DateTime timestamp)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LevelDataHistory() when $default != null:
        return $default(_that.average, _that.levelData, _that.timestamp);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _LevelDataHistory implements LevelDataHistory {
  _LevelDataHistory(
      {required this.average,
      required final List<int> levelData,
      @JsonKey(
          name: "timestamp",
          fromJson: dateTimeFromEpochMs,
          toJson: dateTimeToEpochMs)
      required this.timestamp})
      : _levelData = levelData;
  factory _LevelDataHistory.fromJson(Map<String, dynamic> json) =>
      _$LevelDataHistoryFromJson(json);

  @override
  final double average;
  final List<int> _levelData;
  @override
  List<int> get levelData {
    if (_levelData is EqualUnmodifiableListView) return _levelData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_levelData);
  }

  @override
  @JsonKey(
      name: "timestamp",
      fromJson: dateTimeFromEpochMs,
      toJson: dateTimeToEpochMs)
  final DateTime timestamp;

  /// Create a copy of LevelDataHistory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LevelDataHistoryCopyWith<_LevelDataHistory> get copyWith =>
      __$LevelDataHistoryCopyWithImpl<_LevelDataHistory>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LevelDataHistoryToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LevelDataHistory &&
            (identical(other.average, average) || other.average == average) &&
            const DeepCollectionEquality()
                .equals(other._levelData, _levelData) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, average,
      const DeepCollectionEquality().hash(_levelData), timestamp);

  @override
  String toString() {
    return 'LevelDataHistory(average: $average, levelData: $levelData, timestamp: $timestamp)';
  }
}

/// @nodoc
abstract mixin class _$LevelDataHistoryCopyWith<$Res>
    implements $LevelDataHistoryCopyWith<$Res> {
  factory _$LevelDataHistoryCopyWith(
          _LevelDataHistory value, $Res Function(_LevelDataHistory) _then) =
      __$LevelDataHistoryCopyWithImpl;
  @override
  @useResult
  $Res call(
      {double average,
      List<int> levelData,
      @JsonKey(
          name: "timestamp",
          fromJson: dateTimeFromEpochMs,
          toJson: dateTimeToEpochMs)
      DateTime timestamp});
}

/// @nodoc
class __$LevelDataHistoryCopyWithImpl<$Res>
    implements _$LevelDataHistoryCopyWith<$Res> {
  __$LevelDataHistoryCopyWithImpl(this._self, this._then);

  final _LevelDataHistory _self;
  final $Res Function(_LevelDataHistory) _then;

  /// Create a copy of LevelDataHistory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? average = null,
    Object? levelData = null,
    Object? timestamp = null,
  }) {
    return _then(_LevelDataHistory(
      average: null == average
          ? _self.average
          : average // ignore: cast_nullable_to_non_nullable
              as double,
      levelData: null == levelData
          ? _self._levelData
          : levelData // ignore: cast_nullable_to_non_nullable
              as List<int>,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
