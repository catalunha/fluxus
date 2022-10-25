import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:fluxus/app/core/models/cid_model.dart';
import 'package:fluxus/app/core/models/profile_model.dart';

///Evolução do paciente.
class EvolutionModel {
  final String? id;
  final DateTime? start;
  final String? event;
  final ProfileModel? professional;
  final String? expertise;
  final ProfileModel? patient;
  final List<CidModel>? cid;
  final String? description;
  final String? file;
  final bool? isDeleted;

  EvolutionModel({
    this.id,
    this.start,
    this.event,
    this.professional,
    this.expertise,
    this.patient,
    this.cid,
    this.description,
    this.file,
    this.isDeleted,
  });

  EvolutionModel copyWith({
    String? id,
    DateTime? start,
    String? event,
    ProfileModel? professional,
    String? expertise,
    ProfileModel? patient,
    List<CidModel>? cid,
    String? description,
    String? file,
    bool? isDeleted,
  }) {
    return EvolutionModel(
      id: id ?? this.id,
      start: start ?? this.start,
      event: event ?? this.event,
      professional: professional ?? this.professional,
      expertise: expertise ?? this.expertise,
      patient: patient ?? this.patient,
      cid: cid ?? this.cid,
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
    if (start != null) {
      result.addAll({'start': start!.millisecondsSinceEpoch});
    }
    if (event != null) {
      result.addAll({'event': event});
    }
    if (professional != null) {
      result.addAll({'professional': professional!.toMap()});
    }
    if (expertise != null) {
      result.addAll({'expertise': expertise});
    }
    if (patient != null) {
      result.addAll({'patient': patient!.toMap()});
    }
    if (cid != null) {
      result.addAll({'cid': cid!.map((x) => x.toMap()).toList()});
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
      start: map['start'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['start'])
          : null,
      event: map['event'],
      professional: map['professional'] != null
          ? ProfileModel.fromMap(map['professional'])
          : null,
      expertise: map['expertise'],
      patient:
          map['patient'] != null ? ProfileModel.fromMap(map['patient']) : null,
      cid: map['cid'] != null
          ? List<CidModel>.from(map['cid']?.map((x) => CidModel.fromMap(x)))
          : null,
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
    return 'EvolutionModel(id: $id, start: $start, event: $event, professional: $professional, expertise: $expertise, patient: $patient, cid: $cid, description: $description, file: $file, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EvolutionModel &&
        other.id == id &&
        other.start == start &&
        other.event == event &&
        other.professional == professional &&
        other.expertise == expertise &&
        other.patient == patient &&
        listEquals(other.cid, cid) &&
        other.description == description &&
        other.file == file &&
        other.isDeleted == isDeleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        start.hashCode ^
        event.hashCode ^
        professional.hashCode ^
        expertise.hashCode ^
        patient.hashCode ^
        cid.hashCode ^
        description.hashCode ^
        file.hashCode ^
        isDeleted.hashCode;
  }
}
