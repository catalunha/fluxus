import 'package:fluxus/app/view/controllers/user/register/email/user_register_email_controller.dart';
import 'package:get/get.dart';

class UserRegisterEmailDependencies implements Bindings {
  @override
  void dependencies() {
    Get.put<UserRegisterEmailController>(
      UserRegisterEmailController(
        userRepository: Get.find(),
      ),
    );
  }
}
