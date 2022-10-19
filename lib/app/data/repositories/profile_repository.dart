import 'package:fluxus/app/core/models/profile_model.dart';
import 'package:fluxus/app/data/utils/pagination.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

abstract class ProfileRepository {
  // Future<List<ProfileModel>> list(Pagination pagination);
  Future<List<ProfileModel>> list(
      QueryBuilder<ParseObject> query, Pagination pagination);
  Future<String> update(ProfileModel userProfileModel);
  Future<ProfileModel?> readById(String id);
  Future<void> updateRelationHealthPlan(
      String objectId, List<String> modelIdList, bool add);
  // Future<void> updateRelationChildren(
  //     String objectId, List<String> modelIdList, bool add);
  Future<void> updateRelationFamily(
      String objectId, List<String> modelIdList, bool add);
  Future<void> updateRelationOffice(
      String objectId, List<String> modelIdList, bool add);
}
