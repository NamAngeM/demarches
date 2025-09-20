// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guide.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GuideStep _$GuideStepFromJson(Map<String, dynamic> json) => GuideStep(
      stepNumber: (json['stepNumber'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      requirements: (json['requirements'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      estimatedTime: json['estimatedTime'] as String?,
      cost: json['cost'] as String?,
    );

Map<String, dynamic> _$GuideStepToJson(GuideStep instance) => <String, dynamic>{
      'stepNumber': instance.stepNumber,
      'title': instance.title,
      'description': instance.description,
      'requirements': instance.requirements,
      'estimatedTime': instance.estimatedTime,
      'cost': instance.cost,
    };

Guide _$GuideFromJson(Map<String, dynamic> json) => Guide(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      shortDescription: json['shortDescription'] as String,
      category: $enumDecode(_$GuideCategoryEnumMap, json['category']),
      steps: (json['steps'] as List<dynamic>)
          .map((e) => GuideStep.fromJson(e as Map<String, dynamic>))
          .toList(),
      difficulty: json['difficulty'] as String,
      estimatedDuration: json['estimatedDuration'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      imageUrl: json['imageUrl'] as String?,
      isFavorite: json['isFavorite'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$GuideToJson(Guide instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'shortDescription': instance.shortDescription,
      'category': _$GuideCategoryEnumMap[instance.category]!,
      'steps': instance.steps,
      'difficulty': instance.difficulty,
      'estimatedDuration': instance.estimatedDuration,
      'tags': instance.tags,
      'imageUrl': instance.imageUrl,
      'isFavorite': instance.isFavorite,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$GuideCategoryEnumMap = {
  GuideCategory.visa: 'visa',
  GuideCategory.residence: 'residence',
  GuideCategory.university: 'university',
  GuideCategory.work: 'work',
  GuideCategory.health: 'health',
  GuideCategory.banking: 'banking',
  GuideCategory.housing: 'housing',
  GuideCategory.transport: 'transport',
  GuideCategory.culture: 'culture',
  GuideCategory.emergency: 'emergency',
};
