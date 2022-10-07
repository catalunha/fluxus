import 'package:fluxus/app/data/b4a/table/user/user_repository_exception.dart';
import 'package:fluxus/app/data/repositories/user_repository.dart';
import 'package:fluxus/app/routes.dart';
import 'package:fluxus/app/view/controllers/utils/loader_mixin.dart';
import 'package:fluxus/app/view/controllers/utils/message_mixin.dart';
import 'package:get/get.dart';

class UserRegisterEmailController extends GetxController
    with LoaderMixin, MessageMixin {
  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  final UserRepository _userRepository;
  UserRegisterEmailController({required UserRepository userRepository})
      : _userRepository = userRepository;

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
      final user = await _userRepository.register(
        email: email,
        password: password,
      );
      if (user != null) {
        Get.offAllNamed(Routes.userLogin);
      } else {
        _message.value = MessageModel(
          title: 'Erro',
          message: 'Em registrar usuário',
          isError: true,
        );
      }
    } on UserRepositoryException catch (e) {
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
