// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../user_data_upload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserDataUpload {
  @JsonKey(name: 'ACPowerFail')
  String get acPowerFail;
  @JsonKey(name: 'ACPowerFailDuration')
  int get acPowerFailDuration;
  @JsonKey(name: 'CalibDuration')
  int get calibDuration;
  @JsonKey(name: 'MotorOff')
  String get motorOff;
  @JsonKey(name: 'MotorOn')
  String get motorOn;
  @JsonKey(name: 'MotorOnDuration')
  int get motorOnDuration;
  @JsonKey(name: 'RFT_sens_connect')
  String get rftSensConnect;
  @JsonKey(name: 'RSV_sens_connect')
  String get rsvSensConnect;
  @JsonKey(name: 'RSVEmpty')
  String get rsvEmpty;
  @JsonKey(name: "RSV_level_change_at_calib")
  int get rsvLevelChangeAtCalib;
  @JsonKey(name: "RFT_level_data")
  List<int> get rftLevelData;
  @JsonKey(name: "RSV_level_data")
  List<int> get rsvLevelData;
  @JsonKey(name: 'avg_calib')
  int get avgCalib;
  @JsonKey(name: 'calib_t0')
  int get calibT0;
  @JsonKey(name: 'calib_t1')
  int get calibT1;
  @JsonKey(name: 'calib_t2')
  int get calibT2;

  /// Create a copy of UserDataUpload
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserDataUploadCopyWith<UserDataUpload> get copyWith =>
      _$UserDataUploadCopyWithImpl<UserDataUpload>(
          this as UserDataUpload, _$identity);

  /// Serializes this UserDataUpload to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UserDataUpload &&
            (identical(other.acPowerFail, acPowerFail) ||
                other.acPowerFail == acPowerFail) &&
            (identical(other.acPowerFailDuration, acPowerFailDuration) ||
                other.acPowerFailDuration == acPowerFailDuration) &&
            (identical(other.calibDuration, calibDuration) ||
                other.calibDuration == calibDuration) &&
            (identical(other.motorOff, motorOff) ||
                other.motorOff == motorOff) &&
            (identical(other.motorOn, motorOn) || other.motorOn == motorOn) &&
            (identical(other.motorOnDuration, motorOnDuration) ||
                other.motorOnDuration == motorOnDuration) &&
            (identical(other.rftSensConnect, rftSensConnect) ||
                other.rftSensConnect == rftSensConnect) &&
            (identical(other.rsvSensConnect, rsvSensConnect) ||
                other.rsvSensConnect == rsvSensConnect) &&
            (identical(other.rsvEmpty, rsvEmpty) ||
                other.rsvEmpty == rsvEmpty) &&
            (identical(other.rsvLevelChangeAtCalib, rsvLevelChangeAtCalib) ||
                other.rsvLevelChangeAtCalib == rsvLevelChangeAtCalib) &&
            const DeepCollectionEquality()
                .equals(other.rftLevelData, rftLevelData) &&
            const DeepCollectionEquality()
                .equals(other.rsvLevelData, rsvLevelData) &&
            (identical(other.avgCalib, avgCalib) ||
                other.avgCalib == avgCalib) &&
            (identical(other.calibT0, calibT0) || other.calibT0 == calibT0) &&
            (identical(other.calibT1, calibT1) || other.calibT1 == calibT1) &&
            (identical(other.calibT2, calibT2) || other.calibT2 == calibT2));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      acPowerFail,
      acPowerFailDuration,
      calibDuration,
      motorOff,
      motorOn,
      motorOnDuration,
      rftSensConnect,
      rsvSensConnect,
      rsvEmpty,
      rsvLevelChangeAtCalib,
      const DeepCollectionEquality().hash(rftLevelData),
      const DeepCollectionEquality().hash(rsvLevelData),
      avgCalib,
      calibT0,
      calibT1,
      calibT2);

  @override
  String toString() {
    return 'UserDataUpload(acPowerFail: $acPowerFail, acPowerFailDuration: $acPowerFailDuration, calibDuration: $calibDuration, motorOff: $motorOff, motorOn: $motorOn, motorOnDuration: $motorOnDuration, rftSensConnect: $rftSensConnect, rsvSensConnect: $rsvSensConnect, rsvEmpty: $rsvEmpty, rsvLevelChangeAtCalib: $rsvLevelChangeAtCalib, rftLevelData: $rftLevelData, rsvLevelData: $rsvLevelData, avgCalib: $avgCalib, calibT0: $calibT0, calibT1: $calibT1, calibT2: $calibT2)';
  }
}

/// @nodoc
abstract mixin class $UserDataUploadCopyWith<$Res> {
  factory $UserDataUploadCopyWith(
          UserDataUpload value, $Res Function(UserDataUpload) _then) =
      _$UserDataUploadCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'ACPowerFail') String acPowerFail,
      @JsonKey(name: 'ACPowerFailDuration') int acPowerFailDuration,
      @JsonKey(name: 'CalibDuration') int calibDuration,
      @JsonKey(name: 'MotorOff') String motorOff,
      @JsonKey(name: 'MotorOn') String motorOn,
      @JsonKey(name: 'MotorOnDuration') int motorOnDuration,
      @JsonKey(name: 'RFT_sens_connect') String rftSensConnect,
      @JsonKey(name: 'RSV_sens_connect') String rsvSensConnect,
      @JsonKey(name: 'RSVEmpty') String rsvEmpty,
      @JsonKey(name: "RSV_level_change_at_calib") int rsvLevelChangeAtCalib,
      @JsonKey(name: "RFT_level_data") List<int> rftLevelData,
      @JsonKey(name: "RSV_level_data") List<int> rsvLevelData,
      @JsonKey(name: 'avg_calib') int avgCalib,
      @JsonKey(name: 'calib_t0') int calibT0,
      @JsonKey(name: 'calib_t1') int calibT1,
      @JsonKey(name: 'calib_t2') int calibT2});
}

/// @nodoc
class _$UserDataUploadCopyWithImpl<$Res>
    implements $UserDataUploadCopyWith<$Res> {
  _$UserDataUploadCopyWithImpl(this._self, this._then);

  final UserDataUpload _self;
  final $Res Function(UserDataUpload) _then;

  /// Create a copy of UserDataUpload
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? acPowerFail = null,
    Object? acPowerFailDuration = null,
    Object? calibDuration = null,
    Object? motorOff = null,
    Object? motorOn = null,
    Object? motorOnDuration = null,
    Object? rftSensConnect = null,
    Object? rsvSensConnect = null,
    Object? rsvEmpty = null,
    Object? rsvLevelChangeAtCalib = null,
    Object? rftLevelData = null,
    Object? rsvLevelData = null,
    Object? avgCalib = null,
    Object? calibT0 = null,
    Object? calibT1 = null,
    Object? calibT2 = null,
  }) {
    return _then(_self.copyWith(
      acPowerFail: null == acPowerFail
          ? _self.acPowerFail
          : acPowerFail // ignore: cast_nullable_to_non_nullable
              as String,
      acPowerFailDuration: null == acPowerFailDuration
          ? _self.acPowerFailDuration
          : acPowerFailDuration // ignore: cast_nullable_to_non_nullable
              as int,
      calibDuration: null == calibDuration
          ? _self.calibDuration
          : calibDuration // ignore: cast_nullable_to_non_nullable
              as int,
      motorOff: null == motorOff
          ? _self.motorOff
          : motorOff // ignore: cast_nullable_to_non_nullable
              as String,
      motorOn: null == motorOn
          ? _self.motorOn
          : motorOn // ignore: cast_nullable_to_non_nullable
              as String,
      motorOnDuration: null == motorOnDuration
          ? _self.motorOnDuration
          : motorOnDuration // ignore: cast_nullable_to_non_nullable
              as int,
      rftSensConnect: null == rftSensConnect
          ? _self.rftSensConnect
          : rftSensConnect // ignore: cast_nullable_to_non_nullable
              as String,
      rsvSensConnect: null == rsvSensConnect
          ? _self.rsvSensConnect
          : rsvSensConnect // ignore: cast_nullable_to_non_nullable
              as String,
      rsvEmpty: null == rsvEmpty
          ? _self.rsvEmpty
          : rsvEmpty // ignore: cast_nullable_to_non_nullable
              as String,
      rsvLevelChangeAtCalib: null == rsvLevelChangeAtCalib
          ? _self.rsvLevelChangeAtCalib
          : rsvLevelChangeAtCalib // ignore: cast_nullable_to_non_nullable
              as int,
      rftLevelData: null == rftLevelData
          ? _self.rftLevelData
          : rftLevelData // ignore: cast_nullable_to_non_nullable
              as List<int>,
      rsvLevelData: null == rsvLevelData
          ? _self.rsvLevelData
          : rsvLevelData // ignore: cast_nullable_to_non_nullable
              as List<int>,
      avgCalib: null == avgCalib
          ? _self.avgCalib
          : avgCalib // ignore: cast_nullable_to_non_nullable
              as int,
      calibT0: null == calibT0
          ? _self.calibT0
          : calibT0 // ignore: cast_nullable_to_non_nullable
              as int,
      calibT1: null == calibT1
          ? _self.calibT1
          : calibT1 // ignore: cast_nullable_to_non_nullable
              as int,
      calibT2: null == calibT2
          ? _self.calibT2
          : calibT2 // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [UserDataUpload].
extension UserDataUploadPatterns on UserDataUpload {
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
    TResult Function(_UserDataUpload value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UserDataUpload() when $default != null:
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
    TResult Function(_UserDataUpload value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserDataUpload():
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
    TResult? Function(_UserDataUpload value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserDataUpload() when $default != null:
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
            @JsonKey(name: 'ACPowerFail') String acPowerFail,
            @JsonKey(name: 'ACPowerFailDuration') int acPowerFailDuration,
            @JsonKey(name: 'CalibDuration') int calibDuration,
            @JsonKey(name: 'MotorOff') String motorOff,
            @JsonKey(name: 'MotorOn') String motorOn,
            @JsonKey(name: 'MotorOnDuration') int motorOnDuration,
            @JsonKey(name: 'RFT_sens_connect') String rftSensConnect,
            @JsonKey(name: 'RSV_sens_connect') String rsvSensConnect,
            @JsonKey(name: 'RSVEmpty') String rsvEmpty,
            @JsonKey(name: "RSV_level_change_at_calib")
            int rsvLevelChangeAtCalib,
            @JsonKey(name: "RFT_level_data") List<int> rftLevelData,
            @JsonKey(name: "RSV_level_data") List<int> rsvLevelData,
            @JsonKey(name: 'avg_calib') int avgCalib,
            @JsonKey(name: 'calib_t0') int calibT0,
            @JsonKey(name: 'calib_t1') int calibT1,
            @JsonKey(name: 'calib_t2') int calibT2)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UserDataUpload() when $default != null:
        return $default(
            _that.acPowerFail,
            _that.acPowerFailDuration,
            _that.calibDuration,
            _that.motorOff,
            _that.motorOn,
            _that.motorOnDuration,
            _that.rftSensConnect,
            _that.rsvSensConnect,
            _that.rsvEmpty,
            _that.rsvLevelChangeAtCalib,
            _that.rftLevelData,
            _that.rsvLevelData,
            _that.avgCalib,
            _that.calibT0,
            _that.calibT1,
            _that.calibT2);
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
            @JsonKey(name: 'ACPowerFail') String acPowerFail,
            @JsonKey(name: 'ACPowerFailDuration') int acPowerFailDuration,
            @JsonKey(name: 'CalibDuration') int calibDuration,
            @JsonKey(name: 'MotorOff') String motorOff,
            @JsonKey(name: 'MotorOn') String motorOn,
            @JsonKey(name: 'MotorOnDuration') int motorOnDuration,
            @JsonKey(name: 'RFT_sens_connect') String rftSensConnect,
            @JsonKey(name: 'RSV_sens_connect') String rsvSensConnect,
            @JsonKey(name: 'RSVEmpty') String rsvEmpty,
            @JsonKey(name: "RSV_level_change_at_calib")
            int rsvLevelChangeAtCalib,
            @JsonKey(name: "RFT_level_data") List<int> rftLevelData,
            @JsonKey(name: "RSV_level_data") List<int> rsvLevelData,
            @JsonKey(name: 'avg_calib') int avgCalib,
            @JsonKey(name: 'calib_t0') int calibT0,
            @JsonKey(name: 'calib_t1') int calibT1,
            @JsonKey(name: 'calib_t2') int calibT2)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserDataUpload():
        return $default(
            _that.acPowerFail,
            _that.acPowerFailDuration,
            _that.calibDuration,
            _that.motorOff,
            _that.motorOn,
            _that.motorOnDuration,
            _that.rftSensConnect,
            _that.rsvSensConnect,
            _that.rsvEmpty,
            _that.rsvLevelChangeAtCalib,
            _that.rftLevelData,
            _that.rsvLevelData,
            _that.avgCalib,
            _that.calibT0,
            _that.calibT1,
            _that.calibT2);
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
            @JsonKey(name: 'ACPowerFail') String acPowerFail,
            @JsonKey(name: 'ACPowerFailDuration') int acPowerFailDuration,
            @JsonKey(name: 'CalibDuration') int calibDuration,
            @JsonKey(name: 'MotorOff') String motorOff,
            @JsonKey(name: 'MotorOn') String motorOn,
            @JsonKey(name: 'MotorOnDuration') int motorOnDuration,
            @JsonKey(name: 'RFT_sens_connect') String rftSensConnect,
            @JsonKey(name: 'RSV_sens_connect') String rsvSensConnect,
            @JsonKey(name: 'RSVEmpty') String rsvEmpty,
            @JsonKey(name: "RSV_level_change_at_calib")
            int rsvLevelChangeAtCalib,
            @JsonKey(name: "RFT_level_data") List<int> rftLevelData,
            @JsonKey(name: "RSV_level_data") List<int> rsvLevelData,
            @JsonKey(name: 'avg_calib') int avgCalib,
            @JsonKey(name: 'calib_t0') int calibT0,
            @JsonKey(name: 'calib_t1') int calibT1,
            @JsonKey(name: 'calib_t2') int calibT2)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserDataUpload() when $default != null:
        return $default(
            _that.acPowerFail,
            _that.acPowerFailDuration,
            _that.calibDuration,
            _that.motorOff,
            _that.motorOn,
            _that.motorOnDuration,
            _that.rftSensConnect,
            _that.rsvSensConnect,
            _that.rsvEmpty,
            _that.rsvLevelChangeAtCalib,
            _that.rftLevelData,
            _that.rsvLevelData,
            _that.avgCalib,
            _that.calibT0,
            _that.calibT1,
            _that.calibT2);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _UserDataUpload extends UserDataUpload {
  const _UserDataUpload(
      @JsonKey(name: 'ACPowerFail') this.acPowerFail,
      @JsonKey(name: 'ACPowerFailDuration') this.acPowerFailDuration,
      @JsonKey(name: 'CalibDuration') this.calibDuration,
      @JsonKey(name: 'MotorOff') this.motorOff,
      @JsonKey(name: 'MotorOn') this.motorOn,
      @JsonKey(name: 'MotorOnDuration') this.motorOnDuration,
      @JsonKey(name: 'RFT_sens_connect') this.rftSensConnect,
      @JsonKey(name: 'RSV_sens_connect') this.rsvSensConnect,
      @JsonKey(name: 'RSVEmpty') this.rsvEmpty,
      @JsonKey(name: "RSV_level_change_at_calib") this.rsvLevelChangeAtCalib,
      @JsonKey(name: "RFT_level_data") final List<int> rftLevelData,
      @JsonKey(name: "RSV_level_data") final List<int> rsvLevelData,
      @JsonKey(name: 'avg_calib') this.avgCalib,
      @JsonKey(name: 'calib_t0') this.calibT0,
      @JsonKey(name: 'calib_t1') this.calibT1,
      @JsonKey(name: 'calib_t2') this.calibT2)
      : _rftLevelData = rftLevelData,
        _rsvLevelData = rsvLevelData,
        super._();
  factory _UserDataUpload.fromJson(Map<String, dynamic> json) =>
      _$UserDataUploadFromJson(json);

  @override
  @JsonKey(name: 'ACPowerFail')
  final String acPowerFail;
  @override
  @JsonKey(name: 'ACPowerFailDuration')
  final int acPowerFailDuration;
  @override
  @JsonKey(name: 'CalibDuration')
  final int calibDuration;
  @override
  @JsonKey(name: 'MotorOff')
  final String motorOff;
  @override
  @JsonKey(name: 'MotorOn')
  final String motorOn;
  @override
  @JsonKey(name: 'MotorOnDuration')
  final int motorOnDuration;
  @override
  @JsonKey(name: 'RFT_sens_connect')
  final String rftSensConnect;
  @override
  @JsonKey(name: 'RSV_sens_connect')
  final String rsvSensConnect;
  @override
  @JsonKey(name: 'RSVEmpty')
  final String rsvEmpty;
  @override
  @JsonKey(name: "RSV_level_change_at_calib")
  final int rsvLevelChangeAtCalib;
  final List<int> _rftLevelData;
  @override
  @JsonKey(name: "RFT_level_data")
  List<int> get rftLevelData {
    if (_rftLevelData is EqualUnmodifiableListView) return _rftLevelData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rftLevelData);
  }

  final List<int> _rsvLevelData;
  @override
  @JsonKey(name: "RSV_level_data")
  List<int> get rsvLevelData {
    if (_rsvLevelData is EqualUnmodifiableListView) return _rsvLevelData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rsvLevelData);
  }

  @override
  @JsonKey(name: 'avg_calib')
  final int avgCalib;
  @override
  @JsonKey(name: 'calib_t0')
  final int calibT0;
  @override
  @JsonKey(name: 'calib_t1')
  final int calibT1;
  @override
  @JsonKey(name: 'calib_t2')
  final int calibT2;

  /// Create a copy of UserDataUpload
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserDataUploadCopyWith<_UserDataUpload> get copyWith =>
      __$UserDataUploadCopyWithImpl<_UserDataUpload>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UserDataUploadToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserDataUpload &&
            (identical(other.acPowerFail, acPowerFail) ||
                other.acPowerFail == acPowerFail) &&
            (identical(other.acPowerFailDuration, acPowerFailDuration) ||
                other.acPowerFailDuration == acPowerFailDuration) &&
            (identical(other.calibDuration, calibDuration) ||
                other.calibDuration == calibDuration) &&
            (identical(other.motorOff, motorOff) ||
                other.motorOff == motorOff) &&
            (identical(other.motorOn, motorOn) || other.motorOn == motorOn) &&
            (identical(other.motorOnDuration, motorOnDuration) ||
                other.motorOnDuration == motorOnDuration) &&
            (identical(other.rftSensConnect, rftSensConnect) ||
                other.rftSensConnect == rftSensConnect) &&
            (identical(other.rsvSensConnect, rsvSensConnect) ||
                other.rsvSensConnect == rsvSensConnect) &&
            (identical(other.rsvEmpty, rsvEmpty) ||
                other.rsvEmpty == rsvEmpty) &&
            (identical(other.rsvLevelChangeAtCalib, rsvLevelChangeAtCalib) ||
                other.rsvLevelChangeAtCalib == rsvLevelChangeAtCalib) &&
            const DeepCollectionEquality()
                .equals(other._rftLevelData, _rftLevelData) &&
            const DeepCollectionEquality()
                .equals(other._rsvLevelData, _rsvLevelData) &&
            (identical(other.avgCalib, avgCalib) ||
                other.avgCalib == avgCalib) &&
            (identical(other.calibT0, calibT0) || other.calibT0 == calibT0) &&
            (identical(other.calibT1, calibT1) || other.calibT1 == calibT1) &&
            (identical(other.calibT2, calibT2) || other.calibT2 == calibT2));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      acPowerFail,
      acPowerFailDuration,
      calibDuration,
      motorOff,
      motorOn,
      motorOnDuration,
      rftSensConnect,
      rsvSensConnect,
      rsvEmpty,
      rsvLevelChangeAtCalib,
      const DeepCollectionEquality().hash(_rftLevelData),
      const DeepCollectionEquality().hash(_rsvLevelData),
      avgCalib,
      calibT0,
      calibT1,
      calibT2);

  @override
  String toString() {
    return 'UserDataUpload(acPowerFail: $acPowerFail, acPowerFailDuration: $acPowerFailDuration, calibDuration: $calibDuration, motorOff: $motorOff, motorOn: $motorOn, motorOnDuration: $motorOnDuration, rftSensConnect: $rftSensConnect, rsvSensConnect: $rsvSensConnect, rsvEmpty: $rsvEmpty, rsvLevelChangeAtCalib: $rsvLevelChangeAtCalib, rftLevelData: $rftLevelData, rsvLevelData: $rsvLevelData, avgCalib: $avgCalib, calibT0: $calibT0, calibT1: $calibT1, calibT2: $calibT2)';
  }
}

/// @nodoc
abstract mixin class _$UserDataUploadCopyWith<$Res>
    implements $UserDataUploadCopyWith<$Res> {
  factory _$UserDataUploadCopyWith(
          _UserDataUpload value, $Res Function(_UserDataUpload) _then) =
      __$UserDataUploadCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'ACPowerFail') String acPowerFail,
      @JsonKey(name: 'ACPowerFailDuration') int acPowerFailDuration,
      @JsonKey(name: 'CalibDuration') int calibDuration,
      @JsonKey(name: 'MotorOff') String motorOff,
      @JsonKey(name: 'MotorOn') String motorOn,
      @JsonKey(name: 'MotorOnDuration') int motorOnDuration,
      @JsonKey(name: 'RFT_sens_connect') String rftSensConnect,
      @JsonKey(name: 'RSV_sens_connect') String rsvSensConnect,
      @JsonKey(name: 'RSVEmpty') String rsvEmpty,
      @JsonKey(name: "RSV_level_change_at_calib") int rsvLevelChangeAtCalib,
      @JsonKey(name: "RFT_level_data") List<int> rftLevelData,
      @JsonKey(name: "RSV_level_data") List<int> rsvLevelData,
      @JsonKey(name: 'avg_calib') int avgCalib,
      @JsonKey(name: 'calib_t0') int calibT0,
      @JsonKey(name: 'calib_t1') int calibT1,
      @JsonKey(name: 'calib_t2') int calibT2});
}

/// @nodoc
class __$UserDataUploadCopyWithImpl<$Res>
    implements _$UserDataUploadCopyWith<$Res> {
  __$UserDataUploadCopyWithImpl(this._self, this._then);

  final _UserDataUpload _self;
  final $Res Function(_UserDataUpload) _then;

  /// Create a copy of UserDataUpload
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? acPowerFail = null,
    Object? acPowerFailDuration = null,
    Object? calibDuration = null,
    Object? motorOff = null,
    Object? motorOn = null,
    Object? motorOnDuration = null,
    Object? rftSensConnect = null,
    Object? rsvSensConnect = null,
    Object? rsvEmpty = null,
    Object? rsvLevelChangeAtCalib = null,
    Object? rftLevelData = null,
    Object? rsvLevelData = null,
    Object? avgCalib = null,
    Object? calibT0 = null,
    Object? calibT1 = null,
    Object? calibT2 = null,
  }) {
    return _then(_UserDataUpload(
      null == acPowerFail
          ? _self.acPowerFail
          : acPowerFail // ignore: cast_nullable_to_non_nullable
              as String,
      null == acPowerFailDuration
          ? _self.acPowerFailDuration
          : acPowerFailDuration // ignore: cast_nullable_to_non_nullable
              as int,
      null == calibDuration
          ? _self.calibDuration
          : calibDuration // ignore: cast_nullable_to_non_nullable
              as int,
      null == motorOff
          ? _self.motorOff
          : motorOff // ignore: cast_nullable_to_non_nullable
              as String,
      null == motorOn
          ? _self.motorOn
          : motorOn // ignore: cast_nullable_to_non_nullable
              as String,
      null == motorOnDuration
          ? _self.motorOnDuration
          : motorOnDuration // ignore: cast_nullable_to_non_nullable
              as int,
      null == rftSensConnect
          ? _self.rftSensConnect
          : rftSensConnect // ignore: cast_nullable_to_non_nullable
              as String,
      null == rsvSensConnect
          ? _self.rsvSensConnect
          : rsvSensConnect // ignore: cast_nullable_to_non_nullable
              as String,
      null == rsvEmpty
          ? _self.rsvEmpty
          : rsvEmpty // ignore: cast_nullable_to_non_nullable
              as String,
      null == rsvLevelChangeAtCalib
          ? _self.rsvLevelChangeAtCalib
          : rsvLevelChangeAtCalib // ignore: cast_nullable_to_non_nullable
              as int,
      null == rftLevelData
          ? _self._rftLevelData
          : rftLevelData // ignore: cast_nullable_to_non_nullable
              as List<int>,
      null == rsvLevelData
          ? _self._rsvLevelData
          : rsvLevelData // ignore: cast_nullable_to_non_nullable
              as List<int>,
      null == avgCalib
          ? _self.avgCalib
          : avgCalib // ignore: cast_nullable_to_non_nullable
              as int,
      null == calibT0
          ? _self.calibT0
          : calibT0 // ignore: cast_nullable_to_non_nullable
              as int,
      null == calibT1
          ? _self.calibT1
          : calibT1 // ignore: cast_nullable_to_non_nullable
              as int,
      null == calibT2
          ? _self.calibT2
          : calibT2 // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
