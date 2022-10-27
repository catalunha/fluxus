import 'package:fluxus/app/core/models/attendance_model.dart';
import 'package:fluxus/app/data/b4a/entity/event_status_entity.dart';
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
      procedure: parseObject.get('procedure'),
      patient: parseObject.get('patient') != null
          ? ProfileEntity()
              .fromParseSimpleData(parseObject.get('patient') as ParseObject)
          : null,
      healthPlan: parseObject.get('healthPlan'),
      autorization: parseObject.get('autorization'),
      dStartAutorization:
          parseObject.get<DateTime>('dStartAutorization')?.toLocal(),
      dtStartAttendance:
          parseObject.get<DateTime>('dStartAttendance')?.toLocal(),
      dtEndAttendance: parseObject.get<DateTime>('dEndAttendance')?.toLocal(),
      status: parseObject.get('status') != null
          ? EventStatusEntity()
              .fromParse(parseObject.get('status') as ParseObject)
          : null,
      event: parseObject.get('event'),
      isDeleted: parseObject.get('isDeleted') ?? false,
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
      parseObject.set('procedure', model.procedure);
    }
    if (model.patient != null) {
      parseObject.set(
          'patient',
          (ParseObject(ProfileEntity.className)..objectId = model.patient!.id)
              .toPointer());
    }
    if (model.healthPlan != null) {
      parseObject.set('healthPlan', model.healthPlan);
    }

    if (model.autorization != null) {
      parseObject.set('autorization', model.autorization);
    }
    if (model.dStartAutorization != null) {
      parseObject.set('dStartAutorization', model.dStartAutorization);
    }
    if (model.dtStartAttendance != null) {
      parseObject.set('dtStartAttendance', model.dtStartAttendance);
    }
    if (model.dtEndAttendance != null) {
      parseObject.set('dtEndAttendance', model.dtEndAttendance);
    }
    if (model.status != null) {
      parseObject.set(
          'status',
          (ParseObject(EventStatusEntity.className)
                ..objectId = model.status!.id)
              .toPointer());
    }
    if (model.event != null) {
      parseObject.set('event', model.event);
    }
    if (model.isDeleted != null) {
      parseObject.set('isDeleted', model.isDeleted);
    }
    return parseObject;
  }
}
