import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tip.g.dart';

enum TipCategory {
  general,
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

extension TipCategoryExtension on TipCategory {
  String get displayName {
    switch (this) {
      case TipCategory.general:
        return 'Général';
      case TipCategory.visa:
        return 'Visa';
      case TipCategory.residence:
        return 'Résidence';
      case TipCategory.university:
        return 'Université';
      case TipCategory.work:
        return 'Travail';
      case TipCategory.health:
        return 'Santé';
      case TipCategory.banking:
        return 'Banque';
      case TipCategory.housing:
        return 'Logement';
      case TipCategory.transport:
        return 'Transport';
      case TipCategory.culture:
        return 'Culture';
      case TipCategory.emergency:
        return 'Urgences';
    }
  }
}

@JsonSerializable()
class Tip extends Equatable {
  final String id;
  final String title;
  final String description;
  final TipCategory category;
  final String? imageUrl;
  final List<String> tags;
  final bool isImportant;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Tip({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    this.imageUrl,
    this.tags = const [],
    this.isImportant = false,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Tip.fromJson(Map<String, dynamic> json) => _$TipFromJson(json);
  Map<String, dynamic> toJson() => _$TipToJson(this);

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        category,
        imageUrl,
        tags,
        isImportant,
        createdAt,
        updatedAt,
      ];

  Tip copyWith({
    String? id,
    String? title,
    String? description,
    TipCategory? category,
    String? imageUrl,
    List<String>? tags,
    bool? isImportant,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Tip(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      tags: tags ?? this.tags,
      isImportant: isImportant ?? this.isImportant,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
