import 'package:fluxus/app/data/b4a/auth/auth_repository_exception.dart';
import 'package:fluxus/app/data/repositories/auth_repository.dart';
import 'package:fluxus/app/routes.dart';
import 'package:fluxus/app/view/controllers/utils/loader_mixin.dart';
import 'package:fluxus/app/view/controllers/utils/message_mixin.dart';
import 'package:get/get.dart';

class AuthRegisterEmailController extends GetxController
    with LoaderMixin, MessageMixin {
  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  final AuthRepository _authRepository;
  AuthRegisterEmailController({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  void onInit() {
    super.onInit();
    loaderListener(_loading);
    messageListener(_message);
  }

  Future<void> registerEmail({
    required String email,
    required String password,
  }) async {
    try {
      _loading(true);
      final user = await _authRepository.registerEmail(
        email: email,
        password: password,
      );
      //print('após registerEmail ');
      if (user != null) {
        //print('Success register');
        Get.offAllNamed(Routes.authLogin);
      } else {
        //print('user==null in register');
        // _authUseCase.logout();
        _message.value = MessageModel(
          title: 'Erro',
          message: 'Em registrar usuário',
          isError: true,
        );
      }
    } on AuthRepositoryException catch (e) {
      //print('error em  registerEmail');
      // _authRepository.logout();
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
}
