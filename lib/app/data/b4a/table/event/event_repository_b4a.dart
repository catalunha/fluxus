import 'package:fluxus/app/core/models/event_model.dart';
import 'package:fluxus/app/data/b4a/entity/event_entity.dart';
import 'package:fluxus/app/data/b4a/table/event/event_repository_exception.dart';
import 'package:fluxus/app/data/b4a/utils/parse_error_code.dart';
import 'package:fluxus/app/data/repositories/event_repository.dart';
import 'package:fluxus/app/data/utils/pagination.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class EventRepositoryB4a implements EventRepository {
  Future<QueryBuilder<ParseObject>> getQueryAll(
      QueryBuilder<ParseObject> query, Pagination pagination) async {
    // QueryBuilder<ParseObject> query =
    //     QueryBuilder<ParseObject>(ParseObject(EventEntity.className));
    query.whereEqualTo('isDeleted', false);
    query.orderByDescending('updatedAt');

    query.setAmountToSkip((pagination.page - 1) * pagination.limit);
    query.setLimit(pagination.limit);

    return query;
  }

  @override
  Future<List<EventModel>> list(
      QueryBuilder<ParseObject> query, Pagination pagination) async {
    QueryBuilder<ParseObject> query2;
    query2 = await getQueryAll(query, pagination);

    ParseResponse? response;
    try {
      response = await query2.query();
      List<EventModel> listTemp = <EventModel>[];
      if (response.success && response.results != null) {
        for (var element in response.results!) {
          listTemp.add(await EventEntity().fromParse(element));
        }
        return listTemp;
      } else {
        return [];
      }
    } on Exception {
      var errorCodes = ParseErrorCode(response!.error!);
      throw EventRepositoryException(
        code: errorCodes.code,
        message: errorCodes.message,
      );
    }
  }

  @override
  Future<String> update(EventModel model) async {
    final parseObject = await EventEntity().toParse(model);
    ParseResponse? response;
    try {
      response = await parseObject.save();

      if (response.success && response.results != null) {
        ParseObject userEvent = response.results!.first as ParseObject;
        return userEvent.objectId!;
      } else {
        throw Exception();
      }
    } on Exception {
      var errorCodes = ParseErrorCode(response!.error!);
      throw EventRepositoryException(
        code: errorCodes.code,
        message: errorCodes.message,
      );
    }
  }

  @override
  Future<EventModel?> readById(String id) async {
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(EventEntity.className));
    query.whereEqualTo('objectId', id);
    query.first();
    ParseResponse? response;
    try {
      response = await query.query();

      if (response.success && response.results != null) {
        return EventEntity().fromParse(response.results!.first);
      } else {
        throw Exception();
      }
    } on Exception {
      var errorCodes = ParseErrorCode(response!.error!);
      throw EventRepositoryException(
        code: errorCodes.code,
        message: errorCodes.message,
      );
    }
  }

  @override
  Future<void> toParseUpdateRelationProfessionals(
      String objectId, List<String> modelIdList, bool add) async {
    final parseObject = EventEntity().toParseUpdateRelationProfessionals(
        objectId: objectId, modelIdList: modelIdList, add: add);
    if (parseObject != null) {
      await parseObject.save();
    }
  }

  @override
  Future<void> toParseUpdateRelationHealthPlans(
      String objectId, List<String> modelIdList, bool add) async {
    final parseObject = EventEntity().toParseUpdateRelationHealthPlans(
        objectId: objectId, modelIdList: modelIdList, add: add);
    if (parseObject != null) {
      await parseObject.save();
    }
  }
}