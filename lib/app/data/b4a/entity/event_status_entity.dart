import 'package:fluxus/app/core/models/event_status_model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class EventStatusEntity {
  static const String className = 'EventStatus';

  EventStatusModel fromParse(ParseObject parseObject) {
    EventStatusModel expertiseModel = EventStatusModel(
      id: parseObject.objectId!,
      name: parseObject.get('name') ?? '',
      description: parseObject.get('description') ?? '',
      isDeleted: parseObject.get('isDeleted') ?? false,
    );
    return expertiseModel;
  }
}
