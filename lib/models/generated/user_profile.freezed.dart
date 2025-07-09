// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../user_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserProfile implements DiagnosticableTreeMixin {
  @JsonKey(name: 'Name')
  String get name;
  @JsonKey(name: 'Surname')
  String get surname;
  @JsonKey(name: 'Contact')
  String get contact;
  @JsonKey(name: 'Country')
  String get country;
  @JsonKey(name: 'State')
  String get state;
  @JsonKey(name: 'PIN')
  String get pin;
  @JsonKey(name: 'Address')
  String get address;
  @JsonKey(name: 'DOP')
  String get dateOfPurchase;
  @JsonKey(name: 'AddOn')
  String get addOn;
  @JsonKey(name: 'Cable')
  String get cable;
  @JsonKey(name: 'City')
  String get city;
  @JsonKey(name: 'ProdCat')
  String get prodCat;
  @JsonKey(name: 'Socket')
  String get socket;
  @JsonKey(name: "Email")
  String get email;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserProfileCopyWith<UserProfile> get copyWith =>
      _$UserProfileCopyWithImpl<UserProfile>(this as UserProfile, _$identity);

  /// Serializes this UserProfile to a JSON map.
  Map<String, dynamic> toJson();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'UserProfile'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('surname', surname))
      ..add(DiagnosticsProperty('contact', contact))
      ..add(DiagnosticsProperty('country', country))
      ..add(DiagnosticsProperty('state', state))
      ..add(DiagnosticsProperty('pin', pin))
      ..add(DiagnosticsProperty('address', address))
      ..add(DiagnosticsProperty('dateOfPurchase', dateOfPurchase))
      ..add(DiagnosticsProperty('addOn', addOn))
      ..add(DiagnosticsProperty('cable', cable))
      ..add(DiagnosticsProperty('city', city))
      ..add(DiagnosticsProperty('prodCat', prodCat))
      ..add(DiagnosticsProperty('socket', socket))
      ..add(DiagnosticsProperty('email', email));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UserProfile &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.surname, surname) || other.surname == surname) &&
            (identical(other.contact, contact) || other.contact == contact) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.pin, pin) || other.pin == pin) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.dateOfPurchase, dateOfPurchase) ||
                other.dateOfPurchase == dateOfPurchase) &&
            (identical(other.addOn, addOn) || other.addOn == addOn) &&
            (identical(other.cable, cable) || other.cable == cable) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.prodCat, prodCat) || other.prodCat == prodCat) &&
            (identical(other.socket, socket) || other.socket == socket) &&
            (identical(other.email, email) || other.email == email));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      surname,
      contact,
      country,
      state,
      pin,
      address,
      dateOfPurchase,
      addOn,
      cable,
      city,
      prodCat,
      socket,
      email);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserProfile(name: $name, surname: $surname, contact: $contact, country: $country, state: $state, pin: $pin, address: $address, dateOfPurchase: $dateOfPurchase, addOn: $addOn, cable: $cable, city: $city, prodCat: $prodCat, socket: $socket, email: $email)';
  }
}

/// @nodoc
abstract mixin class $UserProfileCopyWith<$Res> {
  factory $UserProfileCopyWith(
          UserProfile value, $Res Function(UserProfile) _then) =
      _$UserProfileCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'Name') String name,
      @JsonKey(name: 'Surname') String surname,
      @JsonKey(name: 'Contact') String contact,
      @JsonKey(name: 'Country') String country,
      @JsonKey(name: 'State') String state,
      @JsonKey(name: 'PIN') String pin,
      @JsonKey(name: 'Address') String address,
      @JsonKey(name: 'DOP') String dateOfPurchase,
      @JsonKey(name: 'AddOn') String addOn,
      @JsonKey(name: 'Cable') String cable,
      @JsonKey(name: 'City') String city,
      @JsonKey(name: 'ProdCat') String prodCat,
      @JsonKey(name: 'Socket') String socket,
      @JsonKey(name: "Email") String email});
}

/// @nodoc
class _$UserProfileCopyWithImpl<$Res> implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._self, this._then);

  final UserProfile _self;
  final $Res Function(UserProfile) _then;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? surname = null,
    Object? contact = null,
    Object? country = null,
    Object? state = null,
    Object? pin = null,
    Object? address = null,
    Object? dateOfPurchase = null,
    Object? addOn = null,
    Object? cable = null,
    Object? city = null,
    Object? prodCat = null,
    Object? socket = null,
    Object? email = null,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      surname: null == surname
          ? _self.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String,
      contact: null == contact
          ? _self.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _self.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _self.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      pin: null == pin
          ? _self.pin
          : pin // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      dateOfPurchase: null == dateOfPurchase
          ? _self.dateOfPurchase
          : dateOfPurchase // ignore: cast_nullable_to_non_nullable
              as String,
      addOn: null == addOn
          ? _self.addOn
          : addOn // ignore: cast_nullable_to_non_nullable
              as String,
      cable: null == cable
          ? _self.cable
          : cable // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _self.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      prodCat: null == prodCat
          ? _self.prodCat
          : prodCat // ignore: cast_nullable_to_non_nullable
              as String,
      socket: null == socket
          ? _self.socket
          : socket // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [UserProfile].
extension UserProfilePatterns on UserProfile {
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
    TResult Function(_UserProfile value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UserProfile() when $default != null:
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
    TResult Function(_UserProfile value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserProfile():
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
    TResult? Function(_UserProfile value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserProfile() when $default != null:
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
            @JsonKey(name: 'Name') String name,
            @JsonKey(name: 'Surname') String surname,
            @JsonKey(name: 'Contact') String contact,
            @JsonKey(name: 'Country') String country,
            @JsonKey(name: 'State') String state,
            @JsonKey(name: 'PIN') String pin,
            @JsonKey(name: 'Address') String address,
            @JsonKey(name: 'DOP') String dateOfPurchase,
            @JsonKey(name: 'AddOn') String addOn,
            @JsonKey(name: 'Cable') String cable,
            @JsonKey(name: 'City') String city,
            @JsonKey(name: 'ProdCat') String prodCat,
            @JsonKey(name: 'Socket') String socket,
            @JsonKey(name: "Email") String email)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UserProfile() when $default != null:
        return $default(
            _that.name,
            _that.surname,
            _that.contact,
            _that.country,
            _that.state,
            _that.pin,
            _that.address,
            _that.dateOfPurchase,
            _that.addOn,
            _that.cable,
            _that.city,
            _that.prodCat,
            _that.socket,
            _that.email);
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
            @JsonKey(name: 'Name') String name,
            @JsonKey(name: 'Surname') String surname,
            @JsonKey(name: 'Contact') String contact,
            @JsonKey(name: 'Country') String country,
            @JsonKey(name: 'State') String state,
            @JsonKey(name: 'PIN') String pin,
            @JsonKey(name: 'Address') String address,
            @JsonKey(name: 'DOP') String dateOfPurchase,
            @JsonKey(name: 'AddOn') String addOn,
            @JsonKey(name: 'Cable') String cable,
            @JsonKey(name: 'City') String city,
            @JsonKey(name: 'ProdCat') String prodCat,
            @JsonKey(name: 'Socket') String socket,
            @JsonKey(name: "Email") String email)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserProfile():
        return $default(
            _that.name,
            _that.surname,
            _that.contact,
            _that.country,
            _that.state,
            _that.pin,
            _that.address,
            _that.dateOfPurchase,
            _that.addOn,
            _that.cable,
            _that.city,
            _that.prodCat,
            _that.socket,
            _that.email);
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
            @JsonKey(name: 'Name') String name,
            @JsonKey(name: 'Surname') String surname,
            @JsonKey(name: 'Contact') String contact,
            @JsonKey(name: 'Country') String country,
            @JsonKey(name: 'State') String state,
            @JsonKey(name: 'PIN') String pin,
            @JsonKey(name: 'Address') String address,
            @JsonKey(name: 'DOP') String dateOfPurchase,
            @JsonKey(name: 'AddOn') String addOn,
            @JsonKey(name: 'Cable') String cable,
            @JsonKey(name: 'City') String city,
            @JsonKey(name: 'ProdCat') String prodCat,
            @JsonKey(name: 'Socket') String socket,
            @JsonKey(name: "Email") String email)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserProfile() when $default != null:
        return $default(
            _that.name,
            _that.surname,
            _that.contact,
            _that.country,
            _that.state,
            _that.pin,
            _that.address,
            _that.dateOfPurchase,
            _that.addOn,
            _that.cable,
            _that.city,
            _that.prodCat,
            _that.socket,
            _that.email);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _UserProfile with DiagnosticableTreeMixin implements UserProfile {
  const _UserProfile(
      {@JsonKey(name: 'Name') required this.name,
      @JsonKey(name: 'Surname') required this.surname,
      @JsonKey(name: 'Contact') required this.contact,
      @JsonKey(name: 'Country') required this.country,
      @JsonKey(name: 'State') required this.state,
      @JsonKey(name: 'PIN') required this.pin,
      @JsonKey(name: 'Address') required this.address,
      @JsonKey(name: 'DOP') required this.dateOfPurchase,
      @JsonKey(name: 'AddOn') required this.addOn,
      @JsonKey(name: 'Cable') required this.cable,
      @JsonKey(name: 'City') required this.city,
      @JsonKey(name: 'ProdCat') required this.prodCat,
      @JsonKey(name: 'Socket') required this.socket,
      @JsonKey(name: "Email") required this.email});
  factory _UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  @override
  @JsonKey(name: 'Name')
  final String name;
  @override
  @JsonKey(name: 'Surname')
  final String surname;
  @override
  @JsonKey(name: 'Contact')
  final String contact;
  @override
  @JsonKey(name: 'Country')
  final String country;
  @override
  @JsonKey(name: 'State')
  final String state;
  @override
  @JsonKey(name: 'PIN')
  final String pin;
  @override
  @JsonKey(name: 'Address')
  final String address;
  @override
  @JsonKey(name: 'DOP')
  final String dateOfPurchase;
  @override
  @JsonKey(name: 'AddOn')
  final String addOn;
  @override
  @JsonKey(name: 'Cable')
  final String cable;
  @override
  @JsonKey(name: 'City')
  final String city;
  @override
  @JsonKey(name: 'ProdCat')
  final String prodCat;
  @override
  @JsonKey(name: 'Socket')
  final String socket;
  @override
  @JsonKey(name: "Email")
  final String email;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserProfileCopyWith<_UserProfile> get copyWith =>
      __$UserProfileCopyWithImpl<_UserProfile>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UserProfileToJson(
      this,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'UserProfile'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('surname', surname))
      ..add(DiagnosticsProperty('contact', contact))
      ..add(DiagnosticsProperty('country', country))
      ..add(DiagnosticsProperty('state', state))
      ..add(DiagnosticsProperty('pin', pin))
      ..add(DiagnosticsProperty('address', address))
      ..add(DiagnosticsProperty('dateOfPurchase', dateOfPurchase))
      ..add(DiagnosticsProperty('addOn', addOn))
      ..add(DiagnosticsProperty('cable', cable))
      ..add(DiagnosticsProperty('city', city))
      ..add(DiagnosticsProperty('prodCat', prodCat))
      ..add(DiagnosticsProperty('socket', socket))
      ..add(DiagnosticsProperty('email', email));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserProfile &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.surname, surname) || other.surname == surname) &&
            (identical(other.contact, contact) || other.contact == contact) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.pin, pin) || other.pin == pin) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.dateOfPurchase, dateOfPurchase) ||
                other.dateOfPurchase == dateOfPurchase) &&
            (identical(other.addOn, addOn) || other.addOn == addOn) &&
            (identical(other.cable, cable) || other.cable == cable) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.prodCat, prodCat) || other.prodCat == prodCat) &&
            (identical(other.socket, socket) || other.socket == socket) &&
            (identical(other.email, email) || other.email == email));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      surname,
      contact,
      country,
      state,
      pin,
      address,
      dateOfPurchase,
      addOn,
      cable,
      city,
      prodCat,
      socket,
      email);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserProfile(name: $name, surname: $surname, contact: $contact, country: $country, state: $state, pin: $pin, address: $address, dateOfPurchase: $dateOfPurchase, addOn: $addOn, cable: $cable, city: $city, prodCat: $prodCat, socket: $socket, email: $email)';
  }
}

/// @nodoc
abstract mixin class _$UserProfileCopyWith<$Res>
    implements $UserProfileCopyWith<$Res> {
  factory _$UserProfileCopyWith(
          _UserProfile value, $Res Function(_UserProfile) _then) =
      __$UserProfileCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'Name') String name,
      @JsonKey(name: 'Surname') String surname,
      @JsonKey(name: 'Contact') String contact,
      @JsonKey(name: 'Country') String country,
      @JsonKey(name: 'State') String state,
      @JsonKey(name: 'PIN') String pin,
      @JsonKey(name: 'Address') String address,
      @JsonKey(name: 'DOP') String dateOfPurchase,
      @JsonKey(name: 'AddOn') String addOn,
      @JsonKey(name: 'Cable') String cable,
      @JsonKey(name: 'City') String city,
      @JsonKey(name: 'ProdCat') String prodCat,
      @JsonKey(name: 'Socket') String socket,
      @JsonKey(name: "Email") String email});
}

/// @nodoc
class __$UserProfileCopyWithImpl<$Res> implements _$UserProfileCopyWith<$Res> {
  __$UserProfileCopyWithImpl(this._self, this._then);

  final _UserProfile _self;
  final $Res Function(_UserProfile) _then;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? surname = null,
    Object? contact = null,
    Object? country = null,
    Object? state = null,
    Object? pin = null,
    Object? address = null,
    Object? dateOfPurchase = null,
    Object? addOn = null,
    Object? cable = null,
    Object? city = null,
    Object? prodCat = null,
    Object? socket = null,
    Object? email = null,
  }) {
    return _then(_UserProfile(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      surname: null == surname
          ? _self.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String,
      contact: null == contact
          ? _self.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _self.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _self.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      pin: null == pin
          ? _self.pin
          : pin // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      dateOfPurchase: null == dateOfPurchase
          ? _self.dateOfPurchase
          : dateOfPurchase // ignore: cast_nullable_to_non_nullable
              as String,
      addOn: null == addOn
          ? _self.addOn
          : addOn // ignore: cast_nullable_to_non_nullable
              as String,
      cable: null == cable
          ? _self.cable
          : cable // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _self.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      prodCat: null == prodCat
          ? _self.prodCat
          : prodCat // ignore: cast_nullable_to_non_nullable
              as String,
      socket: null == socket
          ? _self.socket
          : socket // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
