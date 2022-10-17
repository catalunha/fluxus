import 'package:fluxus/app/core/models/health_plan_model.dart';
import 'package:fluxus/app/data/b4a/entity/health_plan_entity.dart';
import 'package:fluxus/app/data/b4a/table/health_plan/health_plan_repository_exception.dart';
import 'package:fluxus/app/data/b4a/utils/parse_error_code.dart';
import 'package:fluxus/app/data/repositories/health_plan_repository.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class HealthPlanRepositoryB4a implements HealthPlanRepository {
  Future<QueryBuilder<ParseObject>> getQueryAll(
      QueryBuilder<ParseObject> query) async {
    query.whereEqualTo('isDeleted', false);
    query.includeObject(['healthPlanType', 'profile']);

    return query;
  }

  @override
  Future<List<HealthPlanModel>> list(QueryBuilder<ParseObject> query) async {
    QueryBuilder<ParseObject> query2;
    query2 = await getQueryAll(query);

    ParseResponse? response;
    try {
      response = response = await query2.query();
      List<HealthPlanModel> listTemp = <HealthPlanModel>[];
      if (response.success && response.results != null) {
        for (var element in response.results!) {
          listTemp.add(HealthPlanEntity().fromParse(element));
        }
        return listTemp;
      } else {
        throw Exception();
      }
    } on Exception {
      var errorCodes = ParseErrorCode(response!.error!);
      throw HealthPlanRepositoryException(
        code: errorCodes.code,
        message: errorCodes.message,
      );
    }
  }

  @override
  Future<String> addEdit(HealthPlanModel model) async {
    final parseObject = HealthPlanEntity().toParse(model);
    final ParseResponse response = await parseObject.save();

    if (response.success && response.results != null) {
      ParseObject userProfile = response.results!.first as ParseObject;
      return userProfile.objectId!;
    } else {
      var errorCodes = ParseErrorCode(response.error!);
      throw HealthPlanRepositoryException(
        code: errorCodes.code,
        message: errorCodes.message,
      );
    }
  }
}
