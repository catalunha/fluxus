import 'package:fluxus/app/data/b4a/databases/user/user_repository_b4a.dart';
import 'package:fluxus/app/data/repositories/user_repository.dart';
import 'package:fluxus/app/view/controllers/splash/splash_controller.dart';
import 'package:get/get.dart';

class SplashDependencies implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserRepository>(
      () => UserRepositoryB4a(),
    );

    Get.put<SplashController>(
      SplashController(
        userRepository: Get.find(),
      ),
      permanent: true,
    );
  }
}
