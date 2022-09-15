import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:fluxus/core/models/room_model.dart';
import 'package:fluxus/core/models/schedule_status_model.dart';
import 'package:fluxus/core/models/user_model.dart';

class ScheduleModel {
  final String? id;
  final List<UserModel>? professional;
  final List<UserModel>? patient;
  final RoomModel? room;
  final DateTime? start;
  final DateTime? end;
  final ScheduleStatusModel? status;
  final String? description;
  final String? observation;
  ScheduleModel({
    this.id,
    this.professional,
    this.patient,
    this.room,
    this.start,
    this.end,
    this.status,
    this.description,
    this.observation,
  });

  ScheduleModel copyWith({
    String? id,
    List<UserModel>? professional,
    List<UserModel>? patient,
    RoomModel? room,
    DateTime? start,
    DateTime? end,
    ScheduleStatusModel? status,
    String? description,
    String? observation,
  }) {
    return ScheduleModel(
      id: id ?? this.id,
      professional: professional ?? this.professional,
      patient: patient ?? this.patient,
      room: room ?? this.room,
      start: start ?? this.start,
      end: end ?? this.end,
      status: status ?? this.status,
      description: description ?? this.description,
      observation: observation ?? this.observation,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (professional != null) {
      result.addAll(
          {'professional': professional!.map((x) => x.toMap()).toList()});
    }
    if (patient != null) {
      result.addAll({'patient': patient!.map((x) => x.toMap()).toList()});
    }
    if (room != null) {
      result.addAll({'room': room!.toMap()});
    }
    if (start != null) {
      result.addAll({'start': start!.millisecondsSinceEpoch});
    }
    if (end != null) {
      result.addAll({'end': end!.millisecondsSinceEpoch});
    }
    if (status != null) {
      result.addAll({'status': status!.toMap()});
    }
    if (description != null) {
      result.addAll({'description': description});
    }
    if (observation != null) {
      result.addAll({'observation': observation});
    }

    return result;
  }

  factory ScheduleModel.fromMap(Map<String, dynamic> map) {
    return ScheduleModel(
      id: map['id'],
      professional: map['professional'] != null
          ? List<UserModel>.from(
              map['professional']?.map((x) => UserModel.fromMap(x)))
          : null,
      patient: map['patient'] != null
          ? List<UserModel>.from(
              map['patient']?.map((x) => UserModel.fromMap(x)))
          : null,
      room: map['room'] != null ? RoomModel.fromMap(map['room']) : null,
      start: map['start'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['start'])
          : null,
      end: map['end'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['end'])
          : null,
      status: map['status'] != null
          ? ScheduleStatusModel.fromMap(map['status'])
          : null,
      description: map['description'],
      observation: map['observation'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ScheduleModel.fromJson(String source) =>
      ScheduleModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ScheduleModel(id: $id, professional: $professional, patient: $patient, room: $room, start: $start, end: $end, status: $status, description: $description, observation: $observation)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ScheduleModel &&
        other.id == id &&
        listEquals(other.professional, professional) &&
        listEquals(other.patient, patient) &&
        other.room == room &&
        other.start == start &&
        other.end == end &&
        other.status == status &&
        other.description == description &&
        other.observation == observation;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        professional.hashCode ^
        patient.hashCode ^
        room.hashCode ^
        start.hashCode ^
        end.hashCode ^
        status.hashCode ^
        description.hashCode ^
        observation.hashCode;
  }
}
