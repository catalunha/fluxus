import 'package:fluxus/app/core/models/profile_model.dart';
import 'package:fluxus/app/core/models/user_model.dart';
import 'package:fluxus/app/data/b4a/entity/profile_entity.dart';
import 'package:fluxus/app/data/b4a/init_back4app.dart';
import 'package:fluxus/app/data/b4a/databases/profile/profile_repository_exception.dart';
import 'package:fluxus/app/data/repositories/auth_repository.dart';
import 'package:fluxus/app/routes.dart';
import 'package:fluxus/app/view/controllers/utils/message_mixin.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class SplashController extends GetxController with MessageMixin {
  final AuthRepository _authRepository;
  SplashController({required AuthRepository authRepository})
      : _authRepository = authRepository;

  final Rxn<ParseUser> _parseUser = Rxn<ParseUser>();
  ParseUser? get parseUser => _parseUser.value;
  set parseUser(ParseUser? parseUser) {
    _parseUser(parseUser);
  }

  final _userModel = Rxn<UserModel>();
  UserModel? get userModel => _userModel.value;
  set userModel(UserModel? userModel) {
    _userModel(userModel);
    _userModel.update((val) {
      val?.profile = userModel?.profile;
    });
  }

  final _message = Rxn<MessageModel>();

  @override
  void onInit() async {
    messageListener(_message);

    super.onInit();
    await Future.delayed(const Duration(seconds: 1), () {});

    InitBack4app initBack4app = InitBack4app();
    bool initParse = await initBack4app.init();

    final isLogged = await _hasUserLogged();
    if (isLogged) {
      print('tem user analisando se isActive');
      print(userModel);
      if (userModel!.profile!.isActive == true) {
        Get.offAllNamed(Routes.home);
      } else {
        Get.offAllNamed(Routes.authLogin);
        _message.value = MessageModel(
          title: 'Oops.',
          message: 'Estamos analisando seu cadastro...',
          isError: true,
        );
      }
    } else {
      Get.offAllNamed(Routes.authLogin);
    }
  }

  Future<bool> _hasUserLogged() async {
    parseUser = await ParseUser.currentUser() as ParseUser?;
    if (parseUser == null) {
      return false;
    }
    //Checks whether the user's session token is valid
    final ParseResponse? parseResponse =
        await ParseUser.getCurrentUserFromServer(parseUser!.sessionToken!);

    if (parseResponse?.success == null || !parseResponse!.success) {
      //Invalid session. Logout
      await parseUser!.logout();
      return false;
    } else {
      userModel = UserModel(
        id: parseUser!.objectId!,
        email: parseUser!.emailAddress!,
        profile: await getProfile(),
      );
      return true;
    }
  }

  Future<void> updateUserProfile() async {
    userModel = UserModel(
      id: parseUser!.objectId!,
      email: parseUser!.emailAddress!,
      profile: await getProfile(),
    );
  }

  Future<ProfileModel?> getProfile() async {
    parseUser = await ParseUser.currentUser() as ParseUser;
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(ProfileEntity.className));
    query.whereEqualTo('email', parseUser!.get('email'));
    // query.includeObject(['community']);
    query.first();
    final ParseResponse response;
    try {
      response = await query.query();
    } catch (e) {
      throw ProfileRepositoryException(
          code: '123', message: 'Erro ao buscar user');
    }
    ProfileModel? temp;

    if (response.success && response.results != null) {
      for (var element in response.results!) {
        temp = ProfileEntity().fromParse(element);
        print(temp);
      }
      print(temp);
      return temp;
    } else {
      return null;
    }
  }

  Future<void> logout() async {
    await _authRepository.logout();
    Get.offAllNamed(Routes.authLogin);
  }
}
