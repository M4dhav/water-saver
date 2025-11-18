// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../threshold_data_history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ThresholdDataHistory {
  @JsonKey(name: "RSV_th_dn_percent")
  String get rsvThDnPercent;
  @JsonKey(name: "RFT_th_dn_percent")
  String get rftThDnPercent;
  @JsonKey(name: "RFT_th_up_percent")
  String get rftThUpPercent;
  @JsonKey(
      name: "timestamp",
      fromJson: dateTimeFromEpochMs,
      toJson: dateTimeToEpochMs)
  DateTime get timestamp;

  /// Create a copy of ThresholdDataHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ThresholdDataHistoryCopyWith<ThresholdDataHistory> get copyWith =>
      _$ThresholdDataHistoryCopyWithImpl<ThresholdDataHistory>(
          this as ThresholdDataHistory, _$identity);

  /// Serializes this ThresholdDataHistory to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ThresholdDataHistory &&
            (identical(other.rsvThDnPercent, rsvThDnPercent) ||
                other.rsvThDnPercent == rsvThDnPercent) &&
            (identical(other.rftThDnPercent, rftThDnPercent) ||
                other.rftThDnPercent == rftThDnPercent) &&
            (identical(other.rftThUpPercent, rftThUpPercent) ||
                other.rftThUpPercent == rftThUpPercent) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, rsvThDnPercent, rftThDnPercent, rftThUpPercent, timestamp);

  @override
  String toString() {
    return 'ThresholdDataHistory(rsvThDnPercent: $rsvThDnPercent, rftThDnPercent: $rftThDnPercent, rftThUpPercent: $rftThUpPercent, timestamp: $timestamp)';
  }
}

/// @nodoc
abstract mixin class $ThresholdDataHistoryCopyWith<$Res> {
  factory $ThresholdDataHistoryCopyWith(ThresholdDataHistory value,
          $Res Function(ThresholdDataHistory) _then) =
      _$ThresholdDataHistoryCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "RSV_th_dn_percent") String rsvThDnPercent,
      @JsonKey(name: "RFT_th_dn_percent") String rftThDnPercent,
      @JsonKey(name: "RFT_th_up_percent") String rftThUpPercent,
      @JsonKey(
          name: "timestamp",
          fromJson: dateTimeFromEpochMs,
          toJson: dateTimeToEpochMs)
      DateTime timestamp});
}

/// @nodoc
class _$ThresholdDataHistoryCopyWithImpl<$Res>
    implements $ThresholdDataHistoryCopyWith<$Res> {
  _$ThresholdDataHistoryCopyWithImpl(this._self, this._then);

  final ThresholdDataHistory _self;
  final $Res Function(ThresholdDataHistory) _then;

  /// Create a copy of ThresholdDataHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rsvThDnPercent = null,
    Object? rftThDnPercent = null,
    Object? rftThUpPercent = null,
    Object? timestamp = null,
  }) {
    return _then(_self.copyWith(
      rsvThDnPercent: null == rsvThDnPercent
          ? _self.rsvThDnPercent
          : rsvThDnPercent // ignore: cast_nullable_to_non_nullable
              as String,
      rftThDnPercent: null == rftThDnPercent
          ? _self.rftThDnPercent
          : rftThDnPercent // ignore: cast_nullable_to_non_nullable
              as String,
      rftThUpPercent: null == rftThUpPercent
          ? _self.rftThUpPercent
          : rftThUpPercent // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [ThresholdDataHistory].
extension ThresholdDataHistoryPatterns on ThresholdDataHistory {
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
    TResult Function(_ThresholdDataHistory value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ThresholdDataHistory() when $default != null:
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
    TResult Function(_ThresholdDataHistory value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ThresholdDataHistory():
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
    TResult? Function(_ThresholdDataHistory value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ThresholdDataHistory() when $default != null:
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
            @JsonKey(name: "RSV_th_dn_percent") String rsvThDnPercent,
            @JsonKey(name: "RFT_th_dn_percent") String rftThDnPercent,
            @JsonKey(name: "RFT_th_up_percent") String rftThUpPercent,
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
      case _ThresholdDataHistory() when $default != null:
        return $default(_that.rsvThDnPercent, _that.rftThDnPercent,
            _that.rftThUpPercent, _that.timestamp);
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
            @JsonKey(name: "RSV_th_dn_percent") String rsvThDnPercent,
            @JsonKey(name: "RFT_th_dn_percent") String rftThDnPercent,
            @JsonKey(name: "RFT_th_up_percent") String rftThUpPercent,
            @JsonKey(
                name: "timestamp",
                fromJson: dateTimeFromEpochMs,
                toJson: dateTimeToEpochMs)
            DateTime timestamp)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ThresholdDataHistory():
        return $default(_that.rsvThDnPercent, _that.rftThDnPercent,
            _that.rftThUpPercent, _that.timestamp);
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
            @JsonKey(name: "RSV_th_dn_percent") String rsvThDnPercent,
            @JsonKey(name: "RFT_th_dn_percent") String rftThDnPercent,
            @JsonKey(name: "RFT_th_up_percent") String rftThUpPercent,
            @JsonKey(
                name: "timestamp",
                fromJson: dateTimeFromEpochMs,
                toJson: dateTimeToEpochMs)
            DateTime timestamp)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ThresholdDataHistory() when $default != null:
        return $default(_that.rsvThDnPercent, _that.rftThDnPercent,
            _that.rftThUpPercent, _that.timestamp);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ThresholdDataHistory implements ThresholdDataHistory {
  _ThresholdDataHistory(
      {@JsonKey(name: "RSV_th_dn_percent") required this.rsvThDnPercent,
      @JsonKey(name: "RFT_th_dn_percent") required this.rftThDnPercent,
      @JsonKey(name: "RFT_th_up_percent") required this.rftThUpPercent,
      @JsonKey(
          name: "timestamp",
          fromJson: dateTimeFromEpochMs,
          toJson: dateTimeToEpochMs)
      required this.timestamp});
  factory _ThresholdDataHistory.fromJson(Map<String, dynamic> json) =>
      _$ThresholdDataHistoryFromJson(json);

  @override
  @JsonKey(name: "RSV_th_dn_percent")
  final String rsvThDnPercent;
  @override
  @JsonKey(name: "RFT_th_dn_percent")
  final String rftThDnPercent;
  @override
  @JsonKey(name: "RFT_th_up_percent")
  final String rftThUpPercent;
  @override
  @JsonKey(
      name: "timestamp",
      fromJson: dateTimeFromEpochMs,
      toJson: dateTimeToEpochMs)
  final DateTime timestamp;

  /// Create a copy of ThresholdDataHistory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ThresholdDataHistoryCopyWith<_ThresholdDataHistory> get copyWith =>
      __$ThresholdDataHistoryCopyWithImpl<_ThresholdDataHistory>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ThresholdDataHistoryToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ThresholdDataHistory &&
            (identical(other.rsvThDnPercent, rsvThDnPercent) ||
                other.rsvThDnPercent == rsvThDnPercent) &&
            (identical(other.rftThDnPercent, rftThDnPercent) ||
                other.rftThDnPercent == rftThDnPercent) &&
            (identical(other.rftThUpPercent, rftThUpPercent) ||
                other.rftThUpPercent == rftThUpPercent) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, rsvThDnPercent, rftThDnPercent, rftThUpPercent, timestamp);

  @override
  String toString() {
    return 'ThresholdDataHistory(rsvThDnPercent: $rsvThDnPercent, rftThDnPercent: $rftThDnPercent, rftThUpPercent: $rftThUpPercent, timestamp: $timestamp)';
  }
}

/// @nodoc
abstract mixin class _$ThresholdDataHistoryCopyWith<$Res>
    implements $ThresholdDataHistoryCopyWith<$Res> {
  factory _$ThresholdDataHistoryCopyWith(_ThresholdDataHistory value,
          $Res Function(_ThresholdDataHistory) _then) =
      __$ThresholdDataHistoryCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "RSV_th_dn_percent") String rsvThDnPercent,
      @JsonKey(name: "RFT_th_dn_percent") String rftThDnPercent,
      @JsonKey(name: "RFT_th_up_percent") String rftThUpPercent,
      @JsonKey(
          name: "timestamp",
          fromJson: dateTimeFromEpochMs,
          toJson: dateTimeToEpochMs)
      DateTime timestamp});
}

/// @nodoc
class __$ThresholdDataHistoryCopyWithImpl<$Res>
    implements _$ThresholdDataHistoryCopyWith<$Res> {
  __$ThresholdDataHistoryCopyWithImpl(this._self, this._then);

  final _ThresholdDataHistory _self;
  final $Res Function(_ThresholdDataHistory) _then;

  /// Create a copy of ThresholdDataHistory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? rsvThDnPercent = null,
    Object? rftThDnPercent = null,
    Object? rftThUpPercent = null,
    Object? timestamp = null,
  }) {
    return _then(_ThresholdDataHistory(
      rsvThDnPercent: null == rsvThDnPercent
          ? _self.rsvThDnPercent
          : rsvThDnPercent // ignore: cast_nullable_to_non_nullable
              as String,
      rftThDnPercent: null == rftThDnPercent
          ? _self.rftThDnPercent
          : rftThDnPercent // ignore: cast_nullable_to_non_nullable
              as String,
      rftThUpPercent: null == rftThUpPercent
          ? _self.rftThUpPercent
          : rftThUpPercent // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
