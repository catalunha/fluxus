import 'package:fluxus/app/core/models/office_model.dart';
import 'package:fluxus/app/data/b4a/entity/office_entity.dart';
import 'package:fluxus/app/data/b4a/table/office/office_repository_exception.dart';
import 'package:fluxus/app/data/b4a/utils/parse_error_code.dart';
import 'package:fluxus/app/data/repositories/office_repository.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class OfficeRepositoryB4a implements OfficeRepository {
  Future<QueryBuilder<ParseObject>> getQueryAll() async {
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(OfficeEntity.className));
    query.whereEqualTo('isDeleted', false);
    query.orderByAscending('name');

    return query;
  }

  @override
  Future<List<OfficeModel>> list() async {
    QueryBuilder<ParseObject> query;
    query = await getQueryAll();
    ParseResponse? response;
    try {
      response = await query.query();
      List<OfficeModel> listTemp = <OfficeModel>[];
      if (response.success && response.results != null) {
        for (var element in response.results!) {
          listTemp.add(OfficeEntity().fromParse(element));
        }
      }
      return listTemp;
      //  else {
      //   throw Exception();
      // }
    } on Exception {
      var errorCodes = ParseErrorCode(response!.error!);
      throw OfficeRepositoryException(
        code: errorCodes.code,
        message: errorCodes.message,
      );
    }
  }
}
