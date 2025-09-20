import 'package:equatable/equatable.dart';

enum DemarcheStatus {
  pending,
  inProgress,
  completed,
  cancelled,
}

class Demarche extends Equatable {
  final String id;
  final String title;
  final String description;
  final DemarcheStatus status;
  final String userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? dueDate;
  final List<String> documents;
  final String? notes;

  const Demarche({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    this.dueDate,
    this.documents = const [],
    this.notes,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        status,
        userId,
        createdAt,
        updatedAt,
        dueDate,
        documents,
        notes,
      ];

  Demarche copyWith({
    String? id,
    String? title,
    String? description,
    DemarcheStatus? status,
    String? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? dueDate,
    List<String>? documents,
    String? notes,
  }) {
    return Demarche(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      dueDate: dueDate ?? this.dueDate,
      documents: documents ?? this.documents,
      notes: notes ?? this.notes,
    );
  }
}
