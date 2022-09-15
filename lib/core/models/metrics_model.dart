import 'dart:convert';

import 'package:fluxus/core/models/schedule_model.dart';
import 'package:fluxus/core/models/user_model.dart';

class MetricsModel {
  final String? id;
  final ScheduleModel? scheduleModel;
  final UserModel? patient;
  final String? key;
  final String? value;
  final String? file;
  final String? description;

  MetricsModel({
    this.id,
    this.scheduleModel,
    this.patient,
    this.key,
    this.value,
    this.file,
    this.description,
  });

  MetricsModel copyWith({
    String? id,
    ScheduleModel? scheduleModel,
    UserModel? patient,
    String? key,
    String? value,
    String? file,
  }) {
    return MetricsModel(
      id: id ?? this.id,
      scheduleModel: scheduleModel ?? this.scheduleModel,
      patient: patient ?? this.patient,
      key: key ?? this.key,
      value: value ?? this.value,
      file: file ?? this.file,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (scheduleModel != null) {
      result.addAll({'scheduleModel': scheduleModel!.toMap()});
    }
    if (patient != null) {
      result.addAll({'patient': patient!.toMap()});
    }
    if (key != null) {
      result.addAll({'key': key});
    }
    if (value != null) {
      result.addAll({'value': value});
    }
    if (file != null) {
      result.addAll({'file': file});
    }

    return result;
  }

  factory MetricsModel.fromMap(Map<String, dynamic> map) {
    return MetricsModel(
      id: map['id'],
      scheduleModel: map['scheduleModel'] != null
          ? ScheduleModel.fromMap(map['scheduleModel'])
          : null,
      patient:
          map['patient'] != null ? UserModel.fromMap(map['patient']) : null,
      key: map['key'],
      value: map['value'],
      file: map['file'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MetricsModel.fromJson(String source) =>
      MetricsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MetricsModel(id: $id, scheduleModel: $scheduleModel, patient: $patient, key: $key, value: $value, file: $file)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MetricsModel &&
        other.id == id &&
        other.scheduleModel == scheduleModel &&
        other.patient == patient &&
        other.key == key &&
        other.value == value &&
        other.file == file;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        scheduleModel.hashCode ^
        patient.hashCode ^
        key.hashCode ^
        value.hashCode ^
        file.hashCode;
  }
}
