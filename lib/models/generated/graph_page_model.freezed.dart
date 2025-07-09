// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../graph_page_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GraphPageModel {
  List<MotorStateData> get motorStateData;
  List<MotorStateData> get motorStateDataOn;
  List<MotorStateData> get motorStateDataOff;
  SelectedPeriod get selectedPeriod;

  /// Create a copy of GraphPageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GraphPageModelCopyWith<GraphPageModel> get copyWith =>
      _$GraphPageModelCopyWithImpl<GraphPageModel>(
          this as GraphPageModel, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GraphPageModel &&
            const DeepCollectionEquality()
                .equals(other.motorStateData, motorStateData) &&
            const DeepCollectionEquality()
                .equals(other.motorStateDataOn, motorStateDataOn) &&
            const DeepCollectionEquality()
                .equals(other.motorStateDataOff, motorStateDataOff) &&
            (identical(other.selectedPeriod, selectedPeriod) ||
                other.selectedPeriod == selectedPeriod));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(motorStateData),
      const DeepCollectionEquality().hash(motorStateDataOn),
      const DeepCollectionEquality().hash(motorStateDataOff),
      selectedPeriod);

  @override
  String toString() {
    return 'GraphPageModel(motorStateData: $motorStateData, motorStateDataOn: $motorStateDataOn, motorStateDataOff: $motorStateDataOff, selectedPeriod: $selectedPeriod)';
  }
}

/// @nodoc
abstract mixin class $GraphPageModelCopyWith<$Res> {
  factory $GraphPageModelCopyWith(
          GraphPageModel value, $Res Function(GraphPageModel) _then) =
      _$GraphPageModelCopyWithImpl;
  @useResult
  $Res call(
      {List<MotorStateData> motorStateData,
      List<MotorStateData> motorStateDataOn,
      List<MotorStateData> motorStateDataOff,
      SelectedPeriod selectedPeriod});
}

/// @nodoc
class _$GraphPageModelCopyWithImpl<$Res>
    implements $GraphPageModelCopyWith<$Res> {
  _$GraphPageModelCopyWithImpl(this._self, this._then);

  final GraphPageModel _self;
  final $Res Function(GraphPageModel) _then;

  /// Create a copy of GraphPageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? motorStateData = null,
    Object? motorStateDataOn = null,
    Object? motorStateDataOff = null,
    Object? selectedPeriod = null,
  }) {
    return _then(_self.copyWith(
      motorStateData: null == motorStateData
          ? _self.motorStateData
          : motorStateData // ignore: cast_nullable_to_non_nullable
              as List<MotorStateData>,
      motorStateDataOn: null == motorStateDataOn
          ? _self.motorStateDataOn
          : motorStateDataOn // ignore: cast_nullable_to_non_nullable
              as List<MotorStateData>,
      motorStateDataOff: null == motorStateDataOff
          ? _self.motorStateDataOff
          : motorStateDataOff // ignore: cast_nullable_to_non_nullable
              as List<MotorStateData>,
      selectedPeriod: null == selectedPeriod
          ? _self.selectedPeriod
          : selectedPeriod // ignore: cast_nullable_to_non_nullable
              as SelectedPeriod,
    ));
  }
}

/// Adds pattern-matching-related methods to [GraphPageModel].
extension GraphPageModelPatterns on GraphPageModel {
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
    TResult Function(_GraphPageModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GraphPageModel() when $default != null:
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
    TResult Function(_GraphPageModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GraphPageModel():
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
    TResult? Function(_GraphPageModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GraphPageModel() when $default != null:
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
            List<MotorStateData> motorStateData,
            List<MotorStateData> motorStateDataOn,
            List<MotorStateData> motorStateDataOff,
            SelectedPeriod selectedPeriod)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GraphPageModel() when $default != null:
        return $default(_that.motorStateData, _that.motorStateDataOn,
            _that.motorStateDataOff, _that.selectedPeriod);
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
            List<MotorStateData> motorStateData,
            List<MotorStateData> motorStateDataOn,
            List<MotorStateData> motorStateDataOff,
            SelectedPeriod selectedPeriod)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GraphPageModel():
        return $default(_that.motorStateData, _that.motorStateDataOn,
            _that.motorStateDataOff, _that.selectedPeriod);
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
            List<MotorStateData> motorStateData,
            List<MotorStateData> motorStateDataOn,
            List<MotorStateData> motorStateDataOff,
            SelectedPeriod selectedPeriod)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GraphPageModel() when $default != null:
        return $default(_that.motorStateData, _that.motorStateDataOn,
            _that.motorStateDataOff, _that.selectedPeriod);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _GraphPageModel implements GraphPageModel {
  _GraphPageModel(
      {required final List<MotorStateData> motorStateData,
      required final List<MotorStateData> motorStateDataOn,
      required final List<MotorStateData> motorStateDataOff,
      this.selectedPeriod = SelectedPeriod.week})
      : _motorStateData = motorStateData,
        _motorStateDataOn = motorStateDataOn,
        _motorStateDataOff = motorStateDataOff;

  final List<MotorStateData> _motorStateData;
  @override
  List<MotorStateData> get motorStateData {
    if (_motorStateData is EqualUnmodifiableListView) return _motorStateData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_motorStateData);
  }

  final List<MotorStateData> _motorStateDataOn;
  @override
  List<MotorStateData> get motorStateDataOn {
    if (_motorStateDataOn is EqualUnmodifiableListView)
      return _motorStateDataOn;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_motorStateDataOn);
  }

  final List<MotorStateData> _motorStateDataOff;
  @override
  List<MotorStateData> get motorStateDataOff {
    if (_motorStateDataOff is EqualUnmodifiableListView)
      return _motorStateDataOff;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_motorStateDataOff);
  }

  @override
  @JsonKey()
  final SelectedPeriod selectedPeriod;

  /// Create a copy of GraphPageModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GraphPageModelCopyWith<_GraphPageModel> get copyWith =>
      __$GraphPageModelCopyWithImpl<_GraphPageModel>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GraphPageModel &&
            const DeepCollectionEquality()
                .equals(other._motorStateData, _motorStateData) &&
            const DeepCollectionEquality()
                .equals(other._motorStateDataOn, _motorStateDataOn) &&
            const DeepCollectionEquality()
                .equals(other._motorStateDataOff, _motorStateDataOff) &&
            (identical(other.selectedPeriod, selectedPeriod) ||
                other.selectedPeriod == selectedPeriod));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_motorStateData),
      const DeepCollectionEquality().hash(_motorStateDataOn),
      const DeepCollectionEquality().hash(_motorStateDataOff),
      selectedPeriod);

  @override
  String toString() {
    return 'GraphPageModel(motorStateData: $motorStateData, motorStateDataOn: $motorStateDataOn, motorStateDataOff: $motorStateDataOff, selectedPeriod: $selectedPeriod)';
  }
}

/// @nodoc
abstract mixin class _$GraphPageModelCopyWith<$Res>
    implements $GraphPageModelCopyWith<$Res> {
  factory _$GraphPageModelCopyWith(
          _GraphPageModel value, $Res Function(_GraphPageModel) _then) =
      __$GraphPageModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<MotorStateData> motorStateData,
      List<MotorStateData> motorStateDataOn,
      List<MotorStateData> motorStateDataOff,
      SelectedPeriod selectedPeriod});
}

/// @nodoc
class __$GraphPageModelCopyWithImpl<$Res>
    implements _$GraphPageModelCopyWith<$Res> {
  __$GraphPageModelCopyWithImpl(this._self, this._then);

  final _GraphPageModel _self;
  final $Res Function(_GraphPageModel) _then;

  /// Create a copy of GraphPageModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? motorStateData = null,
    Object? motorStateDataOn = null,
    Object? motorStateDataOff = null,
    Object? selectedPeriod = null,
  }) {
    return _then(_GraphPageModel(
      motorStateData: null == motorStateData
          ? _self._motorStateData
          : motorStateData // ignore: cast_nullable_to_non_nullable
              as List<MotorStateData>,
      motorStateDataOn: null == motorStateDataOn
          ? _self._motorStateDataOn
          : motorStateDataOn // ignore: cast_nullable_to_non_nullable
              as List<MotorStateData>,
      motorStateDataOff: null == motorStateDataOff
          ? _self._motorStateDataOff
          : motorStateDataOff // ignore: cast_nullable_to_non_nullable
              as List<MotorStateData>,
      selectedPeriod: null == selectedPeriod
          ? _self.selectedPeriod
          : selectedPeriod // ignore: cast_nullable_to_non_nullable
              as SelectedPeriod,
    ));
  }
}

// dart format on
