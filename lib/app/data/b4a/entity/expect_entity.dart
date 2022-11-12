import 'package:fluxus/app/core/models/expect_model.dart';
import 'package:fluxus/app/data/b4a/entity/event_status_entity.dart';
import 'package:fluxus/app/data/b4a/entity/expertise_entity.dart';
import 'package:fluxus/app/data/b4a/entity/health_plan_entity.dart';
import 'package:fluxus/app/data/b4a/entity/profile_entity.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ExpectEntity {
  static const String className = 'Expect';

  ExpectModel fromParse(ParseObject parseObject) {
    ExpectModel model = ExpectModel(
      id: parseObject.objectId!,
      patient: parseObject.get('patient') != null
          ? ProfileEntity()
              .fromParseSimpleData(parseObject.get('patient') as ParseObject)
          : null,
      healthPlan: parseObject.get('healthPlan') != null
          ? HealthPlanEntity()
              .fromParse(parseObject.get('healthPlan') as ParseObject)
          : null,
      description: parseObject.get('description'),
      expertise: parseObject.get('expertise') != null
          ? ExpertiseEntity()
              .fromParse(parseObject.get('expertise') as ParseObject)
          : null,
      eventStatus: parseObject.get('eventStatus') != null
          ? EventStatusEntity()
              .fromParse(parseObject.get('eventStatus') as ParseObject)
          : null,
      isArchived: parseObject.get('isArchived'),
      isDeleted: parseObject.get('isDeleted'),
    );
    return model;
  }

  ParseObject toParse(ExpectModel model) {
    final parseObject = ParseObject(ExpectEntity.className);
    if (model.id != null) {
      parseObject.objectId = model.id;
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
    if (model.description != null) {
      parseObject.set('description', model.description);
    }
    if (model.expertise != null) {
      parseObject.set(
          'expertise',
          (ParseObject(ExpertiseEntity.className)
                ..objectId = model.expertise!.id)
              .toPointer());
    }
    if (model.eventStatus != null) {
      parseObject.set(
          'eventStatus',
          (ParseObject(EventStatusEntity.className)
                ..objectId = model.eventStatus!.id)
              .toPointer());
    }
    if (model.isArchived != null) {
      parseObject.set('isArchived', model.isArchived);
    }

    if (model.isDeleted != null) {
      parseObject.set('isDeleted', model.isDeleted);
    }
    return parseObject;
  }

  ParseObject toParseUnset(String modelId, List<String> unsetFields) {
    final parseObject = ParseObject(ExpectEntity.className);
    parseObject.objectId = modelId;

    for (var field in unsetFields) {
      parseObject.unset(field);
    }

    return parseObject;
  }
}
