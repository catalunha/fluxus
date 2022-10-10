import 'package:fluxus/app/core/models/health_plan_model.dart';
import 'package:fluxus/app/data/b4a/entity/health_plan_type_entity.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class HealthPlanEntity {
  static const String className = 'HealthPlan';

  HealthPlanModel fromParse(ParseObject parseObject) {
    print('-*-*-*-*-*-*-*-*');
    print('${parseObject.get('healthPlanType')}');
    print('-*-*-*-*-*-*-*-*');
    HealthPlanModel model = HealthPlanModel(
      id: parseObject.objectId!,
      profileId: parseObject.get('profileId'),
      healthPlanType: parseObject.get('healthPlanType') != null
          ? HealthPlanTypeEntity()
              .fromParse(parseObject.get('healthPlanType') as ParseObject)
          : null,
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
    if (model.healthPlanType != null) {
      parseObject.set(
          'healthPlanType',
          (ParseObject(HealthPlanTypeEntity.className)
                ..objectId = model.healthPlanType!.id)
              .toPointer());
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
