import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_profile.g.dart';

enum UserLevel {
  bachelor,
  master,
  phd,
  exchange,
  language,
}

extension UserLevelExtension on UserLevel {
  String get displayName {
    switch (this) {
      case UserLevel.bachelor:
        return 'Licence';
      case UserLevel.master:
        return 'Master';
      case UserLevel.phd:
        return 'Doctorat';
      case UserLevel.exchange:
        return 'Échange';
      case UserLevel.language:
        return 'Langue';
    }
  }

  String get description {
    switch (this) {
      case UserLevel.bachelor:
        return 'Études de premier cycle (3 ans)';
      case UserLevel.master:
        return 'Études de deuxième cycle (2 ans)';
      case UserLevel.phd:
        return 'Études de troisième cycle (3-6 ans)';
      case UserLevel.exchange:
        return 'Programme d\'échange (1-2 semestres)';
      case UserLevel.language:
        return 'Cours de langue française';
    }
  }
}

@JsonSerializable()
class UserProfile extends Equatable {
  final String id;
  final String email;
  final String? displayName;
  final String? photoUrl;
  final String? country;
  final String? countryOfOrigin;
  final String? university;
  final UserLevel? level;
  final String? city;
  final String? phoneNumber;
  final bool? isFirstTime;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Map<String, dynamic>? preferences;

  const UserProfile({
    required this.id,
    required this.email,
    this.displayName,
    this.photoUrl,
    this.country,
    this.countryOfOrigin,
    this.university,
    this.level,
    this.city,
    this.phoneNumber,
    this.isFirstTime,
    this.createdAt,
    this.updatedAt,
    this.preferences,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);
  Map<String, dynamic> toJson() => _$UserProfileToJson(this);

  UserProfile copyWith({
    String? id,
    String? email,
    String? displayName,
    String? photoUrl,
    String? country,
    String? countryOfOrigin,
    String? university,
    UserLevel? level,
    String? city,
    String? phoneNumber,
    bool? isFirstTime,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, dynamic>? preferences,
  }) {
    return UserProfile(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      country: country ?? this.country,
      countryOfOrigin: countryOfOrigin ?? this.countryOfOrigin,
      university: university ?? this.university,
      level: level ?? this.level,
      city: city ?? this.city,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isFirstTime: isFirstTime ?? this.isFirstTime,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      preferences: preferences ?? this.preferences,
    );
  }

  @override
  List<Object?> get props => [
        id,
        email,
        displayName,
        photoUrl,
        country,
        university,
        level,
        city,
        phoneNumber,
        isFirstTime,
        createdAt,
        updatedAt,
        preferences,
      ];

  // Getters pour la compatibilité
  String? get levelDisplayName => level?.displayName;
}