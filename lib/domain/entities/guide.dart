import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';

part 'guide.g.dart';

enum GuideCategory {
  visa,
  residence,
  university,
  work,
  health,
  banking,
  housing,
  transport,
  culture,
  emergency,
}

extension GuideCategoryExtension on GuideCategory {
  String get displayName {
    switch (this) {
      case GuideCategory.visa:
        return 'Visa';
      case GuideCategory.residence:
        return 'Résidence';
      case GuideCategory.university:
        return 'Université';
      case GuideCategory.work:
        return 'Travail';
      case GuideCategory.health:
        return 'Santé';
      case GuideCategory.banking:
        return 'Banque';
      case GuideCategory.housing:
        return 'Logement';
      case GuideCategory.transport:
        return 'Transport';
      case GuideCategory.culture:
        return 'Culture';
      case GuideCategory.emergency:
        return 'Urgences';
    }
  }

  IconData get icon {
    switch (this) {
      case GuideCategory.visa:
        return Icons.credit_card;
      case GuideCategory.residence:
        return Icons.home;
      case GuideCategory.university:
        return Icons.school;
      case GuideCategory.work:
        return Icons.work;
      case GuideCategory.health:
        return Icons.health_and_safety;
      case GuideCategory.banking:
        return Icons.account_balance;
      case GuideCategory.housing:
        return Icons.home_work;
      case GuideCategory.transport:
        return Icons.directions_bus;
      case GuideCategory.culture:
        return Icons.museum;
      case GuideCategory.emergency:
        return Icons.emergency;
    }
  }
}

@JsonSerializable()
class GuideStep {
  final int stepNumber;
  final String title;
  final String description;
  final List<String>? requirements;
  final String? estimatedTime;
  final String? cost;

  const GuideStep({
    required this.stepNumber,
    required this.title,
    required this.description,
    this.requirements,
    this.estimatedTime,
    this.cost,
  });

  factory GuideStep.fromJson(Map<String, dynamic> json) => _$GuideStepFromJson(json);
  Map<String, dynamic> toJson() => _$GuideStepToJson(this);

  GuideStep copyWith({
    int? stepNumber,
    String? title,
    String? description,
    List<String>? requirements,
    String? estimatedTime,
    String? cost,
  }) {
    return GuideStep(
      stepNumber: stepNumber ?? this.stepNumber,
      title: title ?? this.title,
      description: description ?? this.description,
      requirements: requirements ?? this.requirements,
      estimatedTime: estimatedTime ?? this.estimatedTime,
      cost: cost ?? this.cost,
    );
  }
}

@JsonSerializable()
class Guide extends Equatable {
  final String id;
  final String title;
  final String description;
  final String shortDescription;
  final GuideCategory category;
  final List<GuideStep> steps;
  final String difficulty; // Facile, Moyen, Difficile
  final String estimatedDuration; // Ex: "2-3 semaines"
  final List<String> tags;
  final String? imageUrl;
  final bool isFavorite;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Guide({
    required this.id,
    required this.title,
    required this.description,
    required this.shortDescription,
    required this.category,
    required this.steps,
    required this.difficulty,
    required this.estimatedDuration,
    required this.tags,
    this.imageUrl,
    this.isFavorite = false,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Guide.fromJson(Map<String, dynamic> json) => _$GuideFromJson(json);
  Map<String, dynamic> toJson() => _$GuideToJson(this);

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        shortDescription,
        category,
        steps,
        difficulty,
        estimatedDuration,
        tags,
        imageUrl,
        isFavorite,
        createdAt,
        updatedAt,
      ];

  Guide copyWith({
    String? id,
    String? title,
    String? description,
    String? shortDescription,
    GuideCategory? category,
    List<GuideStep>? steps,
    String? difficulty,
    String? estimatedDuration,
    List<String>? tags,
    String? imageUrl,
    bool? isFavorite,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Guide(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      shortDescription: shortDescription ?? this.shortDescription,
      category: category ?? this.category,
      steps: steps ?? this.steps,
      difficulty: difficulty ?? this.difficulty,
      estimatedDuration: estimatedDuration ?? this.estimatedDuration,
      tags: tags ?? this.tags,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  String get categoryDisplayName {
    switch (category) {
      case GuideCategory.visa:
        return 'Visa';
      case GuideCategory.residence:
        return 'Résidence';
      case GuideCategory.university:
        return 'Université';
      case GuideCategory.work:
        return 'Travail';
      case GuideCategory.health:
        return 'Santé';
      case GuideCategory.banking:
        return 'Banque';
      case GuideCategory.housing:
        return 'Logement';
      case GuideCategory.transport:
        return 'Transport';
      case GuideCategory.culture:
        return 'Culture';
      case GuideCategory.emergency:
        return 'Urgences';
    }
  }

  String get categoryIcon {
    switch (category) {
      case GuideCategory.visa:
        return '🛂';
      case GuideCategory.residence:
        return '🏠';
      case GuideCategory.university:
        return '🎓';
      case GuideCategory.work:
        return '💼';
      case GuideCategory.health:
        return '🏥';
      case GuideCategory.banking:
        return '🏦';
      case GuideCategory.housing:
        return '🏡';
      case GuideCategory.transport:
        return '🚌';
      case GuideCategory.culture:
        return '🎭';
      case GuideCategory.emergency:
        return '🚨';
    }
  }
}
