import 'package:fluxus/app/core/models/profile_model.dart';
import 'package:fluxus/app/data/b4a/entity/profile_entity.dart';
import 'package:fluxus/app/data/b4a/table/profile/profile_repository_exception.dart';
import 'package:fluxus/app/data/b4a/utils/parse_error_code.dart';
import 'package:fluxus/app/data/repositories/profile_repository.dart';
import 'package:fluxus/app/data/utils/pagination.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ProfileRepositoryB4a implements ProfileRepository {
  Future<QueryBuilder<ParseObject>> getQueryAll(
      QueryBuilder<ParseObject> query, Pagination pagination) async {
    query.whereEqualTo('isDeleted', false);
    query.orderByDescending('updatedAt');

    query.setAmountToSkip((pagination.page - 1) * pagination.limit);
    query.setLimit(pagination.limit);

    return query;
  }

  @override
  Future<List<ProfileModel>> list(
      QueryBuilder<ParseObject> query, Pagination pagination) async {
    QueryBuilder<ParseObject> query2;
    query2 = await getQueryAll(query, pagination);

    ParseResponse? response;
    try {
      response = await query2.query();
      List<ProfileModel> listTemp = <ProfileModel>[];
      if (response.success && response.results != null) {
        for (var element in response.results!) {
          listTemp.add(ProfileEntity().fromParseSimpleData(element));
        }
        return listTemp;
      } else {
        return [];
      }
    } on Exception {
      var errorCodes = ParseErrorCode(response!.error!);
      throw ProfileRepositoryException(
        code: errorCodes.code,
        message: errorCodes.message,
      );
    }
  }

  @override
  Future<String> update(ProfileModel profileModel) async {
    final userProfileParse = await ProfileEntity().toParse(profileModel);
    ParseResponse? response;
    try {
      response = await userProfileParse.save();

      if (response.success && response.results != null) {
        ParseObject userProfile = response.results!.first as ParseObject;
        return userProfile.objectId!;
      } else {
        throw Exception();
      }
    } on Exception {
      var errorCodes = ParseErrorCode(response!.error!);
      throw ProfileRepositoryException(
        code: errorCodes.code,
        message: errorCodes.message,
      );
    }
  }

  @override
  Future<ProfileModel?> readById(String id) async {
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(ProfileEntity.className));
    query.whereEqualTo('objectId', id);
    query.first();
    ParseResponse? response;
    try {
      response = await query.query();

      if (response.success && response.results != null) {
        return ProfileEntity().fromParse(response.results!.first);
      } else {
        throw Exception();
      }
    } on Exception {
      var errorCodes = ParseErrorCode(response!.error!);
      throw ProfileRepositoryException(
        code: errorCodes.code,
        message: errorCodes.message,
      );
    }
  }

  @override
  Future<void> updateRelationHealthPlan(
      String objectId, List<String> modelIdList, bool add) async {
    final parseObject = ProfileEntity().toParseUpdateRelationHealthPlan(
        objectId: objectId, modelIdList: modelIdList, add: add);
    if (parseObject != null) {
      await parseObject.save();
    }
  }

  // @override
  // Future<void> updateRelationChildren(
  //     String objectId, List<String> modelIdList, bool add) async {
  //   final parseObject = ProfileEntity().toParseUpdateRelationChildren(
  //       objectId: objectId, modelIdList: modelIdList, add: add);
  //   if (parseObject != null) {
  //     await parseObject.save();
  //   }
  // }

  @override
  Future<void> updateRelationFamily(
      String objectId, List<String> modelIdList, bool add) async {
    final parseObject = ProfileEntity().toParseUpdateRelationFamily(
        objectId: objectId, modelIdList: modelIdList, add: add);
    if (parseObject != null) {
      await parseObject.save();
    }
  }

  @override
  Future<void> updateRelationOffice(
      String objectId, List<String> modelIdList, bool add) async {
    final parseObject = ProfileEntity().toParseUpdateRelationOffice(
        objectId: objectId, modelIdList: modelIdList, add: add);
    if (parseObject != null) {
      await parseObject.save();
    }
  }
}
