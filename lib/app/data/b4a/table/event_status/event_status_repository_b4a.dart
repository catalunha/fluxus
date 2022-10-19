import 'package:fluxus/app/core/models/event_status_model.dart';
import 'package:fluxus/app/data/b4a/entity/event_status_entity.dart';
import 'package:fluxus/app/data/b4a/table/event_status/event_status_repository_exception.dart';
import 'package:fluxus/app/data/b4a/utils/parse_error_code.dart';
import 'package:fluxus/app/data/repositories/event_status_repository.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class EventStatusRepositoryB4a extends GetxService
    implements EventStatusRepository {
  Future<QueryBuilder<ParseObject>> getQueryAll() async {
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(EventStatusEntity.className));
    query.whereEqualTo('isDeleted', false);
    query.orderByAscending('name');

    return query;
  }

  @override
  Future<List<EventStatusModel>> list() async {
    QueryBuilder<ParseObject> query;
    query = await getQueryAll();
    ParseResponse? response;
    try {
      response = await query.query();
      List<EventStatusModel> listTemp = <EventStatusModel>[];
      if (response.success && response.results != null) {
        for (var element in response.results!) {
          listTemp.add(EventStatusEntity().fromParse(element));
        }
        return listTemp;
      } else {
        throw Exception();
      }
    } on Exception {
      var errorCodes = ParseErrorCode(response!.error!);
      throw EventStatusRepositoryException(
        code: errorCodes.code,
        message: errorCodes.message,
      );
    }
  }
}
