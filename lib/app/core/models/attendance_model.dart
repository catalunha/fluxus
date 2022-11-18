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
  final DateTime? dtAttendance;
  final EventStatusModel? eventStatus;
  final String? event;
  final String? evolution;
  final String? description;
  final bool? isDeleted;
  final bool? confirmedPresence;

  AttendanceModel({
    this.id,
    this.professional,
    this.procedure,
    this.patient,
    this.healthPlan,
    this.autorization,
    this.dAutorization,
    this.dtAttendance,
    this.eventStatus,
    this.event,
    this.evolution,
    this.description,
    this.isDeleted,
    this.confirmedPresence,
  });

  AttendanceModel copyWith({
    String? id,
    ProfileModel? professional,
    ProcedureModel? procedure,
    ProfileModel? patient,
    HealthPlanModel? healthPlan,
    String? autorization,
    DateTime? dAutorization,
    DateTime? dtAttendance,
    EventStatusModel? eventStatus,
    String? event,
    String? evolution,
    String? description,
    bool? isDeleted,
    bool? confirmedPresence,
  }) {
    return AttendanceModel(
      id: id ?? this.id,
      professional: professional ?? this.professional,
      procedure: procedure ?? this.procedure,
      patient: patient ?? this.patient,
      healthPlan: healthPlan ?? this.healthPlan,
      autorization: autorization ?? this.autorization,
      dAutorization: dAutorization ?? this.dAutorization,
      dtAttendance: dtAttendance ?? this.dtAttendance,
      eventStatus: eventStatus ?? this.eventStatus,
      event: event ?? this.event,
      evolution: evolution ?? this.evolution,
      description: description ?? this.description,
      isDeleted: isDeleted ?? this.isDeleted,
      confirmedPresence: confirmedPresence ?? this.confirmedPresence,
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
    if (dtAttendance != null) {
      result.addAll({'dtAttendance': dtAttendance!.millisecondsSinceEpoch});
    }
    if (eventStatus != null) {
      result.addAll({'eventStatus': eventStatus!.toMap()});
    }
    if (event != null) {
      result.addAll({'event': event});
    }
    if (evolution != null) {
      result.addAll({'evolution': evolution});
    }
    if (description != null) {
      result.addAll({'description': description});
    }
    if (isDeleted != null) {
      result.addAll({'isDeleted': isDeleted});
    }
    if (confirmedPresence != null) {
      result.addAll({'confirmedPresence': confirmedPresence});
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
      dtAttendance: map['dtAttendance'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dtAttendance'])
          : null,
      eventStatus: map['eventStatus'] != null
          ? EventStatusModel.fromMap(map['eventStatus'])
          : null,
      event: map['event'],
      evolution: map['evolution'],
      description: map['description'],
      isDeleted: map['isDeleted'],
      confirmedPresence: map['confirmedPresence'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AttendanceModel.fromJson(String source) =>
      AttendanceModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AttendanceModel(id: $id, professional: $professional, procedure: $procedure, patient: $patient, healthPlan: $healthPlan, autorization: $autorization, dAutorization: $dAutorization, dtAttendance: $dtAttendance, eventStatus: $eventStatus, event: $event, evolution: $evolution, description: $description, isDeleted: $isDeleted, confirmedPresence: $confirmedPresence)';
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
        other.dtAttendance == dtAttendance &&
        other.eventStatus == eventStatus &&
        other.event == event &&
        other.evolution == evolution &&
        other.description == description &&
        other.isDeleted == isDeleted &&
        other.confirmedPresence == confirmedPresence;
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
        dtAttendance.hashCode ^
        eventStatus.hashCode ^
        event.hashCode ^
        evolution.hashCode ^
        description.hashCode ^
        isDeleted.hashCode ^
        confirmedPresence.hashCode;
  }
}
