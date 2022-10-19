import 'package:fluxus/app/core/models/event_model.dart';
import 'package:fluxus/app/data/utils/pagination.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

abstract class EventRepository {
  Future<List<EventModel>> list(
      QueryBuilder<ParseObject> query, Pagination pagination);
  Future<String> update(EventModel model);
  Future<EventModel?> readById(String id);
  Future<void> toParseUpdateRelationProfessionals(
      String objectId, List<String> modelIdList, bool add);
  Future<void> toParseUpdateRelationHealthPlans(
      String objectId, List<String> modelIdList, bool add);
}
