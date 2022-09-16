import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:fluxus/core/models/room_model.dart';
import 'package:fluxus/core/models/user_model.dart';

class EventModel {
  final String? id;
  final List<UserModel>? professionals;
  final List<UserModel>? patients;
  final RoomModel? room;
  final DateTime? start;
  final DateTime? end;
  final String? status;
  final String? description;
  EventModel({
    this.id,
    this.professionals,
    this.patients,
    this.room,
    this.start,
    this.end,
    this.status,
    this.description,
  });

  EventModel copyWith({
    String? id,
    List<UserModel>? professionals,
    List<UserModel>? patients,
    RoomModel? room,
    DateTime? start,
    DateTime? end,
    String? status,
    String? description,
  }) {
    return EventModel(
      id: id ?? this.id,
      professionals: professionals ?? this.professionals,
      patients: patients ?? this.patients,
      room: room ?? this.room,
      start: start ?? this.start,
      end: end ?? this.end,
      status: status ?? this.status,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (professionals != null) {
      result.addAll(
          {'professionals': professionals!.map((x) => x.toMap()).toList()});
    }
    if (patients != null) {
      result.addAll({'patients': patients!.map((x) => x.toMap()).toList()});
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
      result.addAll({'status': status});
    }
    if (description != null) {
      result.addAll({'description': description});
    }

    return result;
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      id: map['id'],
      professionals: map['professionals'] != null
          ? List<UserModel>.from(
              map['professionals']?.map((x) => UserModel.fromMap(x)))
          : null,
      patients: map['patients'] != null
          ? List<UserModel>.from(
              map['patients']?.map((x) => UserModel.fromMap(x)))
          : null,
      room: map['room'] != null ? RoomModel.fromMap(map['room']) : null,
      start: map['start'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['start'])
          : null,
      end: map['end'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['end'])
          : null,
      status: map['status'],
      description: map['description'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EventModel.fromJson(String source) =>
      EventModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EventModel(id: $id, professionals: $professionals, patients: $patients, room: $room, start: $start, end: $end, status: $status, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EventModel &&
        other.id == id &&
        listEquals(other.professionals, professionals) &&
        listEquals(other.patients, patients) &&
        other.room == room &&
        other.start == start &&
        other.end == end &&
        other.status == status &&
        other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        professionals.hashCode ^
        patients.hashCode ^
        room.hashCode ^
        start.hashCode ^
        end.hashCode ^
        status.hashCode ^
        description.hashCode;
  }
}
