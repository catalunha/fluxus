import 'package:fluxus/app/core/models/profile_model.dart';
import 'package:fluxus/app/core/models/user_model.dart';
import 'package:fluxus/app/core/utils/error_codes.dart';
import 'package:fluxus/app/data/b4a/auth/auth_repository_exception.dart';
import 'package:fluxus/app/data/b4a/entity/profile_entity.dart';
import 'package:fluxus/app/data/b4a/entity/user_entity.dart';
import 'package:fluxus/app/data/repositories/auth_repository.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class AuthRepositoryB4a implements AuthRepository {
  @override
  Future<UserModel?> registerEmail(
      {required String email, required String password}) async {
    ParseResponse? response;

    try {
      final user = ParseUser.createUser(email, password, email);
      response = await user.signUp();
      if (response.success) {
        //print('register success');
        UserModel userModel = UserEntity().fromParse(response.results!.first);
        return userModel;
      } else {
        var errorCodes = ErrorCodes(response.error!);
        throw AuthRepositoryException(
          code: '${errorCodes.code}',
          message: errorCodes.message,
        );
      }
    } catch (e) {
      print(e);
      print(
          '${response?.error?.code} - ${response?.error?.message} - ${response?.error?.type}');
      var errorCodes = ErrorCodes(response!.error!);
      throw AuthRepositoryException(
        code: '${errorCodes.code}',
        message: errorCodes.message,
      );
    }
  }

  @override
  Future<UserModel?> loginEmail(
      {required String email, required String password}) async {
    UserModel userModel;
    ParseResponse? response;
    try {
      final user = ParseUser(email, password, null);

      response = await user.login();
      if (response.success) {
        ParseUser user = response.results!.first;

        userModel = UserModel(
          id: user.objectId!,
          email: user.emailAddress!,
          profile: await getProfile(),
        );
        //print(userModel);
        return userModel;
      } else {
        throw AuthRepositoryException(
            message: response.error!.message, code: '${response.error!.code}');
      }
    } catch (e) {
      // } on AuthRepositoryException catch (e) {
      //   if (e.message == '205') {
      //     throw AuthRepositoryException(
      //         code: '205',
      //         message: 'Cadastro ainda não confirmado no email do usuário.');
      //   } else {
      //     rethrow;
      //   }
      print(e);
      print(
          '${response?.error?.code} - ${response?.error?.message} - ${response?.error?.type}');

      var errorCodes = ErrorCodes(response!.error!);
      throw AuthRepositoryException(
        code: '${errorCodes.code}',
        message: errorCodes.message,
      );
    }
    // return null;
  }

  @override
  Future<void> forgotPassword(String email) async {
    final ParseUser user = ParseUser(null, null, email);
    final ParseResponse parseResponse = await user.requestPasswordReset();
    if (!parseResponse.success) {
      throw AuthRepositoryException(
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

  Future<ProfileModel?> getProfile() async {
    var parseUser = await ParseUser.currentUser() as ParseUser;

    var profileField = parseUser.get('profile');
    //print('===> profile');
    //print(profileField);
    var profileObj = ParseObject(ProfileEntity.className);
    var profileData = await profileObj.getObject(profileField.objectId);
    ProfileModel? userProfileEntity;
    if (profileData.success) {
      userProfileEntity =
          ProfileEntity().fromParse(profileData.result as ParseObject);
    } else {
      //print('nao foi');
    }
    return userProfileEntity;
  }
}
