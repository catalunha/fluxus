import 'package:fluxus/app/data/b4a/auth/auth_repository_exception.dart';
import 'package:fluxus/app/data/repositories/auth_repository.dart';
import 'package:fluxus/app/routes.dart';
import 'package:fluxus/app/view/controllers/auth/splash/splash_controller.dart';
import 'package:fluxus/app/view/controllers/utils/loader_mixin.dart';
import 'package:fluxus/app/view/controllers/utils/message_mixin.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class LoginController extends GetxController with LoaderMixin, MessageMixin {
  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  final AuthRepository _authRepository;
  LoginController({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  void onInit() {
    super.onInit();
    loaderListener(_loading);
    messageListener(_message);
  }

  Future<void> loginEmail(String email, String password) async {
    try {
      _loading(true);
      final user =
          await _authRepository.loginEmail(email: email, password: password);
      if (user != null) {
        final splashController = Get.find<SplashController>();
        splashController.userModel = user;
        final parseUser = await ParseUser.currentUser() as ParseUser;
        splashController.parseUser = parseUser;
        if (user.profile!.isActive == true) {
          print('logado com isActive=true');
          Get.offAllNamed(Routes.home);
        } else {
          print('logado com isActive=false');
          _loading(false);
          _message.value = MessageModel(
            title: 'Atenção',
            message: 'Seu cadastro esta em análise.',
            isError: true,
          );
        }
        // Get.offAllNamed(Routes.home);
      } else {
        _message.value = MessageModel(
          title: 'Erro',
          message: 'Usuário ou senha inválidos.',
          isError: true,
        );
      }
    } on AuthRepositoryException catch (e) {
      _loading(false);

      _message.value = MessageModel(
        title: e.code,
        message: e.message,
        isError: true,
      );
    } finally {
      _loading(false);
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      final user = await _authRepository.forgotPassword(email);
      _message.value = MessageModel(
        title: 'Veja seu email',
        message: 'Enviamos instruções de recuperação de senha nele.',
      );
    } on AuthRepositoryException {
      _authRepository.logout();
      _message.value = MessageModel(
        title: 'AuthRepositoryException',
        message: 'Em recuperar senha',
        isError: true,
      );
    }
  }
}
