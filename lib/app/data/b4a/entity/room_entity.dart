import 'package:fluxus/app/core/models/room_model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class RoomEntity {
  static const String className = 'Room';

  RoomModel fromParse(ParseObject parseObject) {
    RoomModel expertiseModel = RoomModel(
      id: parseObject.objectId!,
      name: parseObject.get('name'),
      description: parseObject.get('description'),
      isActive: parseObject.get('isActive'),
      isDeleted: parseObject.get('isDeleted'),
    );
    return expertiseModel;
  }
}
