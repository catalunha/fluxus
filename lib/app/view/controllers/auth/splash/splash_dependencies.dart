import 'package:fluxus/app/data/b4a/databases/auth/auth_repository_b4a.dart';
import 'package:fluxus/app/data/repositories/auth_repository.dart';
import 'package:fluxus/app/view/controllers/auth/splash/splash_controller.dart';
import 'package:get/get.dart';

class SplashDependencies implements Bindings {
  @override
  void dependencies() {
    Get.put<AuthRepository>(
      AuthRepositoryB4a(),
    );
    // Get.put<AuthUseCase>(
    //   AuthUseCaseImpl(
    //     authRepository: Get.find(),
    //   ),
    // );
    Get.put<SplashController>(
      SplashController(
        authRepository: Get.find(),
      ),
      permanent: true,
    );
  }
}
