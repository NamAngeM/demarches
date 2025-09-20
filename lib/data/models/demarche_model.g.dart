// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'demarche_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DemarcheModel _$DemarcheModelFromJson(Map<String, dynamic> json) =>
    DemarcheModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      status: $enumDecode(_$DemarcheStatusEnumMap, json['status']),
      userId: json['userId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      dueDate: json['dueDate'] == null
          ? null
          : DateTime.parse(json['dueDate'] as String),
      documents: (json['documents'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$DemarcheModelToJson(DemarcheModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'status': _$DemarcheStatusEnumMap[instance.status]!,
      'userId': instance.userId,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'dueDate': instance.dueDate?.toIso8601String(),
      'documents': instance.documents,
      'notes': instance.notes,
    };

const _$DemarcheStatusEnumMap = {
  DemarcheStatus.pending: 'pending',
  DemarcheStatus.inProgress: 'inProgress',
  DemarcheStatus.completed: 'completed',
  DemarcheStatus.cancelled: 'cancelled',
};
