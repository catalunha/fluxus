import 'package:fluxus/app/data/b4a/databases/auth/auth_repository_exception.dart';
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
      if (user != null) {
        Get.offAllNamed(Routes.authLogin);
      } else {
        _message.value = MessageModel(
          title: 'Erro',
          message: 'Em registrar usuário',
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
}
