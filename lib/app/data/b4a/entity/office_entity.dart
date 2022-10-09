import 'package:fluxus/app/core/models/office_model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class OfficeEntity {
  static const String className = 'Office';

  OfficeModel fromParse(ParseObject parseObject) {
    OfficeModel expertiseModel = OfficeModel(
      id: parseObject.objectId!,
      name: parseObject.get('name'),
      description: parseObject.get('description'),
      isDeleted: parseObject.get('isDeleted') ?? false,
    );
    return expertiseModel;
  }
}
