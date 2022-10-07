import 'package:fluxus/app/core/models/profile_model.dart';
import 'package:fluxus/app/data/b4a/entity/profile_entity.dart';
import 'package:fluxus/app/data/b4a/table/profile/profile_repository_exception.dart';
import 'package:fluxus/app/data/b4a/utils/parse_error_code.dart';
import 'package:fluxus/app/data/repositories/profile_repository.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ProfileRepositoryB4a implements ProfileRepository {
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
    // query.includeObject(['community']);
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
}
