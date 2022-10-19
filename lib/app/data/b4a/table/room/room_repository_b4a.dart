import 'package:fluxus/app/core/models/room_model.dart';
import 'package:fluxus/app/data/b4a/entity/room_entity.dart';
import 'package:fluxus/app/data/b4a/table/room/room_repository_exception.dart';
import 'package:fluxus/app/data/b4a/utils/parse_error_code.dart';
import 'package:fluxus/app/data/repositories/room_repository.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class RoomRepositoryB4a implements RoomRepository {
  Future<QueryBuilder<ParseObject>> getQueryAll() async {
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(RoomEntity.className));
    query.whereEqualTo('isActive', true);
    query.whereEqualTo('isDeleted', false);
    query.orderByAscending('name');

    return query;
  }

  @override
  Future<List<RoomModel>> list() async {
    QueryBuilder<ParseObject> query;
    query = await getQueryAll();
    ParseResponse? response;
    try {
      response = await query.query();
      List<RoomModel> listTemp = <RoomModel>[];
      if (response.success && response.results != null) {
        for (var element in response.results!) {
          listTemp.add(RoomEntity().fromParse(element));
        }
        return listTemp;
      } else {
        throw Exception();
      }
    } on Exception {
      var errorCodes = ParseErrorCode(response!.error!);
      throw RoomRepositoryException(
        code: errorCodes.code,
        message: errorCodes.message,
      );
    }
  }
}
