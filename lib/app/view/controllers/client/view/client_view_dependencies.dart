import 'package:fluxus/app/data/b4a/table/profile/profile_repository_b4a.dart';
import 'package:fluxus/app/data/repositories/profile_repository.dart';
import 'package:fluxus/app/view/controllers/client/view/client_view_controller.dart';
import 'package:get/get.dart';

class ClientViewDependencies implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileRepository>(
      () => ProfileRepositoryB4a(),
    );

    Get.put<ClientViewController>(
      ClientViewController(
        profileRepository: Get.find(),
      ),
    );
  }
}
