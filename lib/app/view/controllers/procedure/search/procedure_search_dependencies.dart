import 'package:fluxus/app/data/b4a/table/procedure/procedure_repository_b4a.dart';
import 'package:fluxus/app/data/repositories/procedure_repository.dart';
import 'package:fluxus/app/view/controllers/procedure/search/procedure_search_controller.dart';
import 'package:get/get.dart';

class ProcedureSearchDependencies implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProcedureRepository>(
      () => ProcedureRepositoryB4a(),
    );

    Get.put<ProcedureSearchController>(
      ProcedureSearchController(
        evaluationRepository: Get.find(),
      ),
    );
  }
}
