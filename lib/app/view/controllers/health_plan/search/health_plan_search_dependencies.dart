import 'package:fluxus/app/data/b4a/table/health_plan/health_plan_repository_b4a.dart';
import 'package:fluxus/app/data/repositories/health_plan_repository.dart';
import 'package:fluxus/app/view/controllers/health_plan/search/health_plan_search_controller.dart';
import 'package:get/get.dart';

class HealthPlanSearchDependencies implements Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<ProfileRepository>(
    //   () => ProfileRepositoryB4a(),
    // );
    Get.lazyPut<HealthPlanRepository>(
      () => HealthPlanRepositoryB4a(),
    );
    // Get.lazyPut<HealthPlanTypeRepository>(
    //   () => HealthPlanTypeRepositoryB4a(),
    // );

    Get.put<HealthPlanSearchController>(
      HealthPlanSearchController(
        healthPlanRepository: Get.find(),
        // healthPlanRepository: Get.find(),
        // healthPlanTypeRepository: Get.find(),
      ),
    );
  }
}
