import 'package:fluxus/app/data/b4a/table/office/office_repository_b4a.dart';
import 'package:fluxus/app/data/b4a/table/profile/profile_repository_b4a.dart';
import 'package:fluxus/app/data/repositories/office_repository.dart';
import 'package:fluxus/app/data/repositories/profile_repository.dart';
import 'package:fluxus/app/view/controllers/team/search/team_search_controller.dart';
import 'package:get/get.dart';

class TeamSearchDependencies implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileRepository>(
      () => ProfileRepositoryB4a(),
    );
    Get.lazyPut<OfficeRepository>(
      () => OfficeRepositoryB4a(),
    );
    Get.put<TeamSearchController>(
      TeamSearchController(
        profileRepository: Get.find(),
        officeRepository: Get.find(),
      ),
    );
  }
}
