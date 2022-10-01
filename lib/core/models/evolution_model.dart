import 'dart:convert';

import 'package:fluxus/core/models/event_model.dart';
import 'package:fluxus/core/models/expertise_model.dart';
import 'package:fluxus/core/models/profile_model.dart';
import 'package:fluxus/core/models/user_model.dart';

///Evolução do paciente.
class EvolutionModel {
  final String? id;
  final EventModel? event;
  final ExpertiseModel? expertiseModel;
  final UserModel? professional;
  final ProfileModel? patient;
  final String? description;
  final String? file;
  final bool? isDeleted;

  EvolutionModel({
    this.id,
    this.event,
    this.expertiseModel,
    this.professional,
    this.patient,
    this.description,
    this.file,
    this.isDeleted,
  });

  EvolutionModel copyWith({
    String? id,
    EventModel? event,
    ExpertiseModel? expertiseModel,
    UserModel? professional,
    ProfileModel? patient,
    String? description,
    String? file,
    bool? isDeleted,
  }) {
    return EvolutionModel(
      id: id ?? this.id,
      event: event ?? this.event,
      expertiseModel: expertiseModel ?? this.expertiseModel,
      professional: professional ?? this.professional,
      patient: patient ?? this.patient,
      description: description ?? this.description,
      file: file ?? this.file,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (event != null) {
      result.addAll({'event': event!.toMap()});
    }
    if (expertiseModel != null) {
      result.addAll({'expertiseModel': expertiseModel!.toMap()});
    }
    if (professional != null) {
      result.addAll({'professional': professional!.toMap()});
    }
    if (patient != null) {
      result.addAll({'patient': patient!.toMap()});
    }
    if (description != null) {
      result.addAll({'description': description});
    }
    if (file != null) {
      result.addAll({'file': file});
    }
    if (isDeleted != null) {
      result.addAll({'isDeleted': isDeleted});
    }

    return result;
  }

  factory EvolutionModel.fromMap(Map<String, dynamic> map) {
    return EvolutionModel(
      id: map['id'],
      event: map['event'] != null ? EventModel.fromMap(map['event']) : null,
      expertiseModel: map['expertiseModel'] != null
          ? ExpertiseModel.fromMap(map['expertiseModel'])
          : null,
      professional: map['professional'] != null
          ? UserModel.fromMap(map['professional'])
          : null,
      patient:
          map['patient'] != null ? ProfileModel.fromMap(map['patient']) : null,
      description: map['description'],
      file: map['file'],
      isDeleted: map['isDeleted'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EvolutionModel.fromJson(String source) =>
      EvolutionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EvolutionModel(id: $id, event: $event, expertiseModel: $expertiseModel, professional: $professional, patient: $patient, description: $description, file: $file, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EvolutionModel &&
        other.id == id &&
        other.event == event &&
        other.expertiseModel == expertiseModel &&
        other.professional == professional &&
        other.patient == patient &&
        other.description == description &&
        other.file == file &&
        other.isDeleted == isDeleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        event.hashCode ^
        expertiseModel.hashCode ^
        professional.hashCode ^
        patient.hashCode ^
        description.hashCode ^
        file.hashCode ^
        isDeleted.hashCode;
  }
}
