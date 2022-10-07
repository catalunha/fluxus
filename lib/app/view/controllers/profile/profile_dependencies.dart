import 'package:fluxus/app/data/b4a/table/profile/profile_repository_b4a.dart';
import 'package:fluxus/app/data/repositories/profile_repository.dart';
import 'package:fluxus/app/view/controllers/profile/profile_controller.dart';
import 'package:get/get.dart';

class ProfileDependencies implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileRepository>(
      () => ProfileRepositoryB4a(),
    );

    Get.put<ProfileController>(
      ProfileController(
        profileRepository: Get.find(),
      ),
    );
  }
}
