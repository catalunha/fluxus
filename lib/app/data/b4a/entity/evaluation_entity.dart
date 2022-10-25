import 'package:fluxus/app/core/models/evaluation_model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class EvaluationEntity {
  static const String className = 'Evaluation';

  EvaluationModel fromParse(ParseObject parseObject) {
    EvaluationModel model = EvaluationModel(
      id: parseObject.objectId!,
      professionalId: parseObject.get('professionalId'),
      expertiseId: parseObject.get('expertiseId'),
      name: parseObject.get('name'),
      description: parseObject.get('description'),
      isPublic: parseObject.get('isPublic') ?? false,
      isDeleted: parseObject.get('isDeleted') ?? false,
    );
    return model;
  }

  ParseObject toParse(EvaluationModel model) {
    final parseObject = ParseObject(EvaluationEntity.className);
    if (model.id != null) {
      parseObject.objectId = model.id;
    }
    if (model.professionalId != null) {
      parseObject.set('professionalId', model.professionalId);
    }
    if (model.expertiseId != null) {
      parseObject.set('expertiseId', model.expertiseId);
    }
    if (model.name != null) {
      parseObject.set('name', model.name);
    }
    if (model.description != null) {
      parseObject.set('description', model.description);
    }
    if (model.isPublic != null) {
      parseObject.set('isPublic', model.isPublic);
    }
    if (model.isDeleted != null) {
      parseObject.set('isDeleted', model.isDeleted);
    }

    return parseObject;
  }
}
