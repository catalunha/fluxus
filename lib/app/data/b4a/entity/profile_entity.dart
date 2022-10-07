import 'package:fluxus/app/core/models/profile_model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ProfileEntity {
  static const String className = 'Profile';

  ProfileModel fromParse(ParseObject parseObject) {
    ProfileModel profileEntity = ProfileModel(
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
    return profileEntity;
  }

  Future<ParseObject> toParse(ProfileModel profileModel) async {
    final profileParse = ParseObject(ProfileEntity.className);
    if (profileModel.id != null) {
      profileParse.objectId = profileModel.id;
    }
    if (profileModel.name != null) {
      profileParse.set('name', profileModel.name);
    }
    // if (profileModel.description != null) {
    //   profileParse.set('description', profileModel.description);
    // }
    if (profileModel.phone != null) {
      profileParse.set('phone', profileModel.phone);
    }
    // if (profileModel.unit != null) {
    //   profileParse.set('unit', profileModel.unit);
    // }
    // if (profileModel.photoParseFileBase != null) {
    //   profileParse.set('photo', profileModel.photoParseFileBase);
    // }
    if (profileModel.email != null) {
      profileParse.set('email', profileModel.email);
    }
    if (profileModel.isActive != null) {
      profileParse.set('isActive', profileModel.isActive);
    }
    return profileParse;
  }
}
