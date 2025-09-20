// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
      id: json['id'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String?,
      photoUrl: json['photoUrl'] as String?,
      country: json['country'] as String?,
      countryOfOrigin: json['countryOfOrigin'] as String?,
      university: json['university'] as String?,
      level: $enumDecodeNullable(_$UserLevelEnumMap, json['level']),
      city: json['city'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      isFirstTime: json['isFirstTime'] as bool?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      preferences: json['preferences'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'displayName': instance.displayName,
      'photoUrl': instance.photoUrl,
      'country': instance.country,
      'university': instance.university,
      'level': _$UserLevelEnumMap[instance.level],
      'city': instance.city,
      'phoneNumber': instance.phoneNumber,
      'isFirstTime': instance.isFirstTime,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'preferences': instance.preferences,
      'countryOfOrigin': instance.countryOfOrigin,
    };

const _$UserLevelEnumMap = {
  UserLevel.bachelor: 'bachelor',
  UserLevel.master: 'master',
  UserLevel.phd: 'phd',
  UserLevel.exchange: 'exchange',
  UserLevel.language: 'language',
};
