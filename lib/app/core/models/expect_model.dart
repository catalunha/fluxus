import 'dart:convert';

import 'package:fluxus/app/core/models/event_status_model.dart';
import 'package:fluxus/app/core/models/expertise_model.dart';
import 'package:fluxus/app/core/models/health_plan_model.dart';
import 'package:fluxus/app/core/models/profile_model.dart';

class ExpectModel {
  final String? id;
  final ProfileModel? patient;
  final HealthPlanModel? healthPlan;
  final String? description;
  final ExpertiseModel? expertise;
  final EventStatusModel? eventStatus;
  final bool? isArchived;
  final bool? isDeleted;
  ExpectModel({
    this.id,
    this.patient,
    this.healthPlan,
    this.description,
    this.expertise,
    this.eventStatus,
    this.isArchived,
    this.isDeleted,
  });

  ExpectModel copyWith({
    String? id,
    ProfileModel? patient,
    HealthPlanModel? healthPlan,
    String? description,
    ExpertiseModel? expertise,
    EventStatusModel? eventStatus,
    bool? isArchived,
    bool? isDeleted,
  }) {
    return ExpectModel(
      id: id ?? this.id,
      patient: patient ?? this.patient,
      healthPlan: healthPlan ?? this.healthPlan,
      description: description ?? this.description,
      expertise: expertise ?? this.expertise,
      eventStatus: eventStatus ?? this.eventStatus,
      isArchived: isArchived ?? this.isArchived,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (patient != null) {
      result.addAll({'patient': patient!.toMap()});
    }
    if (healthPlan != null) {
      result.addAll({'healthPlan': healthPlan!.toMap()});
    }
    if (description != null) {
      result.addAll({'description': description});
    }
    if (expertise != null) {
      result.addAll({'expertise': expertise!.toMap()});
    }
    if (eventStatus != null) {
      result.addAll({'eventStatus': eventStatus!.toMap()});
    }
    if (isArchived != null) {
      result.addAll({'isArchived': isArchived});
    }
    if (isDeleted != null) {
      result.addAll({'isDeleted': isDeleted});
    }

    return result;
  }

  factory ExpectModel.fromMap(Map<String, dynamic> map) {
    return ExpectModel(
      id: map['id'],
      patient:
          map['patient'] != null ? ProfileModel.fromMap(map['patient']) : null,
      healthPlan: map['healthPlan'] != null
          ? HealthPlanModel.fromMap(map['healthPlan'])
          : null,
      description: map['description'],
      expertise: map['expertise'] != null
          ? ExpertiseModel.fromMap(map['expertise'])
          : null,
      eventStatus: map['eventStatus'] != null
          ? EventStatusModel.fromMap(map['eventStatus'])
          : null,
      isArchived: map['isArchived'],
      isDeleted: map['isDeleted'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpectModel.fromJson(String source) =>
      ExpectModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ExpectModel(id: $id, patient: $patient, healthPlan: $healthPlan, description: $description, expertise: $expertise, eventStatus: $eventStatus, isArchived: $isArchived, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpectModel &&
        other.id == id &&
        other.patient == patient &&
        other.healthPlan == healthPlan &&
        other.description == description &&
        other.expertise == expertise &&
        other.eventStatus == eventStatus &&
        other.isArchived == isArchived &&
        other.isDeleted == isDeleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        patient.hashCode ^
        healthPlan.hashCode ^
        description.hashCode ^
        expertise.hashCode ^
        eventStatus.hashCode ^
        isArchived.hashCode ^
        isDeleted.hashCode;
  }
}
