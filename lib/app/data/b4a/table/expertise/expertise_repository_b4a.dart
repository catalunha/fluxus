import 'package:fluxus/app/core/models/expertise_model.dart';
import 'package:fluxus/app/data/b4a/entity/expertise_entity.dart';
import 'package:fluxus/app/data/b4a/table/expertise/expertise_repository_exception.dart';
import 'package:fluxus/app/data/b4a/utils/parse_error_code.dart';
import 'package:fluxus/app/data/repositories/expertise_repository.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ExpertiseRepositoryB4a implements ExpertiseRepository {
  Future<QueryBuilder<ParseObject>> getQueryAll() async {
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(ExpertiseEntity.className));
    query.whereEqualTo('isDeleted', false);
    query.orderByAscending('name');

    return query;
  }

  @override
  Future<List<ExpertiseModel>> list() async {
    QueryBuilder<ParseObject> query;
    query = await getQueryAll();
    ParseResponse? response;
    try {
      response = await query.query();
      List<ExpertiseModel> listTemp = <ExpertiseModel>[];
      if (response.success && response.results != null) {
        for (var element in response.results!) {
          listTemp.add(ExpertiseEntity().fromParse(element));
        }
        return listTemp;
      } else {
        throw Exception();
      }
    } on Exception {
      var errorCodes = ParseErrorCode(response!.error!);
      throw ExpertiseRepositoryException(
        code: errorCodes.code,
        message: errorCodes.message,
      );
    }
  }
}
