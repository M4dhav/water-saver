// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => _UserProfile(
      name: json['Name'] as String,
      surname: json['Surname'] as String,
      contact: json['Contact'] as String,
      country: json['Country'] as String,
      state: json['State'] as String,
      pin: json['PIN'] as String,
      address: json['Address'] as String,
      dateOfPurchase: json['DOP'] as String,
      addOn: json['AddOn'] as String,
      cable: json['Cable'] as String,
      city: json['City'] as String,
      prodCat: json['ProdCat'] as String,
      socket: json['Socket'] as String,
      email: json['Email'] as String,
    );

Map<String, dynamic> _$UserProfileToJson(_UserProfile instance) =>
    <String, dynamic>{
      'Name': instance.name,
      'Surname': instance.surname,
      'Contact': instance.contact,
      'Country': instance.country,
      'State': instance.state,
      'PIN': instance.pin,
      'Address': instance.address,
      'DOP': instance.dateOfPurchase,
      'AddOn': instance.addOn,
      'Cable': instance.cable,
      'City': instance.city,
      'ProdCat': instance.prodCat,
      'Socket': instance.socket,
      'Email': instance.email,
    };
