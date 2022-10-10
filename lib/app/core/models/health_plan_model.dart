import 'dart:convert';

import 'package:fluxus/app/core/models/health_plan_type_model.dart';

/// Convenio do paciente
class HealthPlanModel {
  final String? id;
  final String? profileId;
  final HealthPlanTypeModel? healthPlanType;
  final String? code;
  final DateTime? due;
  final String? description;
  final bool? isDeleted;

  HealthPlanModel({
    this.id,
    this.profileId,
    this.healthPlanType,
    this.code,
    this.due,
    this.description,
    this.isDeleted,
  });

  HealthPlanModel copyWith({
    String? id,
    String? profileId,
    HealthPlanTypeModel? healthPlanType,
    String? code,
    DateTime? due,
    String? description,
    bool? isDeleted,
  }) {
    return HealthPlanModel(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      healthPlanType: healthPlanType ?? this.healthPlanType,
      code: code ?? this.code,
      due: due ?? this.due,
      description: description ?? this.description,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (profileId != null) {
      result.addAll({'profileId': profileId});
    }
    if (healthPlanType != null) {
      result.addAll({'healthPlanType': healthPlanType!.toMap()});
    }
    if (code != null) {
      result.addAll({'code': code});
    }
    if (due != null) {
      result.addAll({'due': due!.millisecondsSinceEpoch});
    }
    if (description != null) {
      result.addAll({'description': description});
    }
    if (isDeleted != null) {
      result.addAll({'isDeleted': isDeleted});
    }

    return result;
  }

  factory HealthPlanModel.fromMap(Map<String, dynamic> map) {
    return HealthPlanModel(
      id: map['id'],
      profileId: map['profileId'],
      healthPlanType: map['healthPlanType'] != null
          ? HealthPlanTypeModel.fromMap(map['healthPlanType'])
          : null,
      code: map['code'],
      due: map['due'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['due'])
          : null,
      description: map['description'],
      isDeleted: map['isDeleted'],
    );
  }

  String toJson() => json.encode(toMap());

  factory HealthPlanModel.fromJson(String source) =>
      HealthPlanModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HealthPlanModel(id: $id, profileId: $profileId, healthPlanType: $healthPlanType, code: $code, due: $due, description: $description, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HealthPlanModel &&
        other.id == id &&
        other.profileId == profileId &&
        other.healthPlanType == healthPlanType &&
        other.code == code &&
        other.due == due &&
        other.description == description &&
        other.isDeleted == isDeleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        profileId.hashCode ^
        healthPlanType.hashCode ^
        code.hashCode ^
        due.hashCode ^
        description.hashCode ^
        isDeleted.hashCode;
  }
}
