import 'package:equatable/equatable.dart';

enum ChecklistStatus {
  notStarted,
  inProgress,
  completed,
  pending,
  cancelled,
}

enum ChecklistPriority {
  low,
  medium,
  high,
  urgent,
}

class ChecklistItem extends Equatable {
  final String id;
  final String title;
  final String description;
  final ChecklistStatus status;
  final ChecklistPriority priority;
  final DateTime? dueDate;
  final DateTime? completedDate;
  final List<String> requiredDocuments;
  final List<String> steps;
  final String? category;
  final String? location;
  final String? contactInfo;
  final String? website;
  final int estimatedDurationDays;
  final bool isLocationDependent;
  final Map<String, dynamic>? localInfo;

  const ChecklistItem({
    required this.id,
    required this.title,
    required this.description,
    this.status = ChecklistStatus.notStarted,
    this.priority = ChecklistPriority.medium,
    this.dueDate,
    this.completedDate,
    this.requiredDocuments = const [],
    this.steps = const [],
    this.category,
    this.location,
    this.contactInfo,
    this.website,
    this.estimatedDurationDays = 1,
    this.isLocationDependent = false,
    this.localInfo,
  });

  ChecklistItem copyWith({
    String? id,
    String? title,
    String? description,
    ChecklistStatus? status,
    ChecklistPriority? priority,
    DateTime? dueDate,
    DateTime? completedDate,
    List<String>? requiredDocuments,
    List<String>? steps,
    String? category,
    String? location,
    String? contactInfo,
    String? website,
    int? estimatedDurationDays,
    bool? isLocationDependent,
    Map<String, dynamic>? localInfo,
  }) {
    return ChecklistItem(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      dueDate: dueDate ?? this.dueDate,
      completedDate: completedDate ?? this.completedDate,
      requiredDocuments: requiredDocuments ?? this.requiredDocuments,
      steps: steps ?? this.steps,
      category: category ?? this.category,
      location: location ?? this.location,
      contactInfo: contactInfo ?? this.contactInfo,
      website: website ?? this.website,
      estimatedDurationDays: estimatedDurationDays ?? this.estimatedDurationDays,
      isLocationDependent: isLocationDependent ?? this.isLocationDependent,
      localInfo: localInfo ?? this.localInfo,
    );
  }

  bool get isOverdue {
    if (dueDate == null || status == ChecklistStatus.completed) return false;
    return DateTime.now().isAfter(dueDate!);
  }

  bool get isDueSoon {
    if (dueDate == null || status == ChecklistStatus.completed) return false;
    final daysUntilDue = dueDate!.difference(DateTime.now()).inDays;
    return daysUntilDue <= 7 && daysUntilDue >= 0;
  }

  String get statusDisplayName {
    switch (status) {
      case ChecklistStatus.notStarted:
        return 'Non commencé';
      case ChecklistStatus.inProgress:
        return 'En cours';
      case ChecklistStatus.completed:
        return 'Terminé';
      case ChecklistStatus.pending:
        return 'En attente';
      case ChecklistStatus.cancelled:
        return 'Annulé';
    }
  }

  String get priorityDisplayName {
    switch (priority) {
      case ChecklistPriority.low:
        return 'Faible';
      case ChecklistPriority.medium:
        return 'Moyen';
      case ChecklistPriority.high:
        return 'Élevé';
      case ChecklistPriority.urgent:
        return 'Urgent';
    }
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        status,
        priority,
        dueDate,
        completedDate,
        requiredDocuments,
        steps,
        category,
        location,
        contactInfo,
        website,
        estimatedDurationDays,
        isLocationDependent,
        localInfo,
      ];
}
