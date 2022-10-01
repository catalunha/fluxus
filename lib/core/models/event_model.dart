import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:fluxus/core/models/agreement_model.dart';
import 'package:fluxus/core/models/event_status_model.dart';
import 'package:fluxus/core/models/expertise_model.dart';
import 'package:fluxus/core/models/modality_model.dart';
import 'package:fluxus/core/models/plan_model.dart';
import 'package:fluxus/core/models/profile_model.dart';
import 'package:fluxus/core/models/room_model.dart';
import 'package:fluxus/core/models/user_model.dart';

/// Evento
class EventModel {
  final String? id;
  final List<UserModel>? user;
  final List<UserModel>? professionals;
  final List<ExpertiseModel>? expertise; // especialidade
  final List<ProfileModel>? patients;
  final List<AgreementModel>? agreement; // convenio
  final List<PlanModel>? plan; // plano
  final List<ModalityModel>? modality; // plano
  final RoomModel? room;
  final DateTime? start;
  final DateTime? end;
  final EventStatusModel? status;
  final String? log;
  final String? description;
  final bool? isDeleted;

  EventModel({
    this.id,
    this.user,
    this.professionals,
    this.expertise,
    this.patients,
    this.agreement,
    this.plan,
    this.modality,
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
    List<UserModel>? user,
    List<UserModel>? professionals,
    List<ExpertiseModel>? expertise,
    List<ProfileModel>? patients,
    List<AgreementModel>? agreement,
    List<PlanModel>? plan,
    List<ModalityModel>? modality,
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
      user: user ?? this.user,
      professionals: professionals ?? this.professionals,
      expertise: expertise ?? this.expertise,
      patients: patients ?? this.patients,
      agreement: agreement ?? this.agreement,
      plan: plan ?? this.plan,
      modality: modality ?? this.modality,
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
    if (user != null) {
      result.addAll({'user': user!.map((x) => x.toMap()).toList()});
    }
    if (professionals != null) {
      result.addAll(
          {'professionals': professionals!.map((x) => x.toMap()).toList()});
    }
    if (expertise != null) {
      result.addAll({'expertise': expertise!.map((x) => x.toMap()).toList()});
    }
    if (patients != null) {
      result.addAll({'patients': patients!.map((x) => x.toMap()).toList()});
    }
    if (agreement != null) {
      result.addAll({'agreement': agreement!.map((x) => x.toMap()).toList()});
    }
    if (plan != null) {
      result.addAll({'plan': plan!.map((x) => x.toMap()).toList()});
    }
    if (modality != null) {
      result.addAll({'modality': modality!.map((x) => x.toMap()).toList()});
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
      user: map['user'] != null
          ? List<UserModel>.from(map['user']?.map((x) => UserModel.fromMap(x)))
          : null,
      professionals: map['professionals'] != null
          ? List<UserModel>.from(
              map['professionals']?.map((x) => UserModel.fromMap(x)))
          : null,
      expertise: map['expertise'] != null
          ? List<ExpertiseModel>.from(
              map['expertise']?.map((x) => ExpertiseModel.fromMap(x)))
          : null,
      patients: map['patients'] != null
          ? List<ProfileModel>.from(
              map['patients']?.map((x) => ProfileModel.fromMap(x)))
          : null,
      agreement: map['agreement'] != null
          ? List<AgreementModel>.from(
              map['agreement']?.map((x) => AgreementModel.fromMap(x)))
          : null,
      plan: map['plan'] != null
          ? List<PlanModel>.from(map['plan']?.map((x) => PlanModel.fromMap(x)))
          : null,
      modality: map['modality'] != null
          ? List<ModalityModel>.from(
              map['modality']?.map((x) => ModalityModel.fromMap(x)))
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
    return 'EventModel(id: $id, user: $user, professionals: $professionals, expertise: $expertise, patients: $patients, agreement: $agreement, plan: $plan, modality: $modality, room: $room, start: $start, end: $end, status: $status, log: $log, description: $description, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EventModel &&
        other.id == id &&
        listEquals(other.user, user) &&
        listEquals(other.professionals, professionals) &&
        listEquals(other.expertise, expertise) &&
        listEquals(other.patients, patients) &&
        listEquals(other.agreement, agreement) &&
        listEquals(other.plan, plan) &&
        listEquals(other.modality, modality) &&
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
        user.hashCode ^
        professionals.hashCode ^
        expertise.hashCode ^
        patients.hashCode ^
        agreement.hashCode ^
        plan.hashCode ^
        modality.hashCode ^
        room.hashCode ^
        start.hashCode ^
        end.hashCode ^
        status.hashCode ^
        log.hashCode ^
        description.hashCode ^
        isDeleted.hashCode;
  }
}
