import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/demarche.dart';

part 'demarche_model.g.dart';

@JsonSerializable()
class DemarcheModel extends Demarche {
  const DemarcheModel({
    required super.id,
    required super.title,
    required super.description,
    required super.status,
    required super.userId,
    required super.createdAt,
    required super.updatedAt,
    super.dueDate,
    super.documents = const [],
    super.notes,
  });

  factory DemarcheModel.fromJson(Map<String, dynamic> json) =>
      _$DemarcheModelFromJson(json);

  Map<String, dynamic> toJson() => _$DemarcheModelToJson(this);

  factory DemarcheModel.fromEntity(Demarche demarche) {
    return DemarcheModel(
      id: demarche.id,
      title: demarche.title,
      description: demarche.description,
      status: demarche.status,
      userId: demarche.userId,
      createdAt: demarche.createdAt,
      updatedAt: demarche.updatedAt,
      dueDate: demarche.dueDate,
      documents: demarche.documents,
      notes: demarche.notes,
    );
  }

  Demarche toEntity() {
    return Demarche(
      id: id,
      title: title,
      description: description,
      status: status,
      userId: userId,
      createdAt: createdAt,
      updatedAt: updatedAt,
      dueDate: dueDate,
      documents: documents,
      notes: notes,
    );
  }
}
