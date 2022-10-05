import 'dart:convert';

import 'package:fluxus/core/models/expertise_model.dart';
import 'package:fluxus/core/models/user_model.dart';

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
class EvaluationModel {
  final String? id;
  final UserModel? professional;
  final ExpertiseModel? expertise;
  final String? name;
  final String? description;
  final bool? isDeleted;
  EvaluationModel({
    this.id,
    this.professional,
    this.expertise,
    this.name,
    this.description,
    this.isDeleted,
  });

  EvaluationModel copyWith({
    String? id,
    UserModel? professional,
    ExpertiseModel? expertise,
    String? name,
    String? description,
    bool? isDeleted,
  }) {
    return EvaluationModel(
      id: id ?? this.id,
      professional: professional ?? this.professional,
      expertise: expertise ?? this.expertise,
      name: name ?? this.name,
      description: description ?? this.description,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (professional != null) {
      result.addAll({'professional': professional!.toMap()});
    }
    if (expertise != null) {
      result.addAll({'expertise': expertise!.toMap()});
    }
    if (name != null) {
      result.addAll({'name': name});
    }
    if (description != null) {
      result.addAll({'description': description});
    }
    if (isDeleted != null) {
      result.addAll({'isDeleted': isDeleted});
    }

    return result;
  }

  factory EvaluationModel.fromMap(Map<String, dynamic> map) {
    return EvaluationModel(
      id: map['id'],
      professional: map['professional'] != null
          ? UserModel.fromMap(map['professional'])
          : null,
      expertise: map['expertise'] != null
          ? ExpertiseModel.fromMap(map['expertise'])
          : null,
      name: map['name'],
      description: map['description'],
      isDeleted: map['isDeleted'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EvaluationModel.fromJson(String source) =>
      EvaluationModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EvaluationModel(id: $id, professional: $professional, expertise: $expertise, name: $name, description: $description, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EvaluationModel &&
        other.id == id &&
        other.professional == professional &&
        other.expertise == expertise &&
        other.name == name &&
        other.description == description &&
        other.isDeleted == isDeleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        professional.hashCode ^
        expertise.hashCode ^
        name.hashCode ^
        description.hashCode ^
        isDeleted.hashCode;
  }
}
