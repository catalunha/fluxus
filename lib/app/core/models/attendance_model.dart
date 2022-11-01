import 'dart:convert';

import 'package:fluxus/app/core/models/event_status_model.dart';
import 'package:fluxus/app/core/models/health_plan_model.dart';
import 'package:fluxus/app/core/models/procedure_model.dart';
import 'package:fluxus/app/core/models/profile_model.dart';

class AttendanceModel {
  final String? id;
  final ProfileModel? professional;
  final ProcedureModel? procedure;
  final ProfileModel? patient;
  final HealthPlanModel? healthPlan;
  final String? autorization;
  final DateTime? dAutorization;
  final DateTime? dAttendance;
  final EventStatusModel? eventStatus;
  final String? event;
  final bool? isDeleted;

  AttendanceModel({
    this.id,
    this.professional,
    this.procedure,
    this.patient,
    this.healthPlan,
    this.autorization,
    this.dAutorization,
    this.dAttendance,
    this.eventStatus,
    this.event,
    this.isDeleted,
  });

  AttendanceModel copyWith({
    String? id,
    ProfileModel? professional,
    ProcedureModel? procedure,
    ProfileModel? patient,
    HealthPlanModel? healthPlan,
    String? autorization,
    DateTime? dAutorization,
    DateTime? dAttendance,
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
      dAutorization: dAutorization ?? this.dAutorization,
      dAttendance: dAttendance ?? this.dAttendance,
      eventStatus: status ?? eventStatus,
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
      result.addAll({'procedure': procedure!.toMap()});
    }
    if (patient != null) {
      result.addAll({'patient': patient!.toMap()});
    }
    if (healthPlan != null) {
      result.addAll({'healthPlan': healthPlan!.toMap()});
    }
    if (autorization != null) {
      result.addAll({'autorization': autorization});
    }
    if (dAutorization != null) {
      result.addAll({'dAutorization': dAutorization!.millisecondsSinceEpoch});
    }
    if (dAttendance != null) {
      result.addAll({'dAttendance': dAttendance!.millisecondsSinceEpoch});
    }
    if (eventStatus != null) {
      result.addAll({'status': eventStatus!.toMap()});
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
      procedure: map['procedure'] != null
          ? ProcedureModel.fromMap(map['procedure'])
          : null,
      patient:
          map['patient'] != null ? ProfileModel.fromMap(map['patient']) : null,
      healthPlan: map['healthPlan'] != null
          ? HealthPlanModel.fromMap(map['healthPlan'])
          : null,
      autorization: map['autorization'],
      dAutorization: map['dAutorization'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dAutorization'])
          : null,
      dAttendance: map['dAttendance'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dAttendance'])
          : null,
      eventStatus: map['status'] != null
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
    return 'AttendanceModel(id: $id, professional: $professional, procedure: $procedure, patient: $patient, healthPlan: $healthPlan, autorization: $autorization, dAutorization: $dAutorization, dAttendance: $dAttendance, status: $eventStatus, event: $event, isDeleted: $isDeleted)';
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
        other.dAutorization == dAutorization &&
        other.dAttendance == dAttendance &&
        other.eventStatus == eventStatus &&
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
        dAutorization.hashCode ^
        dAttendance.hashCode ^
        eventStatus.hashCode ^
        event.hashCode ^
        isDeleted.hashCode;
  }
}
