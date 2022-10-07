import 'package:fluxus/app/core/models/user_model.dart';
import 'package:fluxus/app/data/b4a/databases/profile/profile_repository_b4a.dart';
import 'package:fluxus/app/data/b4a/entity/user_entity.dart';
import 'package:fluxus/app/data/b4a/databases/user/user_repository_exception.dart';
import 'package:fluxus/app/data/b4a/utils/parseerror_codes.dart';
import 'package:fluxus/app/data/repositories/user_repository.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class UserRepositoryB4a implements UserRepository {
  @override
  Future<UserModel?> readByEmail(String email) async {
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(UserEntity.className));
    query.whereEqualTo('email', email);
    print('+++++++++++++++++');
    print('+++++++++++++++++');
    print('readByEmail');
    print('+++++++++++++++++');
    print('+++++++++++++++++');
    query.includeObject(['profile', 'profile.community']);
    query.first();
    final ParseResponse response;
    try {
      response = await query.query();
    } catch (e) {
      throw UserRepositoryException(
          code: '123', message: 'Erro ao buscar user');
    }
    UserModel? temp;
    if (response.success && response.results != null) {
      for (var element in response.results!) {
        print('readByEmail:');
        print((element as ParseObject).objectId);
        print(element);
        temp = UserEntity().fromParse(element);
        print(temp);
      }
      print(temp);
      return temp;
    } else {
      //print('nao encontrei este User...');
      return null;
    }
  }

  @override
  Future<UserModel?> register(
      {required String email, required String password}) async {
    ParseResponse? response;

    try {
      final user = ParseUser.createUser(email, password, email);
      response = await user.signUp();
      if (response.success) {
        UserModel userModel = UserEntity().fromParse(response.results!.first);
        return userModel;
      } else {
        var errorCodes = ParseErrorCodes(response.error!);
        throw UserRepositoryException(
          code: '${errorCodes.code}',
          message: errorCodes.message,
        );
      }
    } catch (e) {
      var errorCodes = ParseErrorCodes(response!.error!);
      throw UserRepositoryException(
        code: '${errorCodes.code}',
        message: errorCodes.message,
      );
    }
  }

  @override
  Future<UserModel?> login(
      {required String email, required String password}) async {
    UserModel userModel;
    ParseResponse? response;
    try {
      final user = ParseUser(email, password, null);

      response = await user.login();
      if (response.success) {
        ParseUser parseUser = response.results!.first;
        var profileField = parseUser.get('profile');
        var profileRepositoryB4a = ProfileRepositoryB4a();

        userModel = UserModel(
          id: parseUser.objectId!,
          email: parseUser.emailAddress!,
          profile: await profileRepositoryB4a.readById(profileField.objectId),
        );
        return userModel;
      } else {
        throw UserRepositoryException(
            message: response.error!.message, code: '${response.error!.code}');
      }
    } catch (e) {
      var errorCodes = ParseErrorCodes(response!.error!);
      throw UserRepositoryException(
        code: '${errorCodes.code}',
        message: errorCodes.message,
      );
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    final ParseUser user = ParseUser(null, null, email);
    final ParseResponse parseResponse = await user.requestPasswordReset();
    if (!parseResponse.success) {
      throw UserRepositoryException(
          code: '000', message: 'Erro em recuperar senha');
    }
  }

  @override
  Future<bool> logout() async {
    final user = await ParseUser.currentUser() as ParseUser;
    var response = await user.logout();
    if (response.success) {
      return true;
    } else {
      return false;
    }
  }
}
