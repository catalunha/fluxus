import 'dart:convert';

import 'package:fluxus/core/models/user_model.dart';

class ScheduleProfessionalModel {
  final String? id;
  final UserModel professional;
  final String occupation;
  ScheduleProfessionalModel({
    this.id,
    required this.professional,
    required this.occupation,
  });

  ScheduleProfessionalModel copyWith({
    String? id,
    UserModel? professional,
    String? occupation,
  }) {
    return ScheduleProfessionalModel(
      id: id ?? this.id,
      professional: professional ?? this.professional,
      occupation: occupation ?? this.occupation,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'professional': professional.toMap()});
    result.addAll({'occupation': occupation});

    return result;
  }

  factory ScheduleProfessionalModel.fromMap(Map<String, dynamic> map) {
    return ScheduleProfessionalModel(
      id: map['id'],
      professional: UserModel.fromMap(map['professional']),
      occupation: map['occupation'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ScheduleProfessionalModel.fromJson(String source) =>
      ScheduleProfessionalModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'ScheduleProfessionalModel(id: $id, professional: $professional, occupation: $occupation)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ScheduleProfessionalModel &&
        other.id == id &&
        other.professional == professional &&
        other.occupation == occupation;
  }

  @override
  int get hashCode => id.hashCode ^ professional.hashCode ^ occupation.hashCode;
}
