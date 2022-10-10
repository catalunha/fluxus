import 'package:fluxus/app/core/models/profile_model.dart';
import 'package:fluxus/app/core/models/user_model.dart';
import 'package:fluxus/app/core/utils/app_error_code.dart';
import 'package:fluxus/app/data/b4a/table/profile/profile_repository_b4a.dart';
import 'package:fluxus/app/data/b4a/init_back4app.dart';
import 'package:fluxus/app/data/repositories/user_repository.dart';
import 'package:fluxus/app/routes.dart';
import 'package:fluxus/app/view/controllers/utils/message_mixin.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class SplashController extends GetxController with MessageMixin {
  final UserRepository _userRepository;
  SplashController({required UserRepository userRepository})
      : _userRepository = userRepository;

  final Rxn<ParseUser> _parseUser = Rxn<ParseUser>();
  ParseUser? get parseUser => _parseUser.value;
  set parseUser(ParseUser? parseUserNew) {
    _parseUser(parseUserNew);
  }

  final _userModel = Rxn<UserModel>();
  UserModel? get userModel => _userModel.value;
  set userModel(UserModel? userModelNew) {
    _userModel(userModelNew);
  }

  final _message = Rxn<MessageModel>();

  @override
  void onInit() async {
    messageListener(_message);

    super.onInit();
    await startApp();
  }

  Future<void> startApp() async {
    await Future.delayed(const Duration(seconds: 1), () {});

    InitBack4app initBack4app = InitBack4app();
    bool initParse = await initBack4app.init();
    if (initParse) {
      final isLogged = await _hasUserLogged();
      if (isLogged) {
        if (userModel!.profile!.isActive == true) {
          Get.offAllNamed(Routes.home);
        } else {
          Get.offAllNamed(Routes.userLogin);
          var appErrorCode = AppErrorCode(0);
          _message.value = MessageModel(
            title: appErrorCode.code,
            message: appErrorCode.message,
            isError: true,
          );
        }
      } else {
        Get.offAllNamed(Routes.userLogin);
      }
    } else {
      var appErrorCode = AppErrorCode(0);

      _message.value = MessageModel(
        title: appErrorCode.code,
        message: appErrorCode.message,
        isError: true,
      );
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
      var profileField = parseUser!.get('profile');
      var profileRepositoryB4a = ProfileRepositoryB4a();

      var profileModel =
          await profileRepositoryB4a.readById(profileField.objectId);

      userModel = UserModel(
        id: parseUser!.objectId!,
        email: parseUser!.emailAddress!,
        profile: profileModel,
      );
      return true;
    }
  }

  Future<ProfileModel?> updateUserProfile() async {
    var profileField = parseUser!.get('profile');
    var profileRepositoryB4a = ProfileRepositoryB4a();
    var profileModel =
        await profileRepositoryB4a.readById(profileField.objectId);
    _userModel.update((val) {
      val?.profile = profileModel;
    });
    return profileModel;
  }

  Future<void> logout() async {
    await _userRepository.logout();
    Get.offAllNamed(Routes.userLogin);
  }
}
