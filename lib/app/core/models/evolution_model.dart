import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:fluxus/app/core/models/procedure_model.dart';
import 'package:fluxus/app/core/models/profile_model.dart';

///Evolução do paciente.
class EvolutionModel {
  final String? id;
  final DateTime? dtAttendance;
  final String? event;
  final ProfileModel? professional;
  final ProcedureModel? procedure;
  final String? expertise;
  final ProfileModel? patient;
  final List<String>? cid;
  final String? description;
  final String? file;
  final bool? isArchived;
  final bool? isDeleted;

  EvolutionModel({
    this.id,
    this.dtAttendance,
    this.event,
    this.professional,
    this.procedure,
    this.expertise,
    this.patient,
    this.cid,
    this.description,
    this.file,
    this.isArchived,
    this.isDeleted,
  });

  EvolutionModel copyWith({
    String? id,
    DateTime? dtAttendance,
    String? event,
    ProfileModel? professional,
    ProcedureModel? procedure,
    String? expertise,
    ProfileModel? patient,
    List<String>? cid,
    String? description,
    String? file,
    bool? isArchived,
    bool? isDeleted,
  }) {
    return EvolutionModel(
      id: id ?? this.id,
      dtAttendance: dtAttendance ?? this.dtAttendance,
      event: event ?? this.event,
      professional: professional ?? this.professional,
      procedure: procedure ?? this.procedure,
      expertise: expertise ?? this.expertise,
      patient: patient ?? this.patient,
      cid: cid ?? this.cid,
      description: description ?? this.description,
      file: file ?? this.file,
      isArchived: isArchived ?? this.isArchived,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (dtAttendance != null) {
      result.addAll({'dtAttendance': dtAttendance!.millisecondsSinceEpoch});
    }
    if (event != null) {
      result.addAll({'event': event});
    }
    if (professional != null) {
      result.addAll({'professional': professional!.toMap()});
    }
    if (procedure != null) {
      result.addAll({'procedure': procedure!.toMap()});
    }
    if (expertise != null) {
      result.addAll({'expertise': expertise});
    }
    if (patient != null) {
      result.addAll({'patient': patient!.toMap()});
    }
    if (cid != null) {
      result.addAll({'cid': cid});
    }
    if (description != null) {
      result.addAll({'description': description});
    }
    if (file != null) {
      result.addAll({'file': file});
    }
    if (isArchived != null) {
      result.addAll({'isArchived': isArchived});
    }
    if (isDeleted != null) {
      result.addAll({'isDeleted': isDeleted});
    }

    return result;
  }

  factory EvolutionModel.fromMap(Map<String, dynamic> map) {
    return EvolutionModel(
      id: map['id'],
      dtAttendance: map['dtAttendance'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dtAttendance'])
          : null,
      event: map['event'],
      professional: map['professional'] != null
          ? ProfileModel.fromMap(map['professional'])
          : null,
      procedure: map['procedure'] != null
          ? ProcedureModel.fromMap(map['procedure'])
          : null,
      expertise: map['expertise'],
      patient:
          map['patient'] != null ? ProfileModel.fromMap(map['patient']) : null,
      cid: List<String>.from(map['cid']),
      description: map['description'],
      file: map['file'],
      isArchived: map['isArchived'],
      isDeleted: map['isDeleted'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EvolutionModel.fromJson(String source) =>
      EvolutionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EvolutionModel(id: $id, dtAttendance: $dtAttendance, event: $event, professional: $professional, procedure: $procedure, expertise: $expertise, patient: $patient, cid: $cid, description: $description, file: $file, isArchived: $isArchived, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EvolutionModel &&
        other.id == id &&
        other.dtAttendance == dtAttendance &&
        other.event == event &&
        other.professional == professional &&
        other.procedure == procedure &&
        other.expertise == expertise &&
        other.patient == patient &&
        listEquals(other.cid, cid) &&
        other.description == description &&
        other.file == file &&
        other.isArchived == isArchived &&
        other.isDeleted == isDeleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        dtAttendance.hashCode ^
        event.hashCode ^
        professional.hashCode ^
        procedure.hashCode ^
        expertise.hashCode ^
        patient.hashCode ^
        cid.hashCode ^
        description.hashCode ^
        file.hashCode ^
        isArchived.hashCode ^
        isDeleted.hashCode;
  }
}
