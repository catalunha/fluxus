import 'dart:convert';

import 'package:fluxus/core/models/event_model.dart';
import 'package:fluxus/core/models/room_model.dart';

/// Agenda dos eventos
class ScheduleModel {
  final String? id;
  final EventModel? event;
  final RoomModel? room;
  final DateTime? start;
  final DateTime? end;
  final bool? isDeleted;

  ScheduleModel({
    this.id,
    this.event,
    this.room,
    this.start,
    this.end,
    this.isDeleted,
  });

  ScheduleModel copyWith({
    String? id,
    EventModel? event,
    RoomModel? room,
    DateTime? start,
    DateTime? end,
    bool? isDeleted,
  }) {
    return ScheduleModel(
      id: id ?? this.id,
      event: event ?? this.event,
      room: room ?? this.room,
      start: start ?? this.start,
      end: end ?? this.end,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (event != null) {
      result.addAll({'event': event!.toMap()});
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
    if (isDeleted != null) {
      result.addAll({'isDeleted': isDeleted});
    }

    return result;
  }

  factory ScheduleModel.fromMap(Map<String, dynamic> map) {
    return ScheduleModel(
      id: map['id'],
      event: map['event'] != null ? EventModel.fromMap(map['event']) : null,
      room: map['room'] != null ? RoomModel.fromMap(map['room']) : null,
      start: map['start'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['start'])
          : null,
      end: map['end'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['end'])
          : null,
      isDeleted: map['isDeleted'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ScheduleModel.fromJson(String source) =>
      ScheduleModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ScheduleModel(id: $id, event: $event, room: $room, start: $start, end: $end, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ScheduleModel &&
        other.id == id &&
        other.event == event &&
        other.room == room &&
        other.start == start &&
        other.end == end &&
        other.isDeleted == isDeleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        event.hashCode ^
        room.hashCode ^
        start.hashCode ^
        end.hashCode ^
        isDeleted.hashCode;
  }
}
