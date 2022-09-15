import 'dart:convert';

import 'package:fluxus/core/models/event_model.dart';
import 'package:fluxus/core/models/user_model.dart';

class PersonBookModel {
  final String? id;
  final EventModel? event;
  final UserModel? professional;
  final UserModel? patient;
  final String? description;
  final String? file;
  PersonBookModel({
    this.id,
    this.event,
    this.professional,
    this.patient,
    this.description,
    this.file,
  });

  PersonBookModel copyWith({
    String? id,
    EventModel? event,
    UserModel? professional,
    UserModel? patient,
    String? description,
    String? file,
  }) {
    return PersonBookModel(
      id: id ?? this.id,
      event: event ?? this.event,
      professional: professional ?? this.professional,
      patient: patient ?? this.patient,
      description: description ?? this.description,
      file: file ?? this.file,
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

    return result;
  }

  factory PersonBookModel.fromMap(Map<String, dynamic> map) {
    return PersonBookModel(
      id: map['id'],
      event: map['event'] != null ? EventModel.fromMap(map['event']) : null,
      professional: map['professional'] != null
          ? UserModel.fromMap(map['professional'])
          : null,
      patient:
          map['patient'] != null ? UserModel.fromMap(map['patient']) : null,
      description: map['description'],
      file: map['file'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PersonBookModel.fromJson(String source) =>
      PersonBookModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PersonBookModel(id: $id, event: $event, professional: $professional, patient: $patient, description: $description, file: $file)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PersonBookModel &&
        other.id == id &&
        other.event == event &&
        other.professional == professional &&
        other.patient == patient &&
        other.description == description &&
        other.file == file;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        event.hashCode ^
        professional.hashCode ^
        patient.hashCode ^
        description.hashCode ^
        file.hashCode;
  }
}
