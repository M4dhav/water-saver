// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../motor_state_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MotorStateData {
  @JsonKey(
      name: "time", fromJson: dateTimeFromEpochMs, toJson: dateTimeToEpochMs)
  DateTime get time;
  @JsonKey(name: "motorOn")
  String get motorOn;
  @JsonKey(name: "motorOff")
  String get motorOff;

  /// Create a copy of MotorStateData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MotorStateDataCopyWith<MotorStateData> get copyWith =>
      _$MotorStateDataCopyWithImpl<MotorStateData>(
          this as MotorStateData, _$identity);

  /// Serializes this MotorStateData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MotorStateData &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.motorOn, motorOn) || other.motorOn == motorOn) &&
            (identical(other.motorOff, motorOff) ||
                other.motorOff == motorOff));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, time, motorOn, motorOff);

  @override
  String toString() {
    return 'MotorStateData(time: $time, motorOn: $motorOn, motorOff: $motorOff)';
  }
}

/// @nodoc
abstract mixin class $MotorStateDataCopyWith<$Res> {
  factory $MotorStateDataCopyWith(
          MotorStateData value, $Res Function(MotorStateData) _then) =
      _$MotorStateDataCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(
          name: "time",
          fromJson: dateTimeFromEpochMs,
          toJson: dateTimeToEpochMs)
      DateTime time,
      @JsonKey(name: "motorOn") String motorOn,
      @JsonKey(name: "motorOff") String motorOff});
}

/// @nodoc
class _$MotorStateDataCopyWithImpl<$Res>
    implements $MotorStateDataCopyWith<$Res> {
  _$MotorStateDataCopyWithImpl(this._self, this._then);

  final MotorStateData _self;
  final $Res Function(MotorStateData) _then;

  /// Create a copy of MotorStateData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? motorOn = null,
    Object? motorOff = null,
  }) {
    return _then(_self.copyWith(
      time: null == time
          ? _self.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      motorOn: null == motorOn
          ? _self.motorOn
          : motorOn // ignore: cast_nullable_to_non_nullable
              as String,
      motorOff: null == motorOff
          ? _self.motorOff
          : motorOff // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [MotorStateData].
extension MotorStateDataPatterns on MotorStateData {
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
    TResult Function(_MotorStateData value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MotorStateData() when $default != null:
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
    TResult Function(_MotorStateData value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MotorStateData():
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
    TResult? Function(_MotorStateData value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MotorStateData() when $default != null:
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
            @JsonKey(
                name: "time",
                fromJson: dateTimeFromEpochMs,
                toJson: dateTimeToEpochMs)
            DateTime time,
            @JsonKey(name: "motorOn") String motorOn,
            @JsonKey(name: "motorOff") String motorOff)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MotorStateData() when $default != null:
        return $default(_that.time, _that.motorOn, _that.motorOff);
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
            @JsonKey(
                name: "time",
                fromJson: dateTimeFromEpochMs,
                toJson: dateTimeToEpochMs)
            DateTime time,
            @JsonKey(name: "motorOn") String motorOn,
            @JsonKey(name: "motorOff") String motorOff)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MotorStateData():
        return $default(_that.time, _that.motorOn, _that.motorOff);
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
            @JsonKey(
                name: "time",
                fromJson: dateTimeFromEpochMs,
                toJson: dateTimeToEpochMs)
            DateTime time,
            @JsonKey(name: "motorOn") String motorOn,
            @JsonKey(name: "motorOff") String motorOff)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MotorStateData() when $default != null:
        return $default(_that.time, _that.motorOn, _that.motorOff);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MotorStateData implements MotorStateData {
  _MotorStateData(
      {@JsonKey(
          name: "time",
          fromJson: dateTimeFromEpochMs,
          toJson: dateTimeToEpochMs)
      required this.time,
      @JsonKey(name: "motorOn") required this.motorOn,
      @JsonKey(name: "motorOff") required this.motorOff});
  factory _MotorStateData.fromJson(Map<String, dynamic> json) =>
      _$MotorStateDataFromJson(json);

  @override
  @JsonKey(
      name: "time", fromJson: dateTimeFromEpochMs, toJson: dateTimeToEpochMs)
  final DateTime time;
  @override
  @JsonKey(name: "motorOn")
  final String motorOn;
  @override
  @JsonKey(name: "motorOff")
  final String motorOff;

  /// Create a copy of MotorStateData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MotorStateDataCopyWith<_MotorStateData> get copyWith =>
      __$MotorStateDataCopyWithImpl<_MotorStateData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MotorStateDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MotorStateData &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.motorOn, motorOn) || other.motorOn == motorOn) &&
            (identical(other.motorOff, motorOff) ||
                other.motorOff == motorOff));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, time, motorOn, motorOff);

  @override
  String toString() {
    return 'MotorStateData(time: $time, motorOn: $motorOn, motorOff: $motorOff)';
  }
}

/// @nodoc
abstract mixin class _$MotorStateDataCopyWith<$Res>
    implements $MotorStateDataCopyWith<$Res> {
  factory _$MotorStateDataCopyWith(
          _MotorStateData value, $Res Function(_MotorStateData) _then) =
      __$MotorStateDataCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(
          name: "time",
          fromJson: dateTimeFromEpochMs,
          toJson: dateTimeToEpochMs)
      DateTime time,
      @JsonKey(name: "motorOn") String motorOn,
      @JsonKey(name: "motorOff") String motorOff});
}

/// @nodoc
class __$MotorStateDataCopyWithImpl<$Res>
    implements _$MotorStateDataCopyWith<$Res> {
  __$MotorStateDataCopyWithImpl(this._self, this._then);

  final _MotorStateData _self;
  final $Res Function(_MotorStateData) _then;

  /// Create a copy of MotorStateData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? time = null,
    Object? motorOn = null,
    Object? motorOff = null,
  }) {
    return _then(_MotorStateData(
      time: null == time
          ? _self.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      motorOn: null == motorOn
          ? _self.motorOn
          : motorOn // ignore: cast_nullable_to_non_nullable
              as String,
      motorOff: null == motorOff
          ? _self.motorOff
          : motorOff // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
