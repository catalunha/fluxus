import 'package:fluxus/app/core/models/health_plan_model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class HealthPlanEntity {
  static const String className = 'HealthPlan';

  HealthPlanModel fromParse(ParseObject parseObject) {
    HealthPlanModel model = HealthPlanModel(
      id: parseObject.objectId!,
      profileId: parseObject.get('profileId'),
      name: parseObject.get('name'),
      code: parseObject.get('code'),
      due: parseObject.get('due'),
      description: parseObject.get('description'),
      isDeleted: parseObject.get('isDeleted') ?? false,
    );
    return model;
  }

  ParseObject toParse(HealthPlanModel model) {
    final parseObject = ParseObject(HealthPlanEntity.className);
    if (model.id != null) {
      parseObject.objectId = model.id;
    }
    if (model.profileId != null) {
      parseObject.set('profileId', model.profileId);
    }
    if (model.name != null) {
      parseObject.set('name', model.name);
    }
    if (model.code != null) {
      parseObject.set('code', model.code);
    }
    if (model.due != null) {
      parseObject.set('due', model.due);
    }
    if (model.description != null) {
      parseObject.set('description', model.description);
    }
    if (model.isDeleted != null) {
      parseObject.set('isDeleted', model.isDeleted);
    }

    return parseObject;
  }
}
