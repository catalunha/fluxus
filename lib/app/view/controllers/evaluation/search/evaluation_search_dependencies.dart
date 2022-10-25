import 'package:fluxus/app/data/b4a/table/evaluation/evaluation_repository_b4a.dart';
import 'package:fluxus/app/data/repositories/evaluation_repository.dart';
import 'package:fluxus/app/view/controllers/evaluation/search/evaluation_search_controller.dart';
import 'package:get/get.dart';

class EvaluationSearchDependencies implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EvaluationRepository>(
      () => EvaluationRepositoryB4a(),
    );
    // Get.lazyPut<HealthPlanRepository>(
    //   () => HealthPlanRepositoryB4a(),
    // );
    // Get.lazyPut<HealthPlanTypeRepository>(
    //   () => HealthPlanTypeRepositoryB4a(),
    // );

    Get.put<EvaluationSearchController>(
      EvaluationSearchController(
        evaluationRepository: Get.find(),
        // healthPlanRepository: Get.find(),
        // healthPlanTypeRepository: Get.find(),
      ),
    );
  }
}
