import 'package:fluxus/app/core/models/health_plan_type_model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class HealthPlanTypeEntity {
  static const String className = 'HealthPlanType';

  HealthPlanTypeModel fromParse(ParseObject parseObject) {
    HealthPlanTypeModel expertiseModel = HealthPlanTypeModel(
      id: parseObject.objectId!,
      name: parseObject.get('name') ?? 'jkl',
      isDeleted: parseObject.get('isDeleted') ?? false,
    );
    return expertiseModel;
  }
}
