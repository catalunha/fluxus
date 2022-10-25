import 'package:fluxus/app/data/b4a/table/evaluation/evaluation_repository_b4a.dart';
import 'package:fluxus/app/data/repositories/evaluation_repository.dart';
import 'package:fluxus/app/view/controllers/evaluation/addedit/evaluation_addedit_controller.dart';
import 'package:get/get.dart';

class EvaluationAddEditDependencies implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EvaluationRepository>(
      () => EvaluationRepositoryB4a(),
    );

    Get.put<EvaluationAddEditController>(
      EvaluationAddEditController(
        evaluationRepository: Get.find(),
      ),
    );
  }
}
