import 'package:fluxus/app/data/b4a/table/health_plan/health_plan_repository_b4a.dart';
import 'package:fluxus/app/data/b4a/table/health_plan_type/health_plan_type_repository_b4a.dart';
import 'package:fluxus/app/data/b4a/table/profile/profile_repository_b4a.dart';
import 'package:fluxus/app/data/repositories/health_plan_repository.dart';
import 'package:fluxus/app/data/repositories/health_plan_type_repository.dart';
import 'package:fluxus/app/data/repositories/profile_repository.dart';
import 'package:fluxus/app/view/controllers/profile/client/addedit/client_addedit_controller.dart';
import 'package:get/get.dart';

class ClientAddEditDependencies implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileRepository>(
      () => ProfileRepositoryB4a(),
    );
    Get.lazyPut<HealthPlanRepository>(
      () => HealthPlanRepositoryB4a(),
    );
    Get.lazyPut<HealthPlanTypeRepository>(
      () => HealthPlanTypeRepositoryB4a(),
    );

    Get.put<ClientAddEditController>(
      ClientAddEditController(
        profileRepository: Get.find(),
        healthPlanRepository: Get.find(),
        healthPlanTypeRepository: Get.find(),
      ),
    );
  }
}
