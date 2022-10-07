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
}
