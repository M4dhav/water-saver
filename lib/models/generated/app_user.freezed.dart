// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../app_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppUser {
  String get deviceId;
  UserDataUpload get userDataUpload;
  UserProfile get userProfile;
  UserDataReceive get userDataReceive;

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AppUserCopyWith<AppUser> get copyWith =>
      _$AppUserCopyWithImpl<AppUser>(this as AppUser, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppUser &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.userDataUpload, userDataUpload) ||
                other.userDataUpload == userDataUpload) &&
            (identical(other.userProfile, userProfile) ||
                other.userProfile == userProfile) &&
            (identical(other.userDataReceive, userDataReceive) ||
                other.userDataReceive == userDataReceive));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, deviceId, userDataUpload, userProfile, userDataReceive);

  @override
  String toString() {
    return 'AppUser(deviceId: $deviceId, userDataUpload: $userDataUpload, userProfile: $userProfile, userDataReceive: $userDataReceive)';
  }
}

/// @nodoc
abstract mixin class $AppUserCopyWith<$Res> {
  factory $AppUserCopyWith(AppUser value, $Res Function(AppUser) _then) =
      _$AppUserCopyWithImpl;
  @useResult
  $Res call(
      {String deviceId,
      UserDataUpload userDataUpload,
      UserProfile userProfile,
      UserDataReceive userDataReceive});

  $UserDataUploadCopyWith<$Res> get userDataUpload;
  $UserProfileCopyWith<$Res> get userProfile;
  $UserDataReceiveCopyWith<$Res> get userDataReceive;
}

/// @nodoc
class _$AppUserCopyWithImpl<$Res> implements $AppUserCopyWith<$Res> {
  _$AppUserCopyWithImpl(this._self, this._then);

  final AppUser _self;
  final $Res Function(AppUser) _then;

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deviceId = null,
    Object? userDataUpload = null,
    Object? userProfile = null,
    Object? userDataReceive = null,
  }) {
    return _then(_self.copyWith(
      deviceId: null == deviceId
          ? _self.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      userDataUpload: null == userDataUpload
          ? _self.userDataUpload
          : userDataUpload // ignore: cast_nullable_to_non_nullable
              as UserDataUpload,
      userProfile: null == userProfile
          ? _self.userProfile
          : userProfile // ignore: cast_nullable_to_non_nullable
              as UserProfile,
      userDataReceive: null == userDataReceive
          ? _self.userDataReceive
          : userDataReceive // ignore: cast_nullable_to_non_nullable
              as UserDataReceive,
    ));
  }

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserDataUploadCopyWith<$Res> get userDataUpload {
    return $UserDataUploadCopyWith<$Res>(_self.userDataUpload, (value) {
      return _then(_self.copyWith(userDataUpload: value));
    });
  }

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserProfileCopyWith<$Res> get userProfile {
    return $UserProfileCopyWith<$Res>(_self.userProfile, (value) {
      return _then(_self.copyWith(userProfile: value));
    });
  }

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserDataReceiveCopyWith<$Res> get userDataReceive {
    return $UserDataReceiveCopyWith<$Res>(_self.userDataReceive, (value) {
      return _then(_self.copyWith(userDataReceive: value));
    });
  }
}

/// Adds pattern-matching-related methods to [AppUser].
extension AppUserPatterns on AppUser {
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
    TResult Function(_AppUser value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AppUser() when $default != null:
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
    TResult Function(_AppUser value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppUser():
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
    TResult? Function(_AppUser value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppUser() when $default != null:
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
    TResult Function(String deviceId, UserDataUpload userDataUpload,
            UserProfile userProfile, UserDataReceive userDataReceive)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AppUser() when $default != null:
        return $default(_that.deviceId, _that.userDataUpload, _that.userProfile,
            _that.userDataReceive);
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
    TResult Function(String deviceId, UserDataUpload userDataUpload,
            UserProfile userProfile, UserDataReceive userDataReceive)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppUser():
        return $default(_that.deviceId, _that.userDataUpload, _that.userProfile,
            _that.userDataReceive);
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
    TResult? Function(String deviceId, UserDataUpload userDataUpload,
            UserProfile userProfile, UserDataReceive userDataReceive)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppUser() when $default != null:
        return $default(_that.deviceId, _that.userDataUpload, _that.userProfile,
            _that.userDataReceive);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _AppUser implements AppUser {
  _AppUser(this.deviceId, this.userDataUpload, this.userProfile,
      this.userDataReceive);

  @override
  final String deviceId;
  @override
  final UserDataUpload userDataUpload;
  @override
  final UserProfile userProfile;
  @override
  final UserDataReceive userDataReceive;

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AppUserCopyWith<_AppUser> get copyWith =>
      __$AppUserCopyWithImpl<_AppUser>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AppUser &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.userDataUpload, userDataUpload) ||
                other.userDataUpload == userDataUpload) &&
            (identical(other.userProfile, userProfile) ||
                other.userProfile == userProfile) &&
            (identical(other.userDataReceive, userDataReceive) ||
                other.userDataReceive == userDataReceive));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, deviceId, userDataUpload, userProfile, userDataReceive);

  @override
  String toString() {
    return 'AppUser(deviceId: $deviceId, userDataUpload: $userDataUpload, userProfile: $userProfile, userDataReceive: $userDataReceive)';
  }
}

/// @nodoc
abstract mixin class _$AppUserCopyWith<$Res> implements $AppUserCopyWith<$Res> {
  factory _$AppUserCopyWith(_AppUser value, $Res Function(_AppUser) _then) =
      __$AppUserCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String deviceId,
      UserDataUpload userDataUpload,
      UserProfile userProfile,
      UserDataReceive userDataReceive});

  @override
  $UserDataUploadCopyWith<$Res> get userDataUpload;
  @override
  $UserProfileCopyWith<$Res> get userProfile;
  @override
  $UserDataReceiveCopyWith<$Res> get userDataReceive;
}

/// @nodoc
class __$AppUserCopyWithImpl<$Res> implements _$AppUserCopyWith<$Res> {
  __$AppUserCopyWithImpl(this._self, this._then);

  final _AppUser _self;
  final $Res Function(_AppUser) _then;

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? deviceId = null,
    Object? userDataUpload = null,
    Object? userProfile = null,
    Object? userDataReceive = null,
  }) {
    return _then(_AppUser(
      null == deviceId
          ? _self.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      null == userDataUpload
          ? _self.userDataUpload
          : userDataUpload // ignore: cast_nullable_to_non_nullable
              as UserDataUpload,
      null == userProfile
          ? _self.userProfile
          : userProfile // ignore: cast_nullable_to_non_nullable
              as UserProfile,
      null == userDataReceive
          ? _self.userDataReceive
          : userDataReceive // ignore: cast_nullable_to_non_nullable
              as UserDataReceive,
    ));
  }

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserDataUploadCopyWith<$Res> get userDataUpload {
    return $UserDataUploadCopyWith<$Res>(_self.userDataUpload, (value) {
      return _then(_self.copyWith(userDataUpload: value));
    });
  }

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserProfileCopyWith<$Res> get userProfile {
    return $UserProfileCopyWith<$Res>(_self.userProfile, (value) {
      return _then(_self.copyWith(userProfile: value));
    });
  }

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserDataReceiveCopyWith<$Res> get userDataReceive {
    return $UserDataReceiveCopyWith<$Res>(_self.userDataReceive, (value) {
      return _then(_self.copyWith(userDataReceive: value));
    });
  }
}

// dart format on
