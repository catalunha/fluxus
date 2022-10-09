import 'package:fluxus/app/core/models/health_plan_model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class HealthPlanEntity {
  static const String className = 'HealthPlan';

  Future<HealthPlanModel> fromParse(ParseObject parseObject) async {
    HealthPlanModel profileModel = HealthPlanModel(
      id: parseObject.objectId!,
      profileId: parseObject.get('profileId'),
      name: parseObject.get('name'),
      code: parseObject.get('code'),
      due: parseObject.get('due'),
      description: parseObject.get('description'),
      isDeleted: parseObject.get('isDeleted') ?? false,
    );
    return profileModel;
  }

  Future<ParseObject> toParse(HealthPlanModel profileModel) async {
    final profileParseObject = ParseObject(HealthPlanEntity.className);
    if (profileModel.id != null) {
      profileParseObject.objectId = profileModel.id;
    }
    if (profileModel.profileId != null) {
      profileParseObject.set('profileId', profileModel.profileId);
    }
    if (profileModel.name != null) {
      profileParseObject.set('name', profileModel.name);
    }
    if (profileModel.code != null) {
      profileParseObject.set('code', profileModel.code);
    }
    if (profileModel.due != null) {
      profileParseObject.set('due', profileModel.due);
    }
    if (profileModel.description != null) {
      profileParseObject.set('description', profileModel.description);
    }
    if (profileModel.isDeleted != null) {
      profileParseObject.set('isDeleted', profileModel.isDeleted);
    }

    return profileParseObject;
  }
}
