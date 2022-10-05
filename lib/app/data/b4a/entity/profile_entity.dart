import 'package:fluxus/app/core/models/profile_model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ProfileEntity {
  static const String className = 'Profile';

  ProfileModel fromParse(ParseObject parseObject) {
    ProfileModel ProfileEntity = ProfileModel(
      id: parseObject.objectId!,
      name: parseObject.get('name'),
      // description: parseObject.get('description'),
      phone: parseObject.get('phone'),
      // photo: parseObject.get('photo')?.get('url'),
      email: parseObject.get('email'),
      isActive: parseObject.get('isActive'),
      // community: parseObject.get('community') != null
      //     ? CommunityEntity().fromParse(parseObject.get('community'))
      //     : null,
    );
    return ProfileEntity;
  }

  Future<ParseObject> toParse(ProfileModel ProfileModel) async {
    final profileParse = ParseObject(ProfileEntity.className);
    if (ProfileModel.id != null) {
      profileParse.objectId = ProfileModel.id;
    }
    if (ProfileModel.name != null) {
      profileParse.set('name', ProfileModel.name);
    }
    // if (ProfileModel.description != null) {
    //   profileParse.set('description', ProfileModel.description);
    // }
    if (ProfileModel.phone != null) {
      profileParse.set('phone', ProfileModel.phone);
    }
    // if (ProfileModel.unit != null) {
    //   profileParse.set('unit', ProfileModel.unit);
    // }
    // if (ProfileModel.photoParseFileBase != null) {
    //   profileParse.set('photo', ProfileModel.photoParseFileBase);
    // }
    if (ProfileModel.email != null) {
      profileParse.set('email', ProfileModel.email);
    }
    if (ProfileModel.isActive != null) {
      profileParse.set('isActive', ProfileModel.isActive);
    }
    return profileParse;
  }
}
