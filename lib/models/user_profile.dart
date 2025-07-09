import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'generated/user_profile.freezed.dart';
part 'generated/user_profile.g.dart';

@freezed
abstract class UserProfile with _$UserProfile {
  const factory UserProfile({
    @JsonKey(name: 'Name') required String name,
    @JsonKey(name: 'Surname') required String surname,
    @JsonKey(name: 'Contact') required String contact,
    @JsonKey(name: 'Country') required String country,
    @JsonKey(name: 'State') required String state,
    @JsonKey(name: 'PIN') required String pin,
    @JsonKey(name: 'Address') required String address,
    @JsonKey(name: 'DOP') required String dateOfPurchase,
    @JsonKey(name: 'AddOn') required String addOn,
    @JsonKey(name: 'Cable') required String cable,
    @JsonKey(name: 'City') required String city,
    @JsonKey(name: 'ProdCat') required String prodCat,
    @JsonKey(name: 'Socket') required String socket,
    @JsonKey(name: "Email") required String email,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, Object?> json) =>
      _$UserProfileFromJson(json);
}
