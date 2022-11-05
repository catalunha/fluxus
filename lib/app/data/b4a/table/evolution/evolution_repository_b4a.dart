import 'package:fluxus/app/core/models/evolution_model.dart';
import 'package:fluxus/app/data/b4a/entity/evolution_entity.dart';
import 'package:fluxus/app/data/b4a/table/evolution/evolution_repository_exception.dart';
import 'package:fluxus/app/data/b4a/utils/parse_error_code.dart';
import 'package:fluxus/app/data/repositories/evolution_repository.dart';
import 'package:fluxus/app/data/utils/pagination.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class EvolutionRepositoryB4a implements EvolutionRepository {
  Future<QueryBuilder<ParseObject>> getQueryAll(QueryBuilder<ParseObject> query,
      {Pagination? pagination}) async {
    // QueryBuilder<ParseObject> query =
    //     QueryBuilder<ParseObject>(ParseObject(EvolutionEntity.className));
    query.includeObject(['professional', 'patient', 'procedure']);
    query.whereEqualTo('isDeleted', false);
    // query.whereEqualTo('isArchived', false);// resolvido no controller
    query.whereNotEqualTo('event', null);
    query.orderByDescending('createAt');
    if (pagination != null) {
      query.setAmountToSkip((pagination.page - 1) * pagination.limit);
      query.setLimit(pagination.limit);
    }

    return query;
  }

  @override
  Future<List<EvolutionModel>> list(QueryBuilder<ParseObject> query,
      {Pagination? pagination}) async {
    // QueryBuilder<ParseObject> query =
    //     QueryBuilder<ParseObject>(ParseObject(EvolutionEntity.className));
    // // query.whereEqualTo('event', eventId);
    // query.whereEqualTo(
    //     'professional',
    //     (ParseObject(ProfileEntity.className)..objectId = professionalId)
    //         .toPointer());
    // query.whereEqualTo('isDeleted', false);
    // query.includeObject(['professional', 'patient']);
    // query.orderByDescending('updatedAt');
    QueryBuilder<ParseObject> query2;
    query2 = await getQueryAll(query, pagination: pagination);

    ParseResponse? response;
    try {
      response = await query2.query();
      List<EvolutionModel> listTemp = <EvolutionModel>[];
      if (response.success && response.results != null) {
        for (var element in response.results!) {
          listTemp.add(await EvolutionEntity().fromParse(element));
        }
      }
      return listTemp;
    } on Exception {
      var errorCodes = ParseErrorCode(response!.error!);
      throw EvolutionRepositoryException(
        code: errorCodes.code,
        message: errorCodes.message,
      );
    }
  }

  @override
  Future<String> update(EvolutionModel model) async {
    final parseObject = await EvolutionEntity().toParse(model);
    ParseResponse? response;
    try {
      response = await parseObject.save();

      if (response.success && response.results != null) {
        ParseObject userEvolution = response.results!.first as ParseObject;
        return userEvolution.objectId!;
      } else {
        throw Exception();
      }
    } on Exception {
      var errorCodes = ParseErrorCode(response!.error!);
      throw EvolutionRepositoryException(
        code: errorCodes.code,
        message: errorCodes.message,
      );
    }
  }

  @override
  Future<EvolutionModel?> readById(String id) async {
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(EvolutionEntity.className));
    query.whereEqualTo('objectId', id);
    query.includeObject(['professional', 'patient', 'procedure']);
    // query.first();
    ParseResponse? response;
    try {
      response = await query.query();

      if (response.success && response.results != null) {
        return EvolutionEntity().fromParse(response.results!.first);
      } else {
        throw Exception();
      }
    } on Exception {
      var errorCodes = ParseErrorCode(response!.error!);
      throw EvolutionRepositoryException(
        code: errorCodes.code,
        message: errorCodes.message,
      );
    }
  }

  // @override
  // Future<void> updateRelationCid(
  //     String objectId, List<String> modelIdList, bool add) async {
  //   final parseObject = EvolutionEntity().toParseUpdateRelationCid(
  //       objectId: objectId, modelIdList: modelIdList, add: add);
  //   if (parseObject != null) {
  //     await parseObject.save();
  //   }
  // }

  @override
  Future<void> updateUnset(String modelId, List<String> unsetFields) async {
    final parseObject = EvolutionEntity().toParseUnset(modelId, unsetFields);
    await parseObject.save();

    // if (response.success && response.results != null) {
    //   ParseObject userProfile = response.results!.first as ParseObject;
    //   return userProfile.objectId!;
    // } else {
    //   var errorCodes = ParseErrorCode(response.error!);
    //   throw AttendanceRepositoryException(
    //     code: errorCodes.code,
    //     message: errorCodes.message,
    //   );
    // }
  }
}
