import 'package:fluxus/app/core/models/user_model.dart';
import 'package:fluxus/app/data/b4a/entity/profile_entity.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class UserEntity {
  static const String className = '_User';

  UserModel fromParse(ParseObject parseUser) {
    return UserModel(
      id: parseUser.objectId!,
      email: parseUser.get('username'),
      profile: parseUser.get('profile') != null
          ? ProfileEntity().fromParse(parseUser.get('profile'))
          : null,
    );
  }
}
