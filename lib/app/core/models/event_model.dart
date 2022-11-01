import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:fluxus/app/core/models/attendance_model.dart';
import 'package:fluxus/app/core/models/event_status_model.dart';
import 'package:fluxus/app/core/models/room_model.dart';

/// Evento
class EventModel {
  final String? id;
  final List<AttendanceModel>? attendance;
  final RoomModel? room;
  final DateTime? dtStart;
  final DateTime? dtEnd;
  final EventStatusModel? eventStatus;
  final String? log;
  final String? description;
  final bool? isDeleted;
  EventModel({
    this.id,
    this.attendance,
    this.room,
    this.dtStart,
    this.dtEnd,
    this.eventStatus,
    this.log,
    this.description,
    this.isDeleted,
  });

  EventModel copyWith({
    String? id,
    List<AttendanceModel>? attendance,
    RoomModel? room,
    DateTime? dtStart,
    DateTime? dtEnd,
    EventStatusModel? eventStatus,
    String? log,
    String? description,
    bool? isDeleted,
  }) {
    return EventModel(
      id: id ?? this.id,
      attendance: attendance ?? this.attendance,
      room: room ?? this.room,
      dtStart: dtStart ?? this.dtStart,
      dtEnd: dtEnd ?? this.dtEnd,
      eventStatus: eventStatus ?? this.eventStatus,
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
    if (dtStart != null) {
      result.addAll({'dtStart': dtStart!.millisecondsSinceEpoch});
    }
    if (dtEnd != null) {
      result.addAll({'dtEnd': dtEnd!.millisecondsSinceEpoch});
    }
    if (eventStatus != null) {
      result.addAll({'eventStatus': eventStatus!.toMap()});
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
      dtStart: map['dtStart'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dtStart'])
          : null,
      dtEnd: map['dtEnd'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dtEnd'])
          : null,
      eventStatus: map['eventStatus'] != null
          ? EventStatusModel.fromMap(map['eventStatus'])
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
    return 'EventModel(id: $id, attendance: $attendance, room: $room, dtStart: $dtStart, dtEnd: $dtEnd, eventStatus: $eventStatus, log: $log, description: $description, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EventModel &&
        other.id == id &&
        listEquals(other.attendance, attendance) &&
        other.room == room &&
        other.dtStart == dtStart &&
        other.dtEnd == dtEnd &&
        other.eventStatus == eventStatus &&
        other.log == log &&
        other.description == description &&
        other.isDeleted == isDeleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        attendance.hashCode ^
        room.hashCode ^
        dtStart.hashCode ^
        dtEnd.hashCode ^
        eventStatus.hashCode ^
        log.hashCode ^
        description.hashCode ^
        isDeleted.hashCode;
  }
}
