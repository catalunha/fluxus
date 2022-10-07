import 'package:fluxus/app/view/controllers/user/login/login_controller.dart';
import 'package:get/get.dart';

class AuthLoginDependencies implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController(
          userRepository: Get.find(),
        ));
  }
}
