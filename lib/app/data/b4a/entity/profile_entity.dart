import 'package:fluxus/app/core/models/profile_model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ProfileEntity {
  static const String className = 'Profile';

  ProfileModel fromParse(ParseObject parseObject) {
    ProfileModel profileEntity = ProfileModel(
      id: parseObject.objectId!,
      email: parseObject.get('email'),
      name: parseObject.get('name'),
      birthday: parseObject.get('birthday'),
      phone: parseObject.get('phone'),
      address: parseObject.get('address'),
      cep: parseObject.get('cep'),
      pluscode: parseObject.get('pluscode'),
      cpf: parseObject.get('cpf'),
      description: parseObject.get('description'),
      photo: parseObject.get('photo')?.get('url'),
      isActive: parseObject.get('isActive'),
      isDeleted: parseObject.get('isDeleted'),
      isFemale: parseObject.get<bool>('isFemale') ?? false,

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
    if (profileModel.description != null) {
      profileParse.set('description', profileModel.description);
    }
    if (profileModel.phone != null) {
      profileParse.set('phone', profileModel.phone);
    }
    if (profileModel.email != null) {
      profileParse.set('email', profileModel.email);
    }
    if (profileModel.address != null) {
      profileParse.set('address', profileModel.address);
    }
    if (profileModel.cep != null) {
      profileParse.set('cep', profileModel.cep);
    }
    if (profileModel.pluscode != null) {
      profileParse.set('pluscode', profileModel.pluscode);
    }
    if (profileModel.cpf != null) {
      profileParse.set('cpf', profileModel.cpf);
    }
    if (profileModel.register != null) {
      profileParse.set('register', profileModel.register);
    }
    if (profileModel.isActive != null) {
      profileParse.set('isActive', profileModel.isActive);
    }
    if (profileModel.isDeleted != null) {
      profileParse.set('isDeleted', profileModel.isDeleted);
    }
    if (profileModel.isFemale != null) {
      profileParse.set('isFemale', profileModel.isFemale);
    }
    if (profileModel.birthday != null) {
      profileParse.set('birthday', profileModel.birthday);
    }
    return profileParse;
  }
}
