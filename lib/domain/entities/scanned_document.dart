import 'package:equatable/equatable.dart';

enum DocumentType {
  passport,
  visa,
  birthCertificate,
  diploma,
  transcript,
  insurance,
  bankStatement,
  rentContract,
  other,
}

class ScannedDocument extends Equatable {
  final String id;
  final String name;
  final DocumentType type;
  final String imagePath;
  final DateTime scannedAt;
  final String? notes;
  final bool isImportant;
  final String? category;

  const ScannedDocument({
    required this.id,
    required this.name,
    required this.type,
    required this.imagePath,
    required this.scannedAt,
    this.notes,
    this.isImportant = false,
    this.category,
  });

  ScannedDocument copyWith({
    String? id,
    String? name,
    DocumentType? type,
    String? imagePath,
    DateTime? scannedAt,
    String? notes,
    bool? isImportant,
    String? category,
  }) {
    return ScannedDocument(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      imagePath: imagePath ?? this.imagePath,
      scannedAt: scannedAt ?? this.scannedAt,
      notes: notes ?? this.notes,
      isImportant: isImportant ?? this.isImportant,
      category: category ?? this.category,
    );
  }

  String get typeDisplayName {
    switch (type) {
      case DocumentType.passport:
        return 'Passeport';
      case DocumentType.visa:
        return 'Visa';
      case DocumentType.birthCertificate:
        return 'Acte de naissance';
      case DocumentType.diploma:
        return 'Diplôme';
      case DocumentType.transcript:
        return 'Relevé de notes';
      case DocumentType.insurance:
        return 'Assurance';
      case DocumentType.bankStatement:
        return 'Relevé bancaire';
      case DocumentType.rentContract:
        return 'Contrat de location';
      case DocumentType.other:
        return 'Autre';
    }
  }

  static String getTypeDisplayName(DocumentType type) {
    switch (type) {
      case DocumentType.passport:
        return 'Passeport';
      case DocumentType.visa:
        return 'Visa';
      case DocumentType.birthCertificate:
        return 'Acte de naissance';
      case DocumentType.diploma:
        return 'Diplôme';
      case DocumentType.transcript:
        return 'Relevé de notes';
      case DocumentType.insurance:
        return 'Assurance';
      case DocumentType.bankStatement:
        return 'Relevé bancaire';
      case DocumentType.rentContract:
        return 'Contrat de location';
      case DocumentType.other:
        return 'Autre';
    }
  }

  String get typeIcon {
    switch (type) {
      case DocumentType.passport:
        return '🛂';
      case DocumentType.visa:
        return '📋';
      case DocumentType.birthCertificate:
        return '📄';
      case DocumentType.diploma:
        return '🎓';
      case DocumentType.transcript:
        return '📊';
      case DocumentType.insurance:
        return '🛡️';
      case DocumentType.bankStatement:
        return '💳';
      case DocumentType.rentContract:
        return '🏠';
      case DocumentType.other:
        return '📁';
    }
  }

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        imagePath,
        scannedAt,
        notes,
        isImportant,
        category,
      ];
}
