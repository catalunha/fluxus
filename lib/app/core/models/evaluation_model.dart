import 'dart:convert';

import 'package:fluxus/app/core/utils/drop_down_abstract.dart';

/// Avaliação do paciente.
/// Ficha padrão com.
///
/// Pergunta 1: Bla bla bla..
///
/// pa pa pa ...
///
/// Opção 2:  Bla bla bla..
///
/// ( x ) A (  ) B
///
/// Escolha 3:  Bla bla bla..
///
/// [ x ] A [ x ] B [  ] C
///
class EvaluationModel extends DropDrowAbstract {
  final String? id;
  final String? professionalId;
  final String? expertiseId;
  // final String? name;
  final String? description;
  final bool? isPublic;
  final bool? isDeleted;
  EvaluationModel({
    this.id,
    this.professionalId,
    this.expertiseId,
    super.name,
    this.description,
    this.isPublic = false,
    this.isDeleted,
  });

  EvaluationModel copyWith({
    String? id,
    String? professionalId,
    String? expertiseId,
    String? name,
    String? description,
    bool? isPublic,
    bool? isDeleted,
  }) {
    return EvaluationModel(
      id: id ?? this.id,
      professionalId: professionalId ?? this.professionalId,
      expertiseId: expertiseId ?? this.expertiseId,
      name: name ?? this.name,
      description: description ?? this.description,
      isPublic: isPublic ?? this.isPublic,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (professionalId != null) {
      result.addAll({'professionalId': professionalId});
    }
    if (expertiseId != null) {
      result.addAll({'expertiseId': expertiseId});
    }
    if (name != null) {
      result.addAll({'name': name});
    }
    if (description != null) {
      result.addAll({'description': description});
    }
    if (isPublic != null) {
      result.addAll({'isPublic': isPublic});
    }
    if (isDeleted != null) {
      result.addAll({'isDeleted': isDeleted});
    }

    return result;
  }

  factory EvaluationModel.fromMap(Map<String, dynamic> map) {
    return EvaluationModel(
      id: map['id'],
      professionalId: map['professionalId'],
      expertiseId: map['expertiseId'],
      name: map['name'],
      description: map['description'],
      isPublic: map['isPublic'],
      isDeleted: map['isDeleted'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EvaluationModel.fromJson(String source) =>
      EvaluationModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EvaluationModel(id: $id, professionalId: $professionalId, expertiseId: $expertiseId, name: $name, description: $description, isPublic: $isPublic, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EvaluationModel &&
        other.id == id &&
        other.professionalId == professionalId &&
        other.expertiseId == expertiseId &&
        other.name == name &&
        other.description == description &&
        other.isPublic == isPublic &&
        other.isDeleted == isDeleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        professionalId.hashCode ^
        expertiseId.hashCode ^
        name.hashCode ^
        description.hashCode ^
        isPublic.hashCode ^
        isDeleted.hashCode;
  }
}
