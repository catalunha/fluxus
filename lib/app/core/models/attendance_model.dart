import 'dart:convert';

import 'package:fluxus/app/core/models/event_status_model.dart';
import 'package:fluxus/app/core/models/profile_model.dart';

class AttendanceModel {
  final String? id;
  final ProfileModel? professional;
  final String? procedure;
  final ProfileModel? patient;
  final String? healthPlan;
  final String? autorization;
  final DateTime? dStartAutorization;
  final DateTime? dtStartAttendance;
  final DateTime? dtEndAttendance;
  final EventStatusModel? status;
  final String? event;
  final bool? isDeleted;

  AttendanceModel({
    this.id,
    this.professional,
    this.procedure,
    this.patient,
    this.healthPlan,
    this.autorization,
    this.dStartAutorization,
    this.dtStartAttendance,
    this.dtEndAttendance,
    this.status,
    this.event,
    this.isDeleted,
  });

  AttendanceModel copyWith({
    String? id,
    ProfileModel? professional,
    String? procedure,
    ProfileModel? patient,
    String? healthPlan,
    String? autorization,
    DateTime? dStartAutorization,
    DateTime? dtStartAttendance,
    DateTime? dtEndAttendance,
    EventStatusModel? status,
    String? event,
    bool? isDeleted,
  }) {
    return AttendanceModel(
      id: id ?? this.id,
      professional: professional ?? this.professional,
      procedure: procedure ?? this.procedure,
      patient: patient ?? this.patient,
      healthPlan: healthPlan ?? this.healthPlan,
      autorization: autorization ?? this.autorization,
      dStartAutorization: dStartAutorization ?? this.dStartAutorization,
      dtStartAttendance: dtStartAttendance ?? this.dtStartAttendance,
      dtEndAttendance: dtEndAttendance ?? this.dtEndAttendance,
      status: status ?? this.status,
      event: event ?? this.event,
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
    if (procedure != null) {
      result.addAll({'procedure': procedure});
    }
    if (patient != null) {
      result.addAll({'patient': patient!.toMap()});
    }
    if (healthPlan != null) {
      result.addAll({'healthPlan': healthPlan});
    }
    if (autorization != null) {
      result.addAll({'autorization': autorization});
    }
    if (dStartAutorization != null) {
      result.addAll(
          {'dStartAutorization': dStartAutorization!.millisecondsSinceEpoch});
    }
    if (dtStartAttendance != null) {
      result.addAll(
          {'dtStartAttendance': dtStartAttendance!.millisecondsSinceEpoch});
    }
    if (dtEndAttendance != null) {
      result
          .addAll({'dtEndAttendance': dtEndAttendance!.millisecondsSinceEpoch});
    }
    if (status != null) {
      result.addAll({'status': status!.toMap()});
    }
    if (event != null) {
      result.addAll({'event': event});
    }
    if (isDeleted != null) {
      result.addAll({'isDeleted': isDeleted});
    }

    return result;
  }

  factory AttendanceModel.fromMap(Map<String, dynamic> map) {
    return AttendanceModel(
      id: map['id'],
      professional: map['professional'] != null
          ? ProfileModel.fromMap(map['professional'])
          : null,
      procedure: map['procedure'],
      patient:
          map['patient'] != null ? ProfileModel.fromMap(map['patient']) : null,
      healthPlan: map['healthPlan'],
      autorization: map['autorization'],
      dStartAutorization: map['dStartAutorization'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dStartAutorization'])
          : null,
      dtStartAttendance: map['dtStartAttendance'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dtStartAttendance'])
          : null,
      dtEndAttendance: map['dtEndAttendance'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dtEndAttendance'])
          : null,
      status: map['status'] != null
          ? EventStatusModel.fromMap(map['status'])
          : null,
      event: map['event'],
      isDeleted: map['isDeleted'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AttendanceModel.fromJson(String source) =>
      AttendanceModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AttendanceModel(id: $id, professional: $professional, procedure: $procedure, patient: $patient, healthPlan: $healthPlan, autorization: $autorization, dStartAutorization: $dStartAutorization, dtStartAttendance: $dtStartAttendance, dtEndAttendance: $dtEndAttendance, status: $status, event: $event, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AttendanceModel &&
        other.id == id &&
        other.professional == professional &&
        other.procedure == procedure &&
        other.patient == patient &&
        other.healthPlan == healthPlan &&
        other.autorization == autorization &&
        other.dStartAutorization == dStartAutorization &&
        other.dtStartAttendance == dtStartAttendance &&
        other.dtEndAttendance == dtEndAttendance &&
        other.status == status &&
        other.event == event &&
        other.isDeleted == isDeleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        professional.hashCode ^
        procedure.hashCode ^
        patient.hashCode ^
        healthPlan.hashCode ^
        autorization.hashCode ^
        dStartAutorization.hashCode ^
        dtStartAttendance.hashCode ^
        dtEndAttendance.hashCode ^
        status.hashCode ^
        event.hashCode ^
        isDeleted.hashCode;
  }
}
