import 'package:fluxus/app/core/models/expect_model.dart';
import 'package:fluxus/app/data/b4a/entity/expect_entity.dart';
import 'package:fluxus/app/data/b4a/table/expect/expect_repository_exception.dart';
import 'package:fluxus/app/data/b4a/utils/parse_error_code.dart';
import 'package:fluxus/app/data/repositories/expect_repository.dart';
import 'package:fluxus/app/data/utils/pagination.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ExpectRepositoryB4a implements ExpectRepository {
  Future<QueryBuilder<ParseObject>> getQueryAll(
      QueryBuilder<ParseObject> query, Pagination pagination) async {
    query.whereEqualTo('isDeleted', false);
    query.orderByDescending('updatedAt');
    query.includeObject([
      'patient',
      'healthPlan',
      'healthPlan.healthPlanType',
      'expertise',
      'eventStatus'
    ]);

    query.setAmountToSkip((pagination.page - 1) * pagination.limit);
    query.setLimit(pagination.limit);

    return query;
  }

  @override
  Future<List<ExpectModel>> list(
      QueryBuilder<ParseObject> query, Pagination pagination) async {
    QueryBuilder<ParseObject> query2;
    query2 = await getQueryAll(query, pagination);

    ParseResponse? response;
    try {
      response = response = await query2.query();
      List<ExpectModel> listTemp = <ExpectModel>[];
      if (response.success && response.results != null) {
        for (var element in response.results!) {
          listTemp.add(ExpectEntity().fromParse(element));
        }
        return listTemp;
      }
      return listTemp;
    } on Exception {
      var errorCodes = ParseErrorCode(response!.error!);
      throw ExpectRepositoryException(
        code: errorCodes.code,
        message: errorCodes.message,
      );
    }
  }

  @override
  Future<String> update(ExpectModel model) async {
    final parseObject = ExpectEntity().toParse(model);
    final ParseResponse response = await parseObject.save();

    if (response.success && response.results != null) {
      ParseObject userProfile = response.results!.first as ParseObject;
      return userProfile.objectId!;
    } else {
      var errorCodes = ParseErrorCode(response.error!);
      throw ExpectRepositoryException(
        code: errorCodes.code,
        message: errorCodes.message,
      );
    }
  }

  @override
  Future<void> updateUnset(String modelId, List<String> unsetFields) async {
    final parseObject = ExpectEntity().toParseUnset(modelId, unsetFields);
    await parseObject.save();

    // if (response.success && response.results != null) {
    //   ParseObject userProfile = response.results!.first as ParseObject;
    //   return userProfile.objectId!;
    // } else {
    //   var errorCodes = ParseErrorCode(response.error!);
    //   throw ExpectRepositoryException(
    //     code: errorCodes.code,
    //     message: errorCodes.message,
    //   );
    // }
  }

  @override
  Future<ExpectModel?> readById(String id) async {
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(ExpectEntity.className));
    query.whereEqualTo('objectId', id);
    query.includeObject([
      'patient',
      'healthPlan',
      'healthPlan.healthPlanType',
      'expertise',
      'eventStatus'
    ]);
    // query.first();
    ParseResponse? response;
    try {
      response = await query.query();

      if (response.success && response.results != null) {
        return ExpectEntity().fromParse(response.results!.first);
      } else {
        throw Exception();
      }
    } on Exception {
      var errorCodes = ParseErrorCode(response!.error!);
      throw ExpectRepositoryException(
        code: errorCodes.code,
        message: errorCodes.message,
      );
    }
  }
}
