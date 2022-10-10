import 'package:fluxus/app/core/models/health_plan_type_model.dart';
import 'package:fluxus/app/data/b4a/entity/health_plan_type_entity.dart';
import 'package:fluxus/app/data/b4a/table/health_plan_type/health_plan_type_repository_exception.dart';
import 'package:fluxus/app/data/b4a/utils/parse_error_code.dart';
import 'package:fluxus/app/data/repositories/health_plan_type_repository.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class HealthPlanTypeRepositoryB4a extends GetxService
    implements HealthPlanTypeRepository {
  Future<QueryBuilder<ParseObject>> getQueryAll() async {
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(HealthPlanTypeEntity.className));
    query.whereEqualTo('isDeleted', false);
    query.orderByAscending('name');

    return query;
  }

  @override
  Future<List<HealthPlanTypeModel>> list() async {
    QueryBuilder<ParseObject> query;
    query = await getQueryAll();
    ParseResponse? response;
    try {
      response = await query.query();
      List<HealthPlanTypeModel> listTemp = <HealthPlanTypeModel>[];
      if (response.success && response.results != null) {
        for (var element in response.results!) {
          listTemp.add(HealthPlanTypeEntity().fromParse(element));
        }
        return listTemp;
      } else {
        throw Exception();
      }
    } on Exception {
      var errorCodes = ParseErrorCode(response!.error!);
      throw HealthPlanTypeRepositoryException(
        code: errorCodes.code,
        message: errorCodes.message,
      );
    }
  }
}
