import 'package:fluxus/app/core/models/cid_model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class CidEntity {
  static const String className = 'Cid';

  CidModel fromParse(ParseObject parseObject) {
    CidModel expertiseModel = CidModel(
      id: parseObject.objectId!,
      name: parseObject.get('name'),
      description: parseObject.get('description'),
      isDeleted: parseObject.get('isDeleted') ?? false,
    );
    return expertiseModel;
  }
}
