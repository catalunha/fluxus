import 'package:fluxus/app/core/models/attendance_model.dart';
import 'package:fluxus/app/data/b4a/entity/event_status_entity.dart';
import 'package:fluxus/app/data/b4a/entity/health_plan_entity.dart';
import 'package:fluxus/app/data/b4a/entity/procedure_entity.dart';
import 'package:fluxus/app/data/b4a/entity/profile_entity.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class AttendanceEntity {
  static const String className = 'Attendance';

  AttendanceModel fromParse(ParseObject parseObject) {
    AttendanceModel model = AttendanceModel(
      id: parseObject.objectId!,
      professional: parseObject.get('professional') != null
          ? ProfileEntity().fromParseSimpleData(
              parseObject.get('professional') as ParseObject)
          : null,
      procedure: parseObject.get('procedure') != null
          ? ProcedureEntity()
              .fromParse(parseObject.get('procedure') as ParseObject)
          : null,
      patient: parseObject.get('patient') != null
          ? ProfileEntity()
              .fromParseSimpleData(parseObject.get('patient') as ParseObject)
          : null,
      healthPlan: parseObject.get('healthPlan') != null
          ? HealthPlanEntity()
              .fromParse(parseObject.get('healthPlan') as ParseObject)
          : null,
      autorization: parseObject.get('autorization'),
      dAutorization: parseObject.get<DateTime>('dAutorization')?.toLocal(),
      dtAttendance: parseObject.get<DateTime>('dtAttendance')?.toLocal(),
      // dtEndtAttendance: parseObject.get<DateTime>('dtEndtAttendance')?.toLocal(),
      eventStatus: parseObject.get('eventStatus') != null
          ? EventStatusEntity()
              .fromParse(parseObject.get('eventStatus') as ParseObject)
          : null,
      event: parseObject.get('event'),
      evolution: parseObject.get('evolution'),
      description: parseObject.get('description'),
      isDeleted: parseObject.get('isDeleted') ?? false,
      confirmedPresence: parseObject.get('confirmedPresence'),
    );
    return model;
  }

  ParseObject toParse(AttendanceModel model) {
    final parseObject = ParseObject(AttendanceEntity.className);
    if (model.id != null) {
      parseObject.objectId = model.id;
    }

    if (model.professional != null) {
      parseObject.set(
          'professional',
          (ParseObject(ProfileEntity.className)
                ..objectId = model.professional!.id)
              .toPointer());
    }
    if (model.procedure != null) {
      parseObject.set(
          'procedure',
          (ParseObject(ProcedureEntity.className)
                ..objectId = model.procedure!.id)
              .toPointer());
    }

    if (model.patient != null) {
      parseObject.set(
          'patient',
          (ParseObject(ProfileEntity.className)..objectId = model.patient!.id)
              .toPointer());
    }
    if (model.healthPlan != null) {
      parseObject.set(
          'healthPlan',
          (ParseObject(HealthPlanEntity.className)
                ..objectId = model.healthPlan!.id)
              .toPointer());
    }

    if (model.autorization != null) {
      parseObject.set('autorization', model.autorization);
    }
    if (model.dAutorization != null) {
      parseObject.set('dAutorization', model.dAutorization);
    }
    if (model.dtAttendance != null) {
      parseObject.set('dtAttendance', model.dtAttendance);
    }
    // if (model.dtEndtAttendance != null) {
    //   parseObject.set('dtEndtAttendance', model.dtEndtAttendance);
    // }
    if (model.eventStatus != null) {
      parseObject.set(
          'eventStatus',
          (ParseObject(EventStatusEntity.className)
                ..objectId = model.eventStatus!.id)
              .toPointer());
    }
    if (model.event != null) {
      parseObject.set('event', model.event);
    }
    if (model.evolution != null) {
      parseObject.set('evolution', model.evolution);
    }
    if (model.description != null) {
      parseObject.set('description', model.description);
    }
    if (model.isDeleted != null) {
      parseObject.set('isDeleted', model.isDeleted);
    }
    if (model.confirmedPresence != null) {
      parseObject.set('confirmedPresence', model.confirmedPresence);
    }
    return parseObject;
  }

  ParseObject toParseUnset(String modelId, List<String> unsetFields) {
    final parseObject = ParseObject(AttendanceEntity.className);
    parseObject.objectId = modelId;

    for (var field in unsetFields) {
      parseObject.unset(field);
    }

    return parseObject;
  }
}
