import 'package:fluxus/app/core/models/procedure_model.dart';
import 'package:fluxus/app/data/b4a/entity/procedure_entity.dart';
import 'package:fluxus/app/data/b4a/table/procedure/procedure_repository_exception.dart';
import 'package:fluxus/app/data/b4a/utils/parse_error_code.dart';
import 'package:fluxus/app/data/repositories/procedure_repository.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ProcedureRepositoryB4a implements ProcedureRepository {
  Future<QueryBuilder<ParseObject>> getQueryAll() async {
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(ProcedureEntity.className));
    // query.whereEqualTo('isDeleted', false);
    query.orderByAscending('name');
    query.includeObject(['expertise']);
    return query;
  }

  @override
  Future<List<ProcedureModel>> list() async {
    QueryBuilder<ParseObject> query;
    query = await getQueryAll();
    ParseResponse? response;
    try {
      response = await query.query();
      List<ProcedureModel> listTemp = <ProcedureModel>[];
      if (response.success && response.results != null) {
        for (var element in response.results!) {
          listTemp.add(ProcedureEntity().fromParse(element));
        }
      }
      return listTemp;
    } on Exception {
      var errorCodes = ParseErrorCode(response!.error!);
      throw ProcedureRepositoryException(
        code: errorCodes.code,
        message: errorCodes.message,
      );
    }
  }
}
