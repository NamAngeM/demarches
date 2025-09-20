// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tip _$TipFromJson(Map<String, dynamic> json) => Tip(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      category: $enumDecode(_$TipCategoryEnumMap, json['category']),
      imageUrl: json['imageUrl'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      isImportant: json['isImportant'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$TipToJson(Tip instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'category': _$TipCategoryEnumMap[instance.category]!,
      'imageUrl': instance.imageUrl,
      'tags': instance.tags,
      'isImportant': instance.isImportant,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$TipCategoryEnumMap = {
  TipCategory.general: 'general',
  TipCategory.visa: 'visa',
  TipCategory.residence: 'residence',
  TipCategory.university: 'university',
  TipCategory.work: 'work',
  TipCategory.health: 'health',
  TipCategory.banking: 'banking',
  TipCategory.housing: 'housing',
  TipCategory.transport: 'transport',
  TipCategory.culture: 'culture',
  TipCategory.emergency: 'emergency',
};
