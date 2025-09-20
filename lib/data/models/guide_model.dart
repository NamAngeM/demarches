import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/guide.dart';

part 'guide_model.g.dart';

@JsonSerializable()
class GuideModel extends Guide {
  const GuideModel({
    required super.id,
    required super.title,
    required super.description,
    required super.shortDescription,
    required super.category,
    required super.steps,
    required super.difficulty,
    required super.estimatedDuration,
    required super.tags,
    super.imageUrl,
    super.isFavorite = false,
    required super.createdAt,
    required super.updatedAt,
  });

  factory GuideModel.fromJson(Map<String, dynamic> json) =>
      _$GuideModelFromJson(json);

  Map<String, dynamic> toJson() => _$GuideModelToJson(this);

  factory GuideModel.fromEntity(Guide guide) {
    return GuideModel(
      id: guide.id,
      title: guide.title,
      description: guide.description,
      shortDescription: guide.shortDescription,
      category: guide.category,
      steps: guide.steps,
      difficulty: guide.difficulty,
      estimatedDuration: guide.estimatedDuration,
      tags: guide.tags,
      imageUrl: guide.imageUrl,
      isFavorite: guide.isFavorite,
      createdAt: guide.createdAt,
      updatedAt: guide.updatedAt,
    );
  }

  Guide toEntity() {
    return Guide(
      id: id,
      title: title,
      description: description,
      shortDescription: shortDescription,
      category: category,
      steps: steps,
      difficulty: difficulty,
      estimatedDuration: estimatedDuration,
      tags: tags,
      imageUrl: imageUrl,
      isFavorite: isFavorite,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

@JsonSerializable()
class GuideStepModel extends GuideStep {
  const GuideStepModel({
    required super.stepNumber,
    required super.title,
    required super.description,
    super.requirements,
    super.estimatedTime,
    super.cost,
  });

  factory GuideStepModel.fromJson(Map<String, dynamic> json) =>
      _$GuideStepModelFromJson(json);

  Map<String, dynamic> toJson() => _$GuideStepModelToJson(this);

  factory GuideStepModel.fromEntity(GuideStep step) {
    return GuideStepModel(
      stepNumber: step.stepNumber,
      title: step.title,
      description: step.description,
      requirements: step.requirements,
      estimatedTime: step.estimatedTime,
      cost: step.cost,
    );
  }

  GuideStep toEntity() {
    return GuideStep(
      stepNumber: stepNumber,
      title: title,
      description: description,
      requirements: requirements,
      estimatedTime: estimatedTime,
      cost: cost,
    );
  }
}
