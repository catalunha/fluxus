import 'package:fluxus/app/core/models/profile_model.dart';
import 'package:fluxus/app/data/b4a/entity/profile_entity.dart';
import 'package:fluxus/app/data/b4a/databases/profile/profile_repository_exception.dart';
import 'package:fluxus/app/data/repositories/profile_repository.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ProfileRepositoryB4a implements ProfileRepository {
  @override
  Future<String> update(ProfileModel profileModel) async {
    //print('ProfileRepositoryB4a.update');
    //print(profileModel);
    final userProfileParse = await ProfileEntity().toParse(profileModel);
    //print(userProfileParse);

    final ParseResponse responseUserProfile = await userProfileParse.save();
    if (responseUserProfile.success && responseUserProfile.results != null) {
      ParseObject userProfile =
          responseUserProfile.results!.first as ParseObject;
      return userProfile.objectId!;
    } else {
      throw ProfileRepositoryException(
          code: '000', message: 'Não foi possivel fazer update');
    }
  }

  @override
  Future<ProfileModel?> readById(String id) async {
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(ProfileEntity.className));
    query.whereEqualTo('objectId', id);
    // query.includeObject(['community']);
    query.first();
    final ParseResponse response;
    response = await query.query();

    if (response.success && response.results != null) {
      ProfileModel? temp;
      temp = ProfileEntity().fromParse(response.results!.first);
      return temp;
    } else {
      return null;
    }
  }

  // @override
  // Future<ProfileModel?> getProfile() async {
  //   parseUser = await ParseUser.currentUser() as ParseUser;
  //   QueryBuilder<ParseObject> query =
  //       QueryBuilder<ParseObject>(ParseObject(ProfileEntity.className));
  //   query.whereEqualTo('email', parseUser!.get('email'));
  //   // query.includeObject(['community']);
  //   query.first();
  //   final ParseResponse response;
  //   try {
  //     response = await query.query();
  //   } catch (e) {
  //     throw ProfileRepositoryException(
  //         code: '123', message: 'Erro ao buscar user');
  //   }
  //   ProfileModel? temp;

  //   if (response.success && response.results != null) {
  //     for (var element in response.results!) {
  //       temp = ProfileEntity().fromParse(element);
  //       print(temp);
  //     }
  //     print(temp);
  //     return temp;
  //   } else {
  //     return null;
  //   }
  // }

  // @override
  // Future<ProfileModel?> getProfile() async {
  //   var parseUser = await ParseUser.currentUser() as ParseUser;

  //   var profileField = parseUser.get('profile');
  //   var profileObj = ParseObject(ProfileEntity.className);
  //   var profileData = await profileObj.getObject(profileField.objectId);
  //   ProfileModel? userProfileEntity;
  //   if (profileData.success) {
  //     userProfileEntity =
  //         ProfileEntity().fromParse(profileData.result as ParseObject);
  //   } else {
  //     //print('nao foi');
  //   }
  //   return userProfileEntity;
  // }

}
