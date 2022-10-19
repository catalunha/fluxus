import 'package:fluxus/app/core/models/event_status_model.dart';

abstract class EventStatusRepository {
  Future<List<EventStatusModel>> list();
}
