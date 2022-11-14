import 'package:fluxus/app/view/controllers/splash/splash_controller.dart';
import 'package:get/get.dart';

class AllowedAccess {
  static bool consultFor(List<String> officeIdListAutorized) {
    final splashController = Get.find<SplashController>();
    return splashController.officeIdList
        .any((element) => officeIdListAutorized.contains(element));
  }
}
