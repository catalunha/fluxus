import 'dart:convert';

/// Convenio do paciente
class HealthPlanModel {
  final String? id;
  final String? profileId;
  final String? name;
  final String? code;
  final DateTime? due;
  final String? description;
  final bool? isDeleted;

  HealthPlanModel({
    this.id,
    this.profileId,
    this.name,
    this.code,
    this.due,
    this.description,
    this.isDeleted,
  });

  HealthPlanModel copyWith({
    String? id,
    String? userId,
    String? name,
    String? code,
    DateTime? due,
    String? description,
    bool? isDeleted,
  }) {
    return HealthPlanModel(
      id: id ?? this.id,
      profileId: userId ?? profileId,
      name: name ?? this.name,
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
      result.addAll({'userId': profileId});
    }
    if (name != null) {
      result.addAll({'name': name});
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
      profileId: map['userId'],
      name: map['name'],
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
    return 'HealthInsuranceModel(id: $id, userId: $profileId, name: $name, code: $code, due: $due, description: $description, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HealthPlanModel &&
        other.id == id &&
        other.profileId == profileId &&
        other.name == name &&
        other.code == code &&
        other.due == due &&
        other.description == description &&
        other.isDeleted == isDeleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        profileId.hashCode ^
        name.hashCode ^
        code.hashCode ^
        due.hashCode ^
        description.hashCode ^
        isDeleted.hashCode;
  }
}
