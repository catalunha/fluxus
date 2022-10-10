import 'package:fluxus/app/core/models/expertise_model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ExpertiseEntity {
  static const String className = 'Expertise';

  ExpertiseModel fromParse(ParseObject parseObject) {
    ExpertiseModel expertiseModel = ExpertiseModel(
      id: parseObject.objectId!,
      name: parseObject.get('name'),
      description: parseObject.get('description'),
      isDeleted: parseObject.get('isDeleted') ?? false,
    );
    return expertiseModel;
  }
}
