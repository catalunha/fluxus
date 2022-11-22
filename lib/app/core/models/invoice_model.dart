// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:fluxus/app/core/models/attendance_model.dart';

class InvoiceModel {
  final String? id;
  final List<AttendanceModel>? attendance;
  final DateTime? dtStart;
  final DateTime? dtEnd;
  final String? description;
  final bool? isDeleted;
  InvoiceModel({
    this.id,
    this.attendance,
    this.dtStart,
    this.dtEnd,
    this.description,
    this.isDeleted,
  });

  InvoiceModel copyWith({
    String? id,
    List<AttendanceModel>? attendance,
    DateTime? dtStart,
    DateTime? dtEnd,
    String? description,
    bool? isDeleted,
  }) {
    return InvoiceModel(
      id: id ?? this.id,
      attendance: attendance ?? this.attendance,
      dtStart: dtStart ?? this.dtStart,
      dtEnd: dtEnd ?? this.dtEnd,
      description: description ?? this.description,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (attendance != null) {
      result.addAll({'attendance': attendance!.map((x) => x.toMap()).toList()});
    }
    if (dtStart != null) {
      result.addAll({'dtStart': dtStart!.millisecondsSinceEpoch});
    }
    if (dtEnd != null) {
      result.addAll({'dtEnd': dtEnd!.millisecondsSinceEpoch});
    }
    if (description != null) {
      result.addAll({'description': description});
    }
    if (isDeleted != null) {
      result.addAll({'isDeleted': isDeleted});
    }

    return result;
  }

  factory InvoiceModel.fromMap(Map<String, dynamic> map) {
    return InvoiceModel(
      id: map['id'],
      attendance: map['attendance'] != null
          ? List<AttendanceModel>.from(
              map['attendance']?.map((x) => AttendanceModel.fromMap(x)))
          : null,
      dtStart: map['dtStart'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dtStart'])
          : null,
      dtEnd: map['dtEnd'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dtEnd'])
          : null,
      description: map['description'],
      isDeleted: map['isDeleted'],
    );
  }

  String toJson() => json.encode(toMap());

  factory InvoiceModel.fromJson(String source) =>
      InvoiceModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'InvoiceModel(id: $id, attendance: $attendance, dtStart: $dtStart, dtEnd: $dtEnd, description: $description, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InvoiceModel &&
        other.id == id &&
        listEquals(other.attendance, attendance) &&
        other.dtStart == dtStart &&
        other.dtEnd == dtEnd &&
        other.description == description &&
        other.isDeleted == isDeleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        attendance.hashCode ^
        dtStart.hashCode ^
        dtEnd.hashCode ^
        description.hashCode ^
        isDeleted.hashCode;
  }
}
