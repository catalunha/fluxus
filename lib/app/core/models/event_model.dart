import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:fluxus/app/core/models/attendance_model.dart';
import 'package:fluxus/app/core/models/event_status_model.dart';
import 'package:fluxus/app/core/models/profile_model.dart';
import 'package:fluxus/app/core/models/room_model.dart';

/// Evento
class EventModel {
  final String? id;
  final List<AttendanceModel>? attendance;

  // final List<ProfileModel>? professionals;
  // final Map<String, String>? procedures; // procedimento
  // final List<ProfileModel>? patients;
  // final Map<String, String>? healthPlans; // Convenios
  // final String? autorization;
  // final String? fatura;

  final RoomModel? room;
  final DateTime? start;
  final DateTime? end;
  final EventStatusModel? status;
  final String? log;
  final String? description;
  final bool? isDeleted;

  EventModel({
    this.id,
    this.attendance,
    this.room,
    this.start,
    this.end,
    this.status,
    this.log,
    this.description,
    this.isDeleted,
  });

  EventModel copyWith({
    String? id,
    List<AttendanceModel>? attendance,
    RoomModel? room,
    DateTime? start,
    DateTime? end,
    EventStatusModel? status,
    String? log,
    String? description,
    bool? isDeleted,
  }) {
    return EventModel(
      id: id ?? this.id,
      attendance: attendance ?? this.attendance,
      room: room ?? this.room,
      start: start ?? this.start,
      end: end ?? this.end,
      status: status ?? this.status,
      log: log ?? this.log,
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
    if (room != null) {
      result.addAll({'room': room!.toMap()});
    }
    if (start != null) {
      result.addAll({'start': start!.millisecondsSinceEpoch});
    }
    if (end != null) {
      result.addAll({'end': end!.millisecondsSinceEpoch});
    }
    if (status != null) {
      result.addAll({'status': status!.toMap()});
    }
    if (log != null) {
      result.addAll({'log': log});
    }
    if (description != null) {
      result.addAll({'description': description});
    }
    if (isDeleted != null) {
      result.addAll({'isDeleted': isDeleted});
    }

    return result;
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      id: map['id'],
      attendance: map['attendance'] != null
          ? List<AttendanceModel>.from(
              map['attendance']?.map((x) => AttendanceModel.fromMap(x)))
          : null,
      room: map['room'] != null ? RoomModel.fromMap(map['room']) : null,
      start: map['start'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['start'])
          : null,
      end: map['end'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['end'])
          : null,
      status: map['status'] != null
          ? EventStatusModel.fromMap(map['status'])
          : null,
      log: map['log'],
      description: map['description'],
      isDeleted: map['isDeleted'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EventModel.fromJson(String source) =>
      EventModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EventModel(id: $id, attendance: $attendance, room: $room, start: $start, end: $end, status: $status, log: $log, description: $description, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EventModel &&
        other.id == id &&
        listEquals(other.attendance, attendance) &&
        other.room == room &&
        other.start == start &&
        other.end == end &&
        other.status == status &&
        other.log == log &&
        other.description == description &&
        other.isDeleted == isDeleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        attendance.hashCode ^
        room.hashCode ^
        start.hashCode ^
        end.hashCode ^
        status.hashCode ^
        log.hashCode ^
        description.hashCode ^
        isDeleted.hashCode;
  }
}
