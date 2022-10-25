import 'package:fluxus/app/core/models/evaluation_model.dart';
import 'package:fluxus/app/data/b4a/entity/evaluation_entity.dart';
import 'package:fluxus/app/data/b4a/table/evaluation/evaluation_repository_exception.dart';
import 'package:fluxus/app/data/b4a/utils/parse_error_code.dart';
import 'package:fluxus/app/data/repositories/evaluation_repository.dart';
import 'package:fluxus/app/data/utils/pagination.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class EvaluationRepositoryB4a implements EvaluationRepository {
  Future<QueryBuilder<ParseObject>> getQueryAll(
      QueryBuilder<ParseObject> query, Pagination pagination) async {
    query.whereEqualTo('isDeleted', false);
    query.orderByDescending('updatedAt');

    query.setAmountToSkip((pagination.page - 1) * pagination.limit);
    query.setLimit(pagination.limit);

    return query;
  }

  @override
  Future<List<EvaluationModel>> list(
      QueryBuilder<ParseObject> query, Pagination pagination) async {
    QueryBuilder<ParseObject> query2;
    query2 = await getQueryAll(query, pagination);

    ParseResponse? response;
    try {
      response = response = await query2.query();
      List<EvaluationModel> listTemp = <EvaluationModel>[];
      if (response.success && response.results != null) {
        for (var element in response.results!) {
          listTemp.add(EvaluationEntity().fromParse(element));
        }
        return listTemp;
      }
      return listTemp;
    } on Exception {
      var errorCodes = ParseErrorCode(response!.error!);
      throw EvaluationRepositoryException(
        code: errorCodes.code,
        message: errorCodes.message,
      );
    }
  }

  @override
  Future<String> update(EvaluationModel model) async {
    final parseObject = EvaluationEntity().toParse(model);
    final ParseResponse response = await parseObject.save();

    if (response.success && response.results != null) {
      ParseObject userProfile = response.results!.first as ParseObject;
      return userProfile.objectId!;
    } else {
      var errorCodes = ParseErrorCode(response.error!);
      throw EvaluationRepositoryException(
        code: errorCodes.code,
        message: errorCodes.message,
      );
    }
  }

  @override
  Future<EvaluationModel?> readById(String id) async {
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(EvaluationEntity.className));
    query.whereEqualTo('objectId', id);

    query.first();
    ParseResponse? response;
    try {
      response = await query.query();

      if (response.success && response.results != null) {
        return EvaluationEntity().fromParse(response.results!.first);
      } else {
        throw Exception();
      }
    } on Exception {
      var errorCodes = ParseErrorCode(response!.error!);
      throw EvaluationRepositoryException(
        code: errorCodes.code,
        message: errorCodes.message,
      );
    }
  }
}
