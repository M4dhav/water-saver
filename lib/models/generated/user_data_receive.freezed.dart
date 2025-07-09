// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../user_data_receive.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserDataReceive {
  @JsonKey(name: 'CALIB_DONE')
  String get calibDone;
  @JsonKey(name: 'Calibration_repeat')
  String get calibrationRepeat;
  @JsonKey(name: "RFT_CALIB_CHK_INT")
  String get rftCalibChkInt;
  @JsonKey(name: "RFT_CONN_CHK_INT")
  String get rftConnChkInt;
  @JsonKey(name: "RFT_height")
  String get rftHeight;
  @JsonKey(name: "RFT_th_dn_percent")
  String get rftThDnPercent;
  @JsonKey(name: "RFT_th_up_percent")
  String get rftThUpPercent;
  @JsonKey(name: "RSV_CONN_CHK_INT")
  String get rsvConnChkInt;
  @JsonKey(name: "RSV_height")
  String get rsvHeight;
  @JsonKey(name: "RSV_th_dn_percent")
  String get rsvThDnPercent;

  /// Create a copy of UserDataReceive
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserDataReceiveCopyWith<UserDataReceive> get copyWith =>
      _$UserDataReceiveCopyWithImpl<UserDataReceive>(
          this as UserDataReceive, _$identity);

  /// Serializes this UserDataReceive to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UserDataReceive &&
            (identical(other.calibDone, calibDone) ||
                other.calibDone == calibDone) &&
            (identical(other.calibrationRepeat, calibrationRepeat) ||
                other.calibrationRepeat == calibrationRepeat) &&
            (identical(other.rftCalibChkInt, rftCalibChkInt) ||
                other.rftCalibChkInt == rftCalibChkInt) &&
            (identical(other.rftConnChkInt, rftConnChkInt) ||
                other.rftConnChkInt == rftConnChkInt) &&
            (identical(other.rftHeight, rftHeight) ||
                other.rftHeight == rftHeight) &&
            (identical(other.rftThDnPercent, rftThDnPercent) ||
                other.rftThDnPercent == rftThDnPercent) &&
            (identical(other.rftThUpPercent, rftThUpPercent) ||
                other.rftThUpPercent == rftThUpPercent) &&
            (identical(other.rsvConnChkInt, rsvConnChkInt) ||
                other.rsvConnChkInt == rsvConnChkInt) &&
            (identical(other.rsvHeight, rsvHeight) ||
                other.rsvHeight == rsvHeight) &&
            (identical(other.rsvThDnPercent, rsvThDnPercent) ||
                other.rsvThDnPercent == rsvThDnPercent));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      calibDone,
      calibrationRepeat,
      rftCalibChkInt,
      rftConnChkInt,
      rftHeight,
      rftThDnPercent,
      rftThUpPercent,
      rsvConnChkInt,
      rsvHeight,
      rsvThDnPercent);

  @override
  String toString() {
    return 'UserDataReceive(calibDone: $calibDone, calibrationRepeat: $calibrationRepeat, rftCalibChkInt: $rftCalibChkInt, rftConnChkInt: $rftConnChkInt, rftHeight: $rftHeight, rftThDnPercent: $rftThDnPercent, rftThUpPercent: $rftThUpPercent, rsvConnChkInt: $rsvConnChkInt, rsvHeight: $rsvHeight, rsvThDnPercent: $rsvThDnPercent)';
  }
}

/// @nodoc
abstract mixin class $UserDataReceiveCopyWith<$Res> {
  factory $UserDataReceiveCopyWith(
          UserDataReceive value, $Res Function(UserDataReceive) _then) =
      _$UserDataReceiveCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'CALIB_DONE') String calibDone,
      @JsonKey(name: 'Calibration_repeat') String calibrationRepeat,
      @JsonKey(name: "RFT_CALIB_CHK_INT") String rftCalibChkInt,
      @JsonKey(name: "RFT_CONN_CHK_INT") String rftConnChkInt,
      @JsonKey(name: "RFT_height") String rftHeight,
      @JsonKey(name: "RFT_th_dn_percent") String rftThDnPercent,
      @JsonKey(name: "RFT_th_up_percent") String rftThUpPercent,
      @JsonKey(name: "RSV_CONN_CHK_INT") String rsvConnChkInt,
      @JsonKey(name: "RSV_height") String rsvHeight,
      @JsonKey(name: "RSV_th_dn_percent") String rsvThDnPercent});
}

/// @nodoc
class _$UserDataReceiveCopyWithImpl<$Res>
    implements $UserDataReceiveCopyWith<$Res> {
  _$UserDataReceiveCopyWithImpl(this._self, this._then);

  final UserDataReceive _self;
  final $Res Function(UserDataReceive) _then;

  /// Create a copy of UserDataReceive
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? calibDone = null,
    Object? calibrationRepeat = null,
    Object? rftCalibChkInt = null,
    Object? rftConnChkInt = null,
    Object? rftHeight = null,
    Object? rftThDnPercent = null,
    Object? rftThUpPercent = null,
    Object? rsvConnChkInt = null,
    Object? rsvHeight = null,
    Object? rsvThDnPercent = null,
  }) {
    return _then(_self.copyWith(
      calibDone: null == calibDone
          ? _self.calibDone
          : calibDone // ignore: cast_nullable_to_non_nullable
              as String,
      calibrationRepeat: null == calibrationRepeat
          ? _self.calibrationRepeat
          : calibrationRepeat // ignore: cast_nullable_to_non_nullable
              as String,
      rftCalibChkInt: null == rftCalibChkInt
          ? _self.rftCalibChkInt
          : rftCalibChkInt // ignore: cast_nullable_to_non_nullable
              as String,
      rftConnChkInt: null == rftConnChkInt
          ? _self.rftConnChkInt
          : rftConnChkInt // ignore: cast_nullable_to_non_nullable
              as String,
      rftHeight: null == rftHeight
          ? _self.rftHeight
          : rftHeight // ignore: cast_nullable_to_non_nullable
              as String,
      rftThDnPercent: null == rftThDnPercent
          ? _self.rftThDnPercent
          : rftThDnPercent // ignore: cast_nullable_to_non_nullable
              as String,
      rftThUpPercent: null == rftThUpPercent
          ? _self.rftThUpPercent
          : rftThUpPercent // ignore: cast_nullable_to_non_nullable
              as String,
      rsvConnChkInt: null == rsvConnChkInt
          ? _self.rsvConnChkInt
          : rsvConnChkInt // ignore: cast_nullable_to_non_nullable
              as String,
      rsvHeight: null == rsvHeight
          ? _self.rsvHeight
          : rsvHeight // ignore: cast_nullable_to_non_nullable
              as String,
      rsvThDnPercent: null == rsvThDnPercent
          ? _self.rsvThDnPercent
          : rsvThDnPercent // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [UserDataReceive].
extension UserDataReceivePatterns on UserDataReceive {
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
    TResult Function(_UserDataReceive value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UserDataReceive() when $default != null:
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
    TResult Function(_UserDataReceive value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserDataReceive():
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
    TResult? Function(_UserDataReceive value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserDataReceive() when $default != null:
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
            @JsonKey(name: 'CALIB_DONE') String calibDone,
            @JsonKey(name: 'Calibration_repeat') String calibrationRepeat,
            @JsonKey(name: "RFT_CALIB_CHK_INT") String rftCalibChkInt,
            @JsonKey(name: "RFT_CONN_CHK_INT") String rftConnChkInt,
            @JsonKey(name: "RFT_height") String rftHeight,
            @JsonKey(name: "RFT_th_dn_percent") String rftThDnPercent,
            @JsonKey(name: "RFT_th_up_percent") String rftThUpPercent,
            @JsonKey(name: "RSV_CONN_CHK_INT") String rsvConnChkInt,
            @JsonKey(name: "RSV_height") String rsvHeight,
            @JsonKey(name: "RSV_th_dn_percent") String rsvThDnPercent)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UserDataReceive() when $default != null:
        return $default(
            _that.calibDone,
            _that.calibrationRepeat,
            _that.rftCalibChkInt,
            _that.rftConnChkInt,
            _that.rftHeight,
            _that.rftThDnPercent,
            _that.rftThUpPercent,
            _that.rsvConnChkInt,
            _that.rsvHeight,
            _that.rsvThDnPercent);
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
            @JsonKey(name: 'CALIB_DONE') String calibDone,
            @JsonKey(name: 'Calibration_repeat') String calibrationRepeat,
            @JsonKey(name: "RFT_CALIB_CHK_INT") String rftCalibChkInt,
            @JsonKey(name: "RFT_CONN_CHK_INT") String rftConnChkInt,
            @JsonKey(name: "RFT_height") String rftHeight,
            @JsonKey(name: "RFT_th_dn_percent") String rftThDnPercent,
            @JsonKey(name: "RFT_th_up_percent") String rftThUpPercent,
            @JsonKey(name: "RSV_CONN_CHK_INT") String rsvConnChkInt,
            @JsonKey(name: "RSV_height") String rsvHeight,
            @JsonKey(name: "RSV_th_dn_percent") String rsvThDnPercent)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserDataReceive():
        return $default(
            _that.calibDone,
            _that.calibrationRepeat,
            _that.rftCalibChkInt,
            _that.rftConnChkInt,
            _that.rftHeight,
            _that.rftThDnPercent,
            _that.rftThUpPercent,
            _that.rsvConnChkInt,
            _that.rsvHeight,
            _that.rsvThDnPercent);
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
            @JsonKey(name: 'CALIB_DONE') String calibDone,
            @JsonKey(name: 'Calibration_repeat') String calibrationRepeat,
            @JsonKey(name: "RFT_CALIB_CHK_INT") String rftCalibChkInt,
            @JsonKey(name: "RFT_CONN_CHK_INT") String rftConnChkInt,
            @JsonKey(name: "RFT_height") String rftHeight,
            @JsonKey(name: "RFT_th_dn_percent") String rftThDnPercent,
            @JsonKey(name: "RFT_th_up_percent") String rftThUpPercent,
            @JsonKey(name: "RSV_CONN_CHK_INT") String rsvConnChkInt,
            @JsonKey(name: "RSV_height") String rsvHeight,
            @JsonKey(name: "RSV_th_dn_percent") String rsvThDnPercent)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserDataReceive() when $default != null:
        return $default(
            _that.calibDone,
            _that.calibrationRepeat,
            _that.rftCalibChkInt,
            _that.rftConnChkInt,
            _that.rftHeight,
            _that.rftThDnPercent,
            _that.rftThUpPercent,
            _that.rsvConnChkInt,
            _that.rsvHeight,
            _that.rsvThDnPercent);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _UserDataReceive implements UserDataReceive {
  _UserDataReceive(
      {@JsonKey(name: 'CALIB_DONE') required this.calibDone,
      @JsonKey(name: 'Calibration_repeat') required this.calibrationRepeat,
      @JsonKey(name: "RFT_CALIB_CHK_INT") required this.rftCalibChkInt,
      @JsonKey(name: "RFT_CONN_CHK_INT") required this.rftConnChkInt,
      @JsonKey(name: "RFT_height") required this.rftHeight,
      @JsonKey(name: "RFT_th_dn_percent") required this.rftThDnPercent,
      @JsonKey(name: "RFT_th_up_percent") required this.rftThUpPercent,
      @JsonKey(name: "RSV_CONN_CHK_INT") required this.rsvConnChkInt,
      @JsonKey(name: "RSV_height") required this.rsvHeight,
      @JsonKey(name: "RSV_th_dn_percent") required this.rsvThDnPercent});
  factory _UserDataReceive.fromJson(Map<String, dynamic> json) =>
      _$UserDataReceiveFromJson(json);

  @override
  @JsonKey(name: 'CALIB_DONE')
  final String calibDone;
  @override
  @JsonKey(name: 'Calibration_repeat')
  final String calibrationRepeat;
  @override
  @JsonKey(name: "RFT_CALIB_CHK_INT")
  final String rftCalibChkInt;
  @override
  @JsonKey(name: "RFT_CONN_CHK_INT")
  final String rftConnChkInt;
  @override
  @JsonKey(name: "RFT_height")
  final String rftHeight;
  @override
  @JsonKey(name: "RFT_th_dn_percent")
  final String rftThDnPercent;
  @override
  @JsonKey(name: "RFT_th_up_percent")
  final String rftThUpPercent;
  @override
  @JsonKey(name: "RSV_CONN_CHK_INT")
  final String rsvConnChkInt;
  @override
  @JsonKey(name: "RSV_height")
  final String rsvHeight;
  @override
  @JsonKey(name: "RSV_th_dn_percent")
  final String rsvThDnPercent;

  /// Create a copy of UserDataReceive
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserDataReceiveCopyWith<_UserDataReceive> get copyWith =>
      __$UserDataReceiveCopyWithImpl<_UserDataReceive>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UserDataReceiveToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserDataReceive &&
            (identical(other.calibDone, calibDone) ||
                other.calibDone == calibDone) &&
            (identical(other.calibrationRepeat, calibrationRepeat) ||
                other.calibrationRepeat == calibrationRepeat) &&
            (identical(other.rftCalibChkInt, rftCalibChkInt) ||
                other.rftCalibChkInt == rftCalibChkInt) &&
            (identical(other.rftConnChkInt, rftConnChkInt) ||
                other.rftConnChkInt == rftConnChkInt) &&
            (identical(other.rftHeight, rftHeight) ||
                other.rftHeight == rftHeight) &&
            (identical(other.rftThDnPercent, rftThDnPercent) ||
                other.rftThDnPercent == rftThDnPercent) &&
            (identical(other.rftThUpPercent, rftThUpPercent) ||
                other.rftThUpPercent == rftThUpPercent) &&
            (identical(other.rsvConnChkInt, rsvConnChkInt) ||
                other.rsvConnChkInt == rsvConnChkInt) &&
            (identical(other.rsvHeight, rsvHeight) ||
                other.rsvHeight == rsvHeight) &&
            (identical(other.rsvThDnPercent, rsvThDnPercent) ||
                other.rsvThDnPercent == rsvThDnPercent));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      calibDone,
      calibrationRepeat,
      rftCalibChkInt,
      rftConnChkInt,
      rftHeight,
      rftThDnPercent,
      rftThUpPercent,
      rsvConnChkInt,
      rsvHeight,
      rsvThDnPercent);

  @override
  String toString() {
    return 'UserDataReceive(calibDone: $calibDone, calibrationRepeat: $calibrationRepeat, rftCalibChkInt: $rftCalibChkInt, rftConnChkInt: $rftConnChkInt, rftHeight: $rftHeight, rftThDnPercent: $rftThDnPercent, rftThUpPercent: $rftThUpPercent, rsvConnChkInt: $rsvConnChkInt, rsvHeight: $rsvHeight, rsvThDnPercent: $rsvThDnPercent)';
  }
}

/// @nodoc
abstract mixin class _$UserDataReceiveCopyWith<$Res>
    implements $UserDataReceiveCopyWith<$Res> {
  factory _$UserDataReceiveCopyWith(
          _UserDataReceive value, $Res Function(_UserDataReceive) _then) =
      __$UserDataReceiveCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'CALIB_DONE') String calibDone,
      @JsonKey(name: 'Calibration_repeat') String calibrationRepeat,
      @JsonKey(name: "RFT_CALIB_CHK_INT") String rftCalibChkInt,
      @JsonKey(name: "RFT_CONN_CHK_INT") String rftConnChkInt,
      @JsonKey(name: "RFT_height") String rftHeight,
      @JsonKey(name: "RFT_th_dn_percent") String rftThDnPercent,
      @JsonKey(name: "RFT_th_up_percent") String rftThUpPercent,
      @JsonKey(name: "RSV_CONN_CHK_INT") String rsvConnChkInt,
      @JsonKey(name: "RSV_height") String rsvHeight,
      @JsonKey(name: "RSV_th_dn_percent") String rsvThDnPercent});
}

/// @nodoc
class __$UserDataReceiveCopyWithImpl<$Res>
    implements _$UserDataReceiveCopyWith<$Res> {
  __$UserDataReceiveCopyWithImpl(this._self, this._then);

  final _UserDataReceive _self;
  final $Res Function(_UserDataReceive) _then;

  /// Create a copy of UserDataReceive
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? calibDone = null,
    Object? calibrationRepeat = null,
    Object? rftCalibChkInt = null,
    Object? rftConnChkInt = null,
    Object? rftHeight = null,
    Object? rftThDnPercent = null,
    Object? rftThUpPercent = null,
    Object? rsvConnChkInt = null,
    Object? rsvHeight = null,
    Object? rsvThDnPercent = null,
  }) {
    return _then(_UserDataReceive(
      calibDone: null == calibDone
          ? _self.calibDone
          : calibDone // ignore: cast_nullable_to_non_nullable
              as String,
      calibrationRepeat: null == calibrationRepeat
          ? _self.calibrationRepeat
          : calibrationRepeat // ignore: cast_nullable_to_non_nullable
              as String,
      rftCalibChkInt: null == rftCalibChkInt
          ? _self.rftCalibChkInt
          : rftCalibChkInt // ignore: cast_nullable_to_non_nullable
              as String,
      rftConnChkInt: null == rftConnChkInt
          ? _self.rftConnChkInt
          : rftConnChkInt // ignore: cast_nullable_to_non_nullable
              as String,
      rftHeight: null == rftHeight
          ? _self.rftHeight
          : rftHeight // ignore: cast_nullable_to_non_nullable
              as String,
      rftThDnPercent: null == rftThDnPercent
          ? _self.rftThDnPercent
          : rftThDnPercent // ignore: cast_nullable_to_non_nullable
              as String,
      rftThUpPercent: null == rftThUpPercent
          ? _self.rftThUpPercent
          : rftThUpPercent // ignore: cast_nullable_to_non_nullable
              as String,
      rsvConnChkInt: null == rsvConnChkInt
          ? _self.rsvConnChkInt
          : rsvConnChkInt // ignore: cast_nullable_to_non_nullable
              as String,
      rsvHeight: null == rsvHeight
          ? _self.rsvHeight
          : rsvHeight // ignore: cast_nullable_to_non_nullable
              as String,
      rsvThDnPercent: null == rsvThDnPercent
          ? _self.rsvThDnPercent
          : rsvThDnPercent // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
