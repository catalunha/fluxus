import 'dart:convert';

import 'package:fluxus/app/core/models/drop_down_abstract.dart';

class HealthPlanTypeModel extends DropDrowAbstract {
  final String? id;
  // final String? name;
  final bool? isDeleted;
  HealthPlanTypeModel({
    this.id,
    super.name,
    // this.name,
    this.isDeleted,
  });

  HealthPlanTypeModel copyWith({
    String? id,
    String? name,
    bool? isDeleted,
  }) {
    return HealthPlanTypeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (name != null) {
      result.addAll({'name': name});
    }
    if (isDeleted != null) {
      result.addAll({'isDeleted': isDeleted});
    }

    return result;
  }

  factory HealthPlanTypeModel.fromMap(Map<String, dynamic> map) {
    return HealthPlanTypeModel(
      id: map['id'],
      name: map['name'],
      isDeleted: map['isDeleted'],
    );
  }

  String toJson() => json.encode(toMap());

  factory HealthPlanTypeModel.fromJson(String source) =>
      HealthPlanTypeModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'HealthPlanTypeModel(id: $id, name: $name, isDeleted: $isDeleted)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HealthPlanTypeModel &&
        other.id == id &&
        other.name == name &&
        other.isDeleted == isDeleted;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ isDeleted.hashCode;
}
