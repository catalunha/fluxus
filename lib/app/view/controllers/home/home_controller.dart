import 'package:fluxus/app/data/repositories/auth_repository.dart';
import 'package:fluxus/app/routes.dart';
import 'package:fluxus/app/view/controllers/utils/loader_mixin.dart';
import 'package:fluxus/app/view/controllers/utils/message_mixin.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with LoaderMixin, MessageMixin {
  final AuthRepository _authRepository;

  HomeController({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  final _loading = false.obs;
  set loading(bool value) => _loading(value);
  final _message = Rxn<MessageModel>();

  @override
  void onInit() async {
    loaderListener(_loading);
    messageListener(_message);
    super.onInit();
  }

  Future<void> logout() async {
    //print('em home logout ');
    await _authRepository.logout();
    Get.offAllNamed(Routes.authLogin);
  }
}
