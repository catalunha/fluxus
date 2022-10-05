import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:fluxus/core/models/cid_model.dart';
import 'package:fluxus/core/models/event_model.dart';
import 'package:fluxus/core/models/expertise_model.dart';
import 'package:fluxus/core/models/profile_model.dart';
import 'package:fluxus/core/models/user_model.dart';

///Evolução do paciente.
class EvolutionModel {
  final String? id;
  final EventModel? event;
  final ExpertiseModel? expertise;
  final UserModel? professional;
  final ProfileModel? patient;
  final List<CidModel>? cid;
  final String? description;
  final String? file;
  final bool? isDeleted;

  EvolutionModel({
    this.id,
    this.event,
    this.expertise,
    this.professional,
    this.patient,
    this.cid,
    this.description,
    this.file,
    this.isDeleted,
  });

  EvolutionModel copyWith({
    String? id,
    EventModel? event,
    ExpertiseModel? expertise,
    UserModel? professional,
    ProfileModel? patient,
    List<CidModel>? cid,
    String? description,
    String? file,
    bool? isDeleted,
  }) {
    return EvolutionModel(
      id: id ?? this.id,
      event: event ?? this.event,
      expertise: expertise ?? this.expertise,
      professional: professional ?? this.professional,
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
    if (event != null) {
      result.addAll({'event': event!.toMap()});
    }
    if (expertise != null) {
      result.addAll({'expertise': expertise!.toMap()});
    }
    if (professional != null) {
      result.addAll({'professional': professional!.toMap()});
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
      event: map['event'] != null ? EventModel.fromMap(map['event']) : null,
      expertise: map['expertise'] != null
          ? ExpertiseModel.fromMap(map['expertise'])
          : null,
      professional: map['professional'] != null
          ? UserModel.fromMap(map['professional'])
          : null,
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
    return 'EvolutionModel(id: $id, event: $event, expertise: $expertise, professional: $professional, patient: $patient, cid: $cid, description: $description, file: $file, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EvolutionModel &&
        other.id == id &&
        other.event == event &&
        other.expertise == expertise &&
        other.professional == professional &&
        other.patient == patient &&
        listEquals(other.cid, cid) &&
        other.description == description &&
        other.file == file &&
        other.isDeleted == isDeleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        event.hashCode ^
        expertise.hashCode ^
        professional.hashCode ^
        patient.hashCode ^
        cid.hashCode ^
        description.hashCode ^
        file.hashCode ^
        isDeleted.hashCode;
  }
}
